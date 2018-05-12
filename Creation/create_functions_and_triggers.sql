/* ADD DEFAULT CONSTRAINT TO CATEGORIES */
ALTER TABLE categories ALTER blocDebut SET DEFAULT 0;
ALTER TABLE categories ALTER blocFin SET DEFAULT 95;

/* ADD CALENDAR VIEW */
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

CREATE OR REPLACE FUNCTION ajout_reservation() RETURNS TRIGGER AS $$
DECLARE
  event_id INTEGER;
BEGIN
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

DROP TRIGGER IF EXISTS ajout_evenement ON calendrier;
CREATE TRIGGER ajout_evenement
INSTEAD OF INSERT ON calendrier
    FOR EACH ROW EXECUTE PROCEDURE ajout_reservation();

/* TRUNCATE ALL TABLES */
CREATE OR REPLACE FUNCTION truncate_all_tables() RETURNS void AS $$
DECLARE
    statements CURSOR FOR
        SELECT tablename FROM pg_tables
        WHERE schemaname = 'public';
BEGIN
    FOR stmt IN statements LOOP
        EXECUTE 'TRUNCATE TABLE ' || quote_ident(stmt.tablename) || ' CASCADE;';
    END LOOP;
END;
$$ LANGUAGE plpgsql;

/* TRAIL USER */
CREATE OR REPLACE FUNCTION trail_user() RETURNS TRIGGER AS $$
	begin
		IF (TG_OP = 'DELETE') THEN
		 INSERT INTO logs(cip, numeropavillon, numeroLocal, logDate, message) VALUES
		  (OLD.cip, null, null, now(), 'user deleted');
		ELSIF (TG_OP = 'UPDATE') THEN
		 INSERT INTO logs(cip, numeropavillon, numeroLocal, logDate, message) VALUES
		  (NEW.cip, null, null, now(), 'user updated');
		ELSIF (TG_OP = 'INSERT') THEN
		 INSERT INTO logs(cip, numeropavillon, numeroLocal, logDate, message) VALUES
		  (NEW.cip, null, null, now(), 'user created');
		END IF;
		RETURN NULL;
	end;
 $$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS logs ON membres;
CREATE TRIGGER logs
AFTER INSERT OR UPDATE OR DELETE ON membres
    FOR EACH ROW EXECUTE PROCEDURE trail_user();
