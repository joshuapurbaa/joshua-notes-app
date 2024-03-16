BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "note" (
    "id" serial PRIMARY KEY,
    "text" text NOT NULL
);


--
-- MIGRATION VERSION FOR joshua_notes
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('joshua_notes', '20240316000544439', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240316000544439', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20240115074235544', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240115074235544', "timestamp" = now();


COMMIT;
