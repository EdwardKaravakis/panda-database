-- Generated by Ora2Pg, the Oracle database Schema converter, version 21.1
-- Copyright 2000-2020 Gilles DAROLD. All rights reserved.
-- DATASOURCE: dbi:Oracle:INT8R

SET client_encoding TO 'UTF8';

\set ON_ERROR_STOP ON

SET check_function_bodies = false;

CREATE SCHEMA IF NOT EXISTS doma_pandaarch;
ALTER SCHEMA doma_pandaarch OWNER TO panda;

SET search_path = doma_pandaarch,public;

CREATE TABLE filestable_arch (
	row_id bigint NOT NULL,
	pandaid bigint NOT NULL DEFAULT 0,
	modificationtime timestamp NOT NULL DEFAULT LOCALTIMESTAMP,
	creationtime timestamp,
	guid varchar(64),
	lfn varchar(256),
	type varchar(20),
	fsize bigint DEFAULT 0,
	dataset varchar(255),
	status varchar(64),
	md5sum varchar(40),
	checksum varchar(40),
	proddblock varchar(255),
	proddblocktoken varchar(250),
	dispatchdblock varchar(255),
	dispatchdblocktoken varchar(250),
	destinationdblock varchar(255),
	destinationdblocktoken varchar(250),
	destinationse varchar(250),
	scope varchar(30),
	jeditaskid bigint,
	datasetid bigint,
	fileid bigint,
	attemptnr smallint
) ;
ALTER TABLE filestable_arch OWNER TO panda;
CREATE INDEX files_arch_pandaid_idx ON filestable_arch (pandaid);
CREATE INDEX files_arch_rowid_idx ON filestable_arch (row_id);

CREATE TABLE jobparamstable_arch (
	pandaid bigint NOT NULL,
	modificationtime timestamp NOT NULL DEFAULT LOCALTIMESTAMP,
	jobparameters text
) ;
ALTER TABLE jobparamstable_arch OWNER TO panda;
CREATE INDEX jobparams_arch_pandaid_idx ON jobparamstable_arch (pandaid);

