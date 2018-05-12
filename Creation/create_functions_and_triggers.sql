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
		 INSERT INTO logs(cip, numeropavillon, numero, logDate, message) VALUES
		  (OLD.cip, null, null, now(), 'user deleted');
		ELSIF (TG_OP = 'UPDATE') THEN
		 INSERT INTO logs(cip, numeropavillon, numero, logDate, message) VALUES
		  (NEW.cip, null, null, now(), 'user updated');
		ELSIF (TG_OP = 'INSERT') THEN
		 INSERT INTO logs(cip, numeropavillon, numero, logDate, message) VALUES
		  (NEW.cip, null, null, now(), 'user created');
		END IF;
		RETURN NULL;
	end;
 $$ LANGUAGE plpgsql;

CREATE TRIGGER logs
AFTER INSERT OR UPDATE OR DELETE ON members
    FOR EACH ROW EXECUTE PROCEDURE trail_user();