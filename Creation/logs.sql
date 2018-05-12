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
