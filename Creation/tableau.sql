SELECT reservations.date as date, locauxTimeList.timeBloc as dayTime,
 (locauxTimeList.numeropavillon || '-' || locauxTimeList.numerolocal) as local,
 locauxTimeList.categorieId, reservations.evenementid as evenementid, e.nom FROM
 (SELECT * FROM possibleTimeBloc CROSS JOIN (SELECT numeropavillon, numerolocal, categorieid FROM locaux) AS locauxNames) AS locauxTimeList
 LEFT JOIN reservations ON locauxTimeList.timeBloc = reservations.numerobloc AND locauxTimeList.numeropavillon = reservations.numeropavillon AND locauxTimeList.numerolocal = reservations.numerolocal
 LEFT JOIN evenements e on reservations.evenementid = e.evenementid -- ajout nom d'evenement
ORDER BY date, timeBloc;

-- WHERE evenementid IS NOT NULL -- TODO remove