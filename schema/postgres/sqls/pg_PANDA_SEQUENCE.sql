-- Generated by Ora2Pg, the Oracle database Schema converter, version 23.2
-- Copyright 2000-2022 Gilles DAROLD. All rights reserved.
-- DATASOURCE: dbi:Oracle:ADCR

SET client_encoding TO 'UTF8';

SET search_path = doma_panda,public;
\set ON_ERROR_STOP ON

SET check_function_bodies = false;

CREATE SCHEMA IF NOT EXISTS doma_panda;
CREATE SEQUENCE cloudtasks_id_seq INCREMENT 1 MINVALUE 1 NO MAXVALUE START 1 CACHE 10;
ALTER SEQUENCE cloudtasks_id_seq OWNER TO panda;
CREATE SEQUENCE filestable4_row_id_seq INCREMENT 1 MINVALUE 1 NO MAXVALUE START 1 CACHE 20;
ALTER SEQUENCE filestable4_row_id_seq OWNER TO panda;
CREATE SEQUENCE group_jobid_seq INCREMENT 1 MINVALUE 1 NO MAXVALUE START 1;
ALTER SEQUENCE group_jobid_seq OWNER TO panda;
CREATE SEQUENCE harvester_command_id_seq INCREMENT 1 MINVALUE 1 NO MAXVALUE START 1;
ALTER SEQUENCE harvester_command_id_seq OWNER TO panda;
CREATE SEQUENCE jedi_datasets_id_seq INCREMENT 1 MINVALUE 1 NO MAXVALUE START 1;
ALTER SEQUENCE jedi_datasets_id_seq OWNER TO panda;
CREATE SEQUENCE jedi_dataset_cont_fileid_seq INCREMENT 1 MINVALUE 1 NO MAXVALUE START 1 CACHE 100;
ALTER SEQUENCE jedi_dataset_cont_fileid_seq OWNER TO panda;
CREATE SEQUENCE jedi_output_template_id_seq INCREMENT 1 MINVALUE 1 NO MAXVALUE START 1;
ALTER SEQUENCE jedi_output_template_id_seq OWNER TO panda;
CREATE SEQUENCE jedi_work_queue_id_seq INCREMENT 1 MINVALUE 1 NO MAXVALUE START 1;
ALTER SEQUENCE jedi_work_queue_id_seq OWNER TO panda;
CREATE SEQUENCE jobsdefined4_pandaid_seq INCREMENT 1 MINVALUE 1 NO MAXVALUE START 1;
ALTER SEQUENCE jobsdefined4_pandaid_seq OWNER TO panda;
CREATE SEQUENCE retryactions_id_seq INCREMENT 1 MINVALUE 1 NO MAXVALUE START 1;
ALTER SEQUENCE retryactions_id_seq OWNER TO panda;
CREATE SEQUENCE retryerrors_id_seq INCREMENT 1 MINVALUE 1 NO MAXVALUE START 1;
ALTER SEQUENCE retryerrors_id_seq OWNER TO panda;
CREATE SEQUENCE subcounter_subid_seq INCREMENT 1 MINVALUE 1 MAXVALUE 9999999 START 1 CYCLE;
ALTER SEQUENCE subcounter_subid_seq OWNER TO panda;
