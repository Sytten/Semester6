SELECT reservations.date as date, locauxTimeList.timeBloc, locauxTimeList.numeropavillon, locauxTimeList.numerolocal, locauxTimeList.categorieId, reservations.evenementid as evenementid FROM
 (SELECT * FROM possibleTimeBloc CROSS JOIN (SELECT numeropavillon, numerolocal, categorieid FROM locaux) AS locauxNames) AS locauxTimeList
 LEFT JOIN reservations ON locauxTimeList.timeBloc = reservations.numerobloc AND locauxTimeList.numeropavillon = reservations.numeropavillon AND locauxTimeList.numerolocal = reservations.numerolocal
WHERE evenementid IS NOT NULL -- TODO remove
ORDER BY date, timeBloc;