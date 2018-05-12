SELECT reservations.date as date, locauxTimeList.timeBloc, locauxTimeList.numeropavillon, locauxTimeList.numerolocal, locauxTimeList.categorieId, reservations.evenementid as evenementid FROM
 (SELECT * FROM possibleTimeBloc CROSS JOIN (SELECT numeropavillon, numerolocal, categorieid FROM locaux) AS locauxNames) AS locauxTimeList
 LEFT JOIN reservations ON locauxTimeList.timeBloc = reservations.numerobloc AND locauxTimeList.numeropavillon = reservations.numeropavillon AND locauxTimeList.numerolocal = reservations.numerolocal
WHERE evenementid IS NOT NULL
ORDER BY date, timeBloc;

-- fill possible time values
create table possibleTimeBloc (timeBloc int);

CREATE OR REPLACE FUNCTION fill_possible() RETURNS void AS $$
DECLARE
 time_id INTEGER;
BEGIN
 TRUNCATE TABLE possibleTimeBloc;
 time_id := 0;
 WHILE time_id  < 96
  LOOP
   INSERT INTO possibleTimeBloc VALUES(time_id);
   time_id := time_id + 1;
  end loop;
END; $$
LANGUAGE 'plpgsql';

SELECT fill_possible();