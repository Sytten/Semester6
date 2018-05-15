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

DROP TRIGGER IF EXISTS log_users ON membres;
CREATE TRIGGER log_users
AFTER INSERT OR UPDATE OR DELETE ON membres
    FOR EACH ROW EXECUTE PROCEDURE trail_user();


/* TRAIL EVENEMENTS */
CREATE OR REPLACE FUNCTION trail_events() RETURNS TRIGGER AS $$
	begin
		IF (TG_OP = 'DELETE') THEN
		 INSERT INTO logs(cip, numeropavillon, numeroLocal, logDate, message) VALUES
		  (OLD.cip, OLD.numeropavillon, OLD.numeroLocal, now(), 'Event deleted bloc=' || OLD.numerobloc || ' event_date=' || OLD.date || ' event_id=' || OLD.evenementid);
		ELSIF (TG_OP = 'UPDATE') THEN
		 INSERT INTO logs(cip, numeropavillon, numeroLocal, logDate, message) VALUES
		  (NEW.cip, NEW.numeropavillon, NEW.numeroLocal, now(), 'Event updated bloc=' || NEW.numerobloc || ' event_date=' || NEW.date || ' event_id=' || NEW.evenementid);
		ELSIF (TG_OP = 'INSERT') THEN
		 INSERT INTO logs(cip, numeropavillon, numeroLocal, logDate, message) VALUES
		  (NEW.cip, NEW.numeropavillon, NEW.numeroLocal, now(), 'Event created bloc=' || NEW.numerobloc || ' event_date=' || NEW.date || ' event_id=' || NEW.evenementid);
		END IF;
		RETURN NULL;
	end;
 $$ LANGUAGE plpgsql;

 DROP TRIGGER IF EXISTS log_events ON reservations;
CREATE TRIGGER log_events
AFTER INSERT OR UPDATE OR DELETE ON reservations
    FOR EACH ROW EXECUTE PROCEDURE trail_events();