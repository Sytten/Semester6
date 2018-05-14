/* VUE HORAIRE */
DROP VIEW IF EXISTS horaire;
CREATE VIEW horaire AS
 SELECT
  reservations.date AS horaireDate,
  locauxTimeList.timeBloc AS horaireDayTimeBloc,
  (locauxTimeList.numeropavillon || '-' || locauxTimeList.numerolocal) AS horaireLocalNom,
  locauxTimeList.categorieId AS horaireCategorieId,
  reservations.evenementid AS horaireEvenementId,
  e.nom AS horaireNomEvenement
 FROM
  (SELECT * FROM possibleTimeBloc CROSS JOIN (SELECT numeropavillon, numerolocal, categorieid FROM locaux) AS locauxNames) AS locauxTimeList
  LEFT JOIN reservations ON locauxTimeList.timeBloc = reservations.numerobloc AND locauxTimeList.numeropavillon = reservations.numeropavillon AND locauxTimeList.numerolocal = reservations.numerolocal
  LEFT JOIN evenements e on reservations.evenementid = e.evenementid -- ajout nom d'evenement
 ORDER BY date, timeBloc;

/* PROCEDURE TABLEAU */
DROP FUNCTION IF EXISTS tableau(tableauDate DATE, tableauDebut INT, tableauFin INT, tableauCategorie INT);
CREATE OR REPLACE FUNCTION tableau(tableauDate DATE, tableauDebut INT, tableauFin INT, tableauCategorie INT) RETURNS
 TABLE(date DATE, dayTimeBloc INT, localNom TEXT, evenementNom VARCHAR) AS $$
 BEGIN
  RETURN QUERY
   SELECT horaireDate, horaireDayTimeBloc, horaireLocalNom, horaireNomEvenement FROM horaire
   WHERE (horaireDate = tableauDate OR horaireDate IS NULL) AND horaireCategorieId = tableauCategorie;
 END
$$ LANGUAGE plpgsql;

-- SELECT * FROM TABLEAU('2018-04-05', 0, 96, 110);