-- Generated by Ora2Pg, the Oracle database Schema converter, version 23.2
-- Copyright 2000-2022 Gilles DAROLD. All rights reserved.
-- DATASOURCE: dbi:Oracle:ADCR

SET client_encoding TO 'UTF8';

SET search_path = doma_pandameta,public;
\set ON_ERROR_STOP ON

SET check_function_bodies = false;





CREATE OR REPLACE PROCEDURE atlas_pandameta.do_grants (obj_type text, obj_name text,owner_name text) AS $body$
DECLARE

	
	
	privs varchar(100);
BEGIN

	 -- need to put " " around the object names, because some users create the objects with preserved character case.
	IF (obj_name NOT IN ('DO_GRANTS','GRANTS_UPDATE','CREATE_SYN4EXIST_OBJ') AND substr(obj_name,1,4)<>'BIN$') THEN

		IF obj_type IN ('TABLE') THEN
        	 	EXECUTE 'GRANT SELECT,INSERT,UPDATE,DELETE on "'||obj_name||'" to ATLAS_PANDA_WRITEROLE';
		        EXECUTE 'GRANT SELECT on "'||obj_name||'" to ATLAS_PANDA_READROLE';
		elsif obj_type = 'SEQUENCE' THEN
	        	EXECUTE 'GRANT SELECT on "'||obj_name||'" to ATLAS_PANDA_WRITEROLE';
		        EXECUTE 'GRANT SELECT on "'||obj_name||'" to ATLAS_PANDA_READROLE';
		elsif obj_type IN ('VIEW', 'MATERIALIZED VIEW') THEN
			privs := ' SELECT,INSERT,UPDATE,DELETE ';
			FOR i IN 1..2 LOOP /*if fails on the first loop with error 01720, then goes to the EXEPTION and changes the statement */
				BEGIN
					EXECUTE 'GRANT '|| privs ||' on "'|| obj_name||'" to ATLAS_PANDA_WRITEROLE';
				        EXECUTE 'GRANT SELECT on "'||obj_name||'" to ATLAS_PANDA_READROLE';
					EXIT;
				EXCEPTION
					WHEN SQLSTATE '50001' THEN
						privs := ' SELECT ';
				END;
			END LOOP;
		elsif obj_type IN ('PROCEDURE', 'PACKAGE','FUNCTION', 'TYPE') AND obj_name <> 'CREATE_SYN' THEN
	         	EXECUTE 'GRANT EXECUTE on "'||obj_name||'" to ATLAS_PANDA_WRITEROLE';
		        EXECUTE 'GRANT EXECUTE on "'||obj_name||'" to ATLAS_PANDA_READROLE';
		END IF;
	END IF;
END;
$body$
LANGUAGE PLPGSQL
SECURITY DEFINER
;
ALTER PROCEDURE atlas_pandameta.do_grants (obj_type text, obj_name text,owner_name text) OWNER TO panda;
-- REVOKE ALL ON PROCEDURE atlas_pandameta.do_grants (obj_type text, obj_name text,owner_name text) FROM PUBLIC;





CREATE OR REPLACE PROCEDURE atlas_pandameta.grant_privs4exist_obj (owner_name text ) AS $body$
DECLARE

	
	
	privs varchar(100);
  rec RECORD;
BEGIN
 -- need to put " " around the object names, because some users create the objects with preserved character case.
	-- IMPORTANT - GRANT OBJECT PRIVILEGES FIRST TO THE TABLES
	FOR rec in (SELECT object_name as obj_name, object_type as obj_type FROM all_objects WHERE owner = 'ATLAS_PANDAMETA' AND object_type = 'TABLE' AND substr(object_name,1,4)<>'BIN$' AND  substr(object_name,1,12)<>'SYS_IOT_OVER') LOOP
       	 	EXECUTE 'GRANT SELECT,INSERT,UPDATE,DELETE on "'||rec.obj_name||'" to ATLAS_PANDA_WRITEROLE';
	        EXECUTE 'GRANT SELECT on "'||rec.obj_name||'" to ATLAS_PANDA_READROLE';
	END LOOP;

	FOR rec in (SELECT object_name as obj_name, object_type as obj_type FROM all_objects WHERE owner = 'ATLAS_PANDAMETA' AND object_type IN ('VIEW','SEQUENCE','PROCEDURE', 'PACKAGE', 'FUNCTION', 'MATERIALIZED VIEW', 'TYPE' ) ORDER BY object_type DESC ) LOOP

		IF rec.obj_name NOT IN ('DO_GRANTS','GRANTS_UPDATE','GRANT_PRIVS4EXIST_OBJ') THEN
			IF rec.obj_type IN ('VIEW', 'MATERIALIZED VIEW' ) THEN
				privs := ' SELECT,INSERT,UPDATE,DELETE ';
				FOR i IN 1..2 LOOP /*if fails on the first loop with error 01720, then goes to the EXEPTION and changes the statement */
					BEGIN
						EXECUTE 'GRANT '|| privs ||' on "'||rec.obj_name||'" to ATLAS_PANDA_WRITEROLE';
					        EXECUTE 'GRANT SELECT on "'||rec.obj_name||'" to ATLAS_PANDA_READROLE';
						EXIT;
					EXCEPTION
						WHEN SQLSTATE '50001' THEN
						privs := ' SELECT ';
					END;
				END LOOP;
			elsif rec.obj_type = 'SEQUENCE' THEN
	        		EXECUTE 'GRANT SELECT on "'||rec.obj_name||'" to ATLAS_PANDA_WRITEROLE';
			        EXECUTE 'GRANT SELECT on "'||rec.obj_name||'" to ATLAS_PANDA_READROLE';
			elsif rec.obj_type IN ('PROCEDURE', 'PACKAGE','FUNCTION', 'TYPE') AND rec.obj_name <> 'CREATE_SYN' THEN
		         	EXECUTE 'GRANT EXECUTE on "'||rec.obj_name||'" to ATLAS_PANDA_WRITEROLE';
			        EXECUTE 'GRANT EXECUTE on "'||rec.obj_name||'" to ATLAS_PANDA_READROLE';
			END IF;
		END IF;
	END LOOP;
END;
$body$
LANGUAGE PLPGSQL
SECURITY DEFINER
;
ALTER PROCEDURE atlas_pandameta.grant_privs4exist_obj (owner_name text ) OWNER TO panda;
-- REVOKE ALL ON PROCEDURE atlas_pandameta.grant_privs4exist_obj (owner_name text ) FROM PUBLIC;

