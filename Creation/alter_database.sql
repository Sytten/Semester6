/* DEFAULT BLOC VALUES */
ALTER TABLE categories ALTER blocDebut SET DEFAULT 0;
ALTER TABLE categories ALTER blocFin SET DEFAULT 95;

/* POSITIVE PRIMARY KEY */
ALTER TABLE status DROP CONSTRAINT IF EXISTS positive_pk;
ALTER TABLE status ADD CONSTRAINT positive_pk CHECK(statusid >= 0);
ALTER TABLE locaux DROP CONSTRAINT IF EXISTS positive_pk;
ALTER TABLE locaux ADD CONSTRAINT positive_pk CHECK(numerolocal >= 0);
ALTER TABLE facultes DROP CONSTRAINT IF EXISTS positive_pk;
ALTER TABLE facultes ADD CONSTRAINT positive_pk CHECK(faculteid >= 0);
ALTER TABLE evenements DROP CONSTRAINT IF EXISTS positive_pk;
ALTER TABLE evenements ADD CONSTRAINT positive_pk CHECK(evenementid >= 0);
ALTER TABLE departements DROP CONSTRAINT IF EXISTS positive_pk;
ALTER TABLE departements ADD CONSTRAINT positive_pk CHECK(departementid >= 0);
ALTER TABLE categories DROP CONSTRAINT IF EXISTS positive_pk;
ALTER TABLE categories ADD CONSTRAINT positive_pk CHECK(categorieid >= 0);
ALTER TABLE caracteristiques DROP CONSTRAINT IF EXISTS positive_pk;
ALTER TABLE caracteristiques ADD CONSTRAINT positive_pk CHECK(equipementid >= 0);
ALTER TABLE campus DROP CONSTRAINT IF EXISTS positive_pk;
ALTER TABLE campus ADD CONSTRAINT positive_pk CHECK(campusid >= 0);

/* BLOC DOMAIN */
ALTER TABLE categories DROP CONSTRAINT IF EXISTS bloc_domain;
ALTER TABLE categories ADD CONSTRAINT bloc_domain CHECK(blocDebut BETWEEN 0 and 95 AND blocFin BETWEEN 0 and 95);
ALTER TABLE bloctempspossible DROP CONSTRAINT IF EXISTS bloc_domain;
ALTER TABLE bloctempspossible ADD CONSTRAINT bloc_domain CHECK(bloctempsid BETWEEN 0 and 95);
ALTER TABLE reservations DROP CONSTRAINT IF EXISTS bloc_domain;
ALTER TABLE reservations ADD CONSTRAINT bloc_domain CHECK(numerobloc BETWEEN 0 and 95);

/* RENAME LOCAUX COLUMNS */
ALTER TABLE locaux RENAME LOC_NUMEROPAVILLON TO NUMEROPAVILLONPARENT;
ALTER TABLE locaux RENAME LOC_NUMEROLOCAL TO NUMEROLOCALPARENT;

/* CHANGE LOGS COLUMN TYPE */
ALTER TABLE logs ALTER COLUMN logdate TYPE TIMESTAMP;

/* CHANGE CONSTRAINT OF EVENT TO CASCADE DELETE */
ALTER TABLE public.reservations DROP CONSTRAINT fk_reservat_evenement_evenemen;
ALTER TABLE public.reservations
  ADD CONSTRAINT fk_reservat_evenement_evenemen FOREIGN KEY (evenementid)
    REFERENCES evenements (evenementid)
      ON DELETE CASCADE ON UPDATE RESTRICT;

/* TRUNCATE ALL TABLES FUNCTION */
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
