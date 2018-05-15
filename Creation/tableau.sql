/* TABLE BLOCTEMPSPOSSIBLE */
/* table des bloc de temps possible (0-96) et leur nom */
create table if not exists blocTempsPossible (blocTempsId int, blocTempsNom VARCHAR);
CREATE OR REPLACE FUNCTION remplir_temps_possible() RETURNS void AS $$
DECLARE
 temps_id INTEGER;
 heure INTEGER;
 minute INTEGER;
BEGIN
 TRUNCATE TABLE blocTempsPossible;
 temps_id := 0;
 heure := 0;
 minute := 0;
 WHILE temps_id  < 96
  LOOP
   heure = temps_id / 4;
   minute = (temps_id % 4) * 15;
   INSERT INTO blocTempsPossible(blocTempsId, blocTempsNom)
	VALUES(temps_id, heure || 'h' || minute);
   temps_id := temps_id + 1;
  end loop;
END; $$
LANGUAGE 'plpgsql';

/* VUE HORAIRE */
DROP VIEW IF EXISTS horaire;
CREATE VIEW horaire AS
 SELECT
  reservations.date AS horaireDate,
  locauxTimeList.blocTempsId AS horaireTempsId,
  locauxTimeList.blocTempsNom as horaireTempsNom,
  (locauxTimeList.numeropavillon || '-' || locauxTimeList.numerolocal) AS horaireLocalNom,
  locauxTimeList.categorieId AS horaireCategorieId,
  reservations.evenementid AS horaireEvenementId,
  e.nom AS horaireNomEvenement
 FROM
  (SELECT * FROM blocTempsPossible CROSS JOIN (SELECT numeropavillon, numerolocal, categorieid FROM locaux) AS locauxNames) AS locauxTimeList
  LEFT JOIN reservations ON locauxTimeList.blocTempsId = reservations.numerobloc AND locauxTimeList.numeropavillon = reservations.numeropavillon AND locauxTimeList.numerolocal = reservations.numerolocal
  LEFT JOIN evenements e on reservations.evenementid = e.evenementid -- ajout nom d'evenement
 ORDER BY date, blocTempsId;

/* PROCEDURE TABLEAU */
DROP FUNCTION IF EXISTS tableau(tableauDate DATE, tableauDebut INT, tableauFin INT, tableauCategorie INT);
CREATE OR REPLACE FUNCTION tableau(tableauDate DATE, tableauDebut INT, tableauFin INT, tableauCategorie INT) RETURNS
 TABLE(tempsNom VARCHAR, localNom TEXT, evenementNom VARCHAR) AS $$
 BEGIN
  RETURN QUERY
   SELECT horaireTempsNom, horaireLocalNom, horaireNomEvenement FROM horaire
   WHERE (horaireDate = tableauDate OR horaireDate IS NULL)
         AND horaireCategorieId = tableauCategorie
         AND horaireTempsId >= tableauDebut
         AND horaireTempsId <= tableauFin
  ORDER BY horaireTempsNom;
 END
$$ LANGUAGE plpgsql;

 -- SELECT * FROM TABLEAU('2018-04-05', 30, 33, 110);