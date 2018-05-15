/* ADD DEFAULT CONSTRAINT TO CATEGORIES */
ALTER TABLE categories ALTER blocDebut SET DEFAULT 0;
ALTER TABLE categories ALTER blocFin SET DEFAULT 95;

ALTER TABLE locaux RENAME LOC_NUMEROPAVILLON TO NUMEROPAVILLONPARENT;
ALTER TABLE locaux RENAME LOC_NUMEROLOCAL TO NUMEROLOCALPARENT;

ALTER TABLE logs ALTER COLUMN logdate TYPE TIMESTAMP;

/* CHANGE CONSTRAINT OF EVENT TO CASCADE DELETE */
ALTER TABLE public.reservations DROP CONSTRAINT fk_reservat_evenement_evenemen;
ALTER TABLE public.reservations
  ADD CONSTRAINT fk_reservat_evenement_evenemen FOREIGN KEY (evenementid)
    REFERENCES evenements (evenementid)
      ON DELETE CASCADE ON UPDATE RESTRICT;


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
