/* TABLE BLOCTEMPSPOSSIBLE */
/* table des bloc de temps possible (0-96) et leur nom */
CREATE TABLE IF NOT EXISTS blocTempsPossible (
  blocTempsId  INT,
  blocTempsNom VARCHAR
);
CREATE OR REPLACE FUNCTION remplir_temps_possible()
  RETURNS VOID AS $$
DECLARE
  temps_id INTEGER;
  heure    INTEGER;
  minute   INTEGER;
BEGIN
  TRUNCATE TABLE blocTempsPossible;
  temps_id := 0;
  heure := 0;
  minute := 0;
  WHILE temps_id < 96
  LOOP
    heure = temps_id / 4;
    minute = (temps_id % 4) * 15;
    INSERT INTO blocTempsPossible (blocTempsId, blocTempsNom)
    VALUES (temps_id, heure || 'h' || minute);
    temps_id := temps_id + 1;
  END LOOP;
END; $$
LANGUAGE 'plpgsql';

/* PROCEDURE TABLEAU */
DROP FUNCTION IF EXISTS tableau(tableauDate DATE, tableauDebut INT, tableauFin INT, tableauCategorie INT );
CREATE OR REPLACE FUNCTION tableau(tableauDate DATE, tableauDebut INT, tableauFin INT, tableauCategorie INT)
  RETURNS
    TABLE(tempsId INTEGER, tempsNom VARCHAR, localNom TEXT, evenementNom VARCHAR) AS $$
BEGIN
  RETURN QUERY
  SELECT
    horaire.tempsId,
    horaire.tempsNom,
    horaire.localNom,
    horaire.evenementNom
  FROM (SELECT
          reservations.date                                                    AS date,
          locauxTimeList.blocTempsId                                           AS tempsId,
          locauxTimeList.blocTempsNom                                          AS tempsNom,
          (locauxTimeList.numeropavillon || '-' || locauxTimeList.numerolocal) AS localNom,
          locauxTimeList.categorieId                                           AS categorieId,
          reservations.evenementid                                             AS evenementId,
          e.nom                                                                AS evenementNom
        FROM ((SELECT *
               FROM blocTempsPossible
               CROSS JOIN (SELECT
                             numeropavillon,
                             numerolocal,
                             categorieid
                           FROM locaux) AS locauxNames) AS locauxTimeList
               LEFT JOIN reservations ON locauxTimeList.blocTempsId = reservations.numerobloc
                                      AND locauxTimeList.numeropavillon = reservations.numeropavillon
                                      AND locauxTimeList.numerolocal = reservations.numerolocal
                                      AND reservations.date = tableauDate
               LEFT JOIN evenements e ON reservations.evenementid = e.evenementid))
        AS horaire
  WHERE (horaire.date = tableauDate OR horaire.date IS NULL)
        AND horaire.categorieId = tableauCategorie
        AND horaire.tempsId >= tableauDebut
        AND horaire.tempsId <= tableauFin
  ORDER BY horaire.tempsId;
END
$$ LANGUAGE plpgsql;

-- SELECT * FROM TABLEAU('2018-04-05', 30, 33, 110);
