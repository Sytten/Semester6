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

/* AJOUT DE LA RESERVATION */
CREATE OR REPLACE FUNCTION ajout_reservation() RETURNS TRIGGER AS $$
DECLARE
  event_id INTEGER;
BEGIN
  -- Verify debut fin of categorie
  SELECT verification_plage_categorie(NEW.numerolocal, NEW.numeropavillon, NEW.blocDebut, NEW.blocFin);

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