CREATE TABLE jobsarchived (
	pandaid bigint NOT NULL DEFAULT '0',
	jobdefinitionid bigint NOT NULL DEFAULT '0',
	schedulerid varchar(128),
	pilotid varchar(200),
	creationtime timestamp NOT NULL DEFAULT LOCALTIMESTAMP,
	creationhost varchar(128),
	modificationtime timestamp NOT NULL DEFAULT LOCALTIMESTAMP,
	modificationhost varchar(128),
	atlasrelease varchar(64),
	transformation varchar(250),
	homepackage varchar(80),
	prodserieslabel varchar(20),
	prodsourcelabel varchar(20),
	produserid varchar(250),
	assignedpriority integer NOT NULL DEFAULT '0',
	currentpriority integer NOT NULL DEFAULT '0',
	attemptnr smallint NOT NULL DEFAULT '0',
	maxattempt smallint NOT NULL DEFAULT '0',
	jobstatus varchar(15) NOT NULL DEFAULT 'unknown',
	jobname varchar(256),
	maxcpucount bigint NOT NULL DEFAULT '0',
	maxcpuunit varchar(32),
	maxdiskcount bigint NOT NULL DEFAULT '0',
	maxdiskunit char(4),
	ipconnectivity char(5),
	minramcount bigint NOT NULL DEFAULT '0',
	minramunit char(4),
	starttime timestamp DEFAULT LOCALTIMESTAMP,
	endtime timestamp DEFAULT LOCALTIMESTAMP,
	cpuconsumptiontime numeric(20),
	cpuconsumptionunit varchar(128),
	commandtopilot varchar(250),
	transexitcode varchar(128),
	piloterrorcode integer NOT NULL DEFAULT '0',
	piloterrordiag varchar(500),
	exeerrorcode integer NOT NULL DEFAULT '0',
	exeerrordiag varchar(500),
	superrorcode integer NOT NULL DEFAULT '0',
	superrordiag varchar(250),
	ddmerrorcode integer NOT NULL DEFAULT '0',
	ddmerrordiag varchar(700),
	brokerageerrorcode integer NOT NULL DEFAULT '0',
	brokerageerrordiag varchar(250),
	jobdispatchererrorcode integer NOT NULL DEFAULT '0',
	jobdispatchererrordiag varchar(250),
	taskbuffererrorcode integer NOT NULL DEFAULT '0',
	taskbuffererrordiag varchar(300),
	computingsite varchar(128),
	computingelement varchar(128),
	proddblock varchar(255),
	dispatchdblock varchar(255),
	destinationdblock varchar(255),
	destinationse varchar(250),
	nevents bigint,
	grid varchar(50),
	cloud varchar(50),
	cpuconversion decimal(9,4),
	sourcesite varchar(36),
	destinationsite varchar(36),
	transfertype varchar(10),
	taskid integer,
	cmtconfig varchar(250),
	statechangetime timestamp DEFAULT LOCALTIMESTAMP,
	proddbupdatetime timestamp DEFAULT LOCALTIMESTAMP,
	lockedby varchar(128),
	relocationflag smallint DEFAULT '0',
	jobexecutionid bigint DEFAULT '0',
	vo varchar(16),
	pilottiming varchar(100),
	workinggroup varchar(20),
	processingtype varchar(64),
	jobparameters text,
	metadata text,
	produsername varchar(60),
	ninputfiles integer,
	countrygroup varchar(20),
	batchid varchar(80),
	parentid bigint,
	specialhandling varchar(80),
	jobsetid bigint,
	corecount smallint,
	ninputdatafiles integer,
	inputfiletype varchar(32),
	inputfileproject varchar(64),
	inputfilebytes bigint,
	noutputdatafiles integer,
	outputfilebytes bigint,
	jobmetrics varchar(500),
	workqueue_id integer,
	jeditaskid bigint,
	jobsubstatus varchar(80),
	actualcorecount integer,
	reqid integer,
	maxrss bigint,
	maxvmem bigint,
	maxswap bigint,
	maxpss bigint,
	avgrss bigint,
	avgvmem bigint,
	avgswap bigint,
	avgpss bigint,
	maxwalltime bigint,
	hs06 bigint,
	meancorecount decimal(8,2),
	nucleus varchar(52),
	eventservice smallint,
	failedattempt smallint,
	hs06sec bigint,
	gshare 	varchar(32),
	totrchar bigint,
	totwchar bigint,
	totrbytes bigint,
	totwbytes bigint,
	raterchar bigint,
	ratewchar bigint,
	raterbytes bigint,
	ratewbytes bigint,
	resource_type varchar(56),
	diskio integer,
	memory_leak bigint,
	memory_leak_x2 decimal(11,2),
	container_name varchar(200),
	job_label varchar(20)
) ;
COMMENT ON COLUMN jobsarchived.hs06 IS E'Core count x core power';
ALTER TABLE jobsarchived OWNER TO panda;
CREATE INDEX jobsarchived_jeditaskid_idx ON jobsarchived (jeditaskid);
CREATE INDEX jobs_batchid_idx ON jobsarchived (batchid);
CREATE INDEX jobs_comsite_3attr_pandaid_idx ON jobsarchived (computingsite, jobstatus, prodsourcelabel, processingtype, pandaid);
CREATE INDEX jobs_destinationdblock_idx ON jobsarchived (destinationdblock);
CREATE INDEX jobs_jobdefid_produsername_idx ON jobsarchived (jobdefinitionid, produsername);
CREATE INDEX jobs_jobname_idx ON jobsarchived (jobname);
CREATE INDEX jobs_jobsetid_produsername_idx ON jobsarchived (jobsetid, produsername);
CREATE INDEX jobs_pandaid_idx ON jobsarchived (pandaid);
CREATE INDEX jobs_proddblock_idx ON jobsarchived (proddblock);
CREATE INDEX jobs_produsername_4attr_idx ON jobsarchived (produsername, jobstatus, prodsourcelabel, jobsetid, jobdefinitionid);
CREATE INDEX jobs_specialhandling_idx ON jobsarchived (specialhandling);
CREATE INDEX jobs_taskid_3attr_pandaid_idx ON jobsarchived (taskid, prodsourcelabel, jobstatus, processingtype, pandaid);

CREATE TABLE metatable_arch (
	pandaid bigint NOT NULL DEFAULT '0',
	modificationtime timestamp NOT NULL DEFAULT LOCALTIMESTAMP,
	metadata text
) ;
ALTER TABLE metatable_arch OWNER TO panda;
CREATE INDEX meta_arch_pandaid_idx ON metatable_arch (pandaid);

CREATE TABLE pandaids_modiftime (
	pandaid bigint NOT NULL,
	modiftime timestamp NOT NULL
) ;
ALTER TABLE pandaids_modiftime OWNER TO panda;
ALTER TABLE pandaids_modiftime ADD PRIMARY KEY (pandaid,modiftime);

CREATE TABLE pandaids_modiftime_errlog (
	"ora_err_number$" bigint,
	"ora_err_mesg$" varchar(2000),
	"ora_err_rowid$" oid,
	"ora_err_optyp$" varchar(2),
	"ora_err_tag$" varchar(2000),
	pandaid varchar(4000),
	modiftime varchar(4000)
) ;
COMMENT ON TABLE pandaids_modiftime_errlog IS E'DML Error Logging table for "ATLAS_PANDAARCH"."PANDAIDS_MODIFTIME"';
ALTER TABLE pandaids_modiftime_errlog OWNER TO panda;

CREATE TABLE table_part_boundaries (
	tab_name varchar(30) NOT NULL,
	part_name varchar(30) NOT NULL,
	part_position bigint,
	part_boundary_dictionary text,
	part_boundary timestamp,
	last_created_view varchar(30)
) ;
ALTER TABLE table_part_boundaries OWNER TO panda;
ALTER TABLE table_part_boundaries ADD PRIMARY KEY (tab_name,part_name);
