SELECT 'CREATE DATABASE panda_db' WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = 'panda_db')\gexec
SELECT E'CREATE USER panda PASSWORD \'${PANDA_DB_PASSWORD}\'' WHERE NOT EXISTS (SELECT FROM pg_catalog.pg_roles WHERE rolname = 'panda')\gexec
ALTER ROLE panda SET search_path = doma_panda,public;
CREATE EXTENSION IF NOT EXISTS pg_cron;
GRANT USAGE ON SCHEMA cron TO panda;
\c panda_db;
CREATE SCHEMA IF NOT EXISTS partman;
CREATE EXTENSION IF NOT EXISTS pg_partman SCHEMA partman;

--- schema version
CREATE TABLE IF NOT EXISTS  pandadb_version (
	component varchar(100) NOT NULL,
	major INT NOT NULL,
	minor INT NOT NULL,
	patch INT NOT NULL
) ;
GRANT ALL ON pandadb_version TO panda;