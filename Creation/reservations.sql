/* VUE CALENDRIER */
CREATE OR REPLACE VIEW calendrier AS
 SELECT
  numeropavillon,
  numerolocal,
  date,
  cip,
  MIN(numerobloc) AS blocDebut,
  MAX(numerobloc) AS blocFin
  FROM evenements
  JOIN reservations USING (evenementid)
  GROUP BY numeropavillon, numerolocal, date, cip;

/* VERIFICATION SI PLAGE LIBRE */
CREATE OR REPLACE FUNCTION verification_disponibilite_plage(local INTEGER, pavillon VARCHAR(16), debut INTEGER, fin INTEGER, date_res TIMESTAMP) RETURNS VOID AS $$
DECLARE
  reservations_count INTEGER;
BEGIN
  WHILE debut <= fin
  LOOP
    reservations_count := (SELECT COUNT(*) FROM reservations WHERE (
           numerolocal=local AND numeropavillon=pavillon AND date=date_res AND numerobloc=debut
        ));
    IF (reservations_count != 0) THEN
      RAISE EXCEPTION 'Local est deja reserve pour cette periode';
    END IF;
    debut := debut + 1;
  END LOOP;
END;
$$ LANGUAGE plpgsql;

/* VERIFICATION DES SOUS-LOCAUX */
CREATE OR REPLACE FUNCTION verification_sous_locaux(local INTEGER, pavillon VARCHAR(16), debut INTEGER, fin INTEGER, date_res TIMESTAMP) RETURNS VOID AS $$
DECLARE
  sous_local locaux%ROWTYPE;
BEGIN
  FOR sous_local IN SELECT * FROM locaux WHERE numerolocalparent=local and numeropavillonparent=pavillon LOOP
    PERFORM verification_disponibilite_plage(sous_local.numerolocal, sous_local.numeropavillon, debut, fin, date_res);
  END LOOP;
END;
$$ LANGUAGE plpgsql;

/* VERIFICATION DE LA PLAGE HORAIRE DE LA CATEGORIE */
CREATE OR REPLACE FUNCTION verification_plage_categorie(local INTEGER, pavillon VARCHAR(16), debut INTEGER, fin INTEGER) RETURNS VOID AS $$
DECLARE
  categorie INTEGER;
  categorie_debut INTEGER;
  categorie_fin INTEGER;
BEGIN
  SELECT categorieid INTO categorie FROM locaux WHERE numerolocal=local AND numeropavillon=pavillon;
  SELECT blocdebut, blocfin INTO categorie_debut, categorie_fin FROM categories WHERE categorieid=categorie;

  IF debut < categorie_debut OR fin > categorie_fin THEN
    RAISE EXCEPTION 'Reservation en dehors de la plage de la categorie';
  END IF;
END;
$$ LANGUAGE plpgsql;

/* VERIFICATION DROIT RESERVATION */
CREATE OR REPLACE FUNCTION verification_droit_reservation(reservation calendrier) RETURNS VOID AS $$
DECLARE
  categorie INTEGER;
  sum_plusde24h INTEGER;
  sum_ecriture INTEGER;
BEGIN
  SELECT categorieid INTO categorie FROM locaux
  WHERE numerolocal=reservation.numerolocal AND numeropavillon=reservation.numeropavillon;


  SELECT SUM(ecriture), SUM(plusde24h) INTO sum_ecriture, sum_plusde24h FROM privilegesreservation
  WHERE categorieid=categorie AND statusid IN (SELECT statusid
                                               FROM statusmembre
                                               WHERE cip=reservation.cip);

  IF sum_ecriture = 0 OR sum_ecriture IS NULL THEN
    RAISE EXCEPTION 'Vous ne pouvez pas reserver ce local';
  END IF;
END;
$$ LANGUAGE plpgsql;

/* AJOUT DE LA RESERVATION */
CREATE OR REPLACE FUNCTION ajout_reservation() RETURNS TRIGGER AS $$
DECLARE
  event_id INTEGER;
BEGIN
  -- Verification des permissions
  PERFORM verification_droit_reservation(NEW);

  -- Verification sous-locaux
  PERFORM verification_sous_locaux(NEW.numerolocal, NEW.numeropavillon, NEW.blocDebut, NEW.blocFin, NEW.date);

  -- Verification debut fin de la categorie
  PERFORM verification_plage_categorie(NEW.numerolocal, NEW.numeropavillon, NEW.blocDebut, NEW.blocFin);

  -- Create new event
  SELECT MAX(evenementid) INTO event_id FROM evenements;
  IF event_id IS NULL THEN
    event_id := 0;
  ELSE
    event_id := event_id + 1;
  END IF;
  INSERT INTO evenements VALUES (event_id);

  -- Create reservations
  WHILE NEW.blocdebut <= NEW.blocfin
  LOOP
    INSERT INTO reservations VALUES (NEW.numeropavillon, NEW.numerolocal, NEW.date, NEW.blocDebut, event_id, NEW.cip);
    NEW.blocdebut := NEW.blocdebut + 1;
  END LOOP;

  RETURN NULL;
END;
$$ LANGUAGE plpgsql;

/* AJOUT DU TRIGGER SUR LA VUE */
DROP TRIGGER IF EXISTS ajout_evenement ON calendrier;
CREATE TRIGGER ajout_evenement
INSTEAD OF INSERT ON calendrier
    FOR EACH ROW EXECUTE PROCEDURE ajout_reservation();
