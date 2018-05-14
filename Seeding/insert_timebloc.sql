/* TABLE des bloc de temps possible (0-96) et leur nom */
create table if not exists possibleTimeBloc (timeBloc int);
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