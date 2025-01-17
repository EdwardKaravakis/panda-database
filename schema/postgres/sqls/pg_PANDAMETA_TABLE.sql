-- Generated by Ora2Pg, the Oracle database Schema converter, version 23.2
-- Copyright 2000-2022 Gilles DAROLD. All rights reserved.
-- DATASOURCE: dbi:Oracle:ADCR

SET client_encoding TO 'UTF8';

\set ON_ERROR_STOP ON

SET check_function_bodies = false;

CREATE SCHEMA IF NOT EXISTS doma_pandameta;
ALTER SCHEMA doma_pandameta OWNER TO panda;

SET search_path = doma_pandameta,public;

CREATE TABLE agis_dump (
	panda_site varchar(52),
	update_time timestamp,
	json_data text
) ;
ALTER TABLE agis_dump OWNER TO panda;

CREATE TABLE auth_group (
	id bigint,
	name varchar(80)
) ;
ALTER TABLE auth_group OWNER TO panda;

CREATE TABLE auth_group_permissions (
	id bigint,
	group_id bigint,
	permission_id bigint
) ;
ALTER TABLE auth_group_permissions OWNER TO panda;

CREATE TABLE auth_user_groups (
	id bigint,
	user_id bigint,
	group_id bigint
) ;
ALTER TABLE auth_user_groups OWNER TO panda;

CREATE TABLE auth_user_user_permissions (
	id bigint,
	user_id bigint,
	permission_id bigint
) ;
ALTER TABLE auth_user_user_permissions OWNER TO panda;

CREATE TABLE cloudconfig (
	name varchar(20) NOT NULL,
	description varchar(50) NOT NULL,
	tier1 varchar(20) NOT NULL,
	tier1se varchar(400) NOT NULL,
	relocation varchar(10),
	weight bigint NOT NULL DEFAULT '0',
	server varchar(100) NOT NULL,
	status varchar(20) NOT NULL,
	transtimelo bigint NOT NULL DEFAULT '0',
	transtimehi bigint NOT NULL DEFAULT '0',
	waittime bigint NOT NULL DEFAULT '0',
	comment_ varchar(200),
	space bigint NOT NULL DEFAULT '0',
	moduser varchar(30),
	modtime timestamp NOT NULL DEFAULT LOCALTIMESTAMP,
	validation varchar(20),
	mcshare bigint NOT NULL DEFAULT '0',
	countries varchar(80),
	fasttrack varchar(20),
	nprestage bigint NOT NULL DEFAULT 0,
	pilotowners varchar(300),
	dn varchar(100),
	email varchar(60),
	fairshare varchar(256),
	auto_mcu smallint DEFAULT 0
) ;
COMMENT ON COLUMN cloudconfig.comment_ IS E'ORIGINAL NAME:comment';
ALTER  TABLE cloudconfig OWNER TO panda;
ALTER TABLE cloudconfig ADD PRIMARY KEY (name);
ALTER TABLE cloudconfig ADD CONSTRAINT cloudconfig_auto_mcu_check CHECK (auto_mcu IN (0,1));
ALTER TABLE cloudconfig ALTER COLUMN auto_mcu SET NOT NULL;
ALTER TABLE cloudconfig ALTER COLUMN NAME SET NOT NULL;
ALTER TABLE cloudconfig ALTER COLUMN DESCRIPTION SET NOT NULL;
ALTER TABLE cloudconfig ALTER COLUMN TIER1 SET NOT NULL;
ALTER TABLE cloudconfig ALTER COLUMN TIER1SE SET NOT NULL;
ALTER TABLE cloudconfig ALTER COLUMN WEIGHT SET NOT NULL;
ALTER TABLE cloudconfig ALTER COLUMN SERVER SET NOT NULL;
ALTER TABLE cloudconfig ALTER COLUMN STATUS SET NOT NULL;
ALTER TABLE cloudconfig ALTER COLUMN TRANSTIMELO SET NOT NULL;
ALTER TABLE cloudconfig ALTER COLUMN TRANSTIMEHI SET NOT NULL;
ALTER TABLE cloudconfig ALTER COLUMN WAITTIME SET NOT NULL;
ALTER TABLE cloudconfig ALTER COLUMN SPACE SET NOT NULL;
ALTER TABLE cloudconfig ALTER COLUMN MODTIME SET NOT NULL;
ALTER TABLE cloudconfig ALTER COLUMN MCSHARE SET NOT NULL;
ALTER TABLE cloudconfig ALTER COLUMN NPRESTAGE SET NOT NULL;


CREATE TABLE incidents (
	at_time timestamp,
	typekey varchar(20),
	description varchar(200)
) ;
ALTER  TABLE incidents OWNER TO panda;


CREATE TABLE installedsw (
	siteid varchar(60),
	cloud varchar(10),
	release varchar(10),
	cache varchar(40),
	validation varchar(10),
	cmtconfig varchar(40)
) ;
ALTER  TABLE installedsw OWNER TO panda;
CREATE INDEX installedsw_relid_site_indx ON installedsw (release, siteid);
ALTER TABLE installedsw ADD UNIQUE (siteid,release,cache,cmtconfig);


CREATE TABLE jdllist (
	name varchar(60) NOT NULL,
	host varchar(60),
	system varchar(20) NOT NULL,
	jdl varchar(4000)
) ;
ALTER  TABLE jdllist OWNER TO panda;
ALTER TABLE jdllist ADD PRIMARY KEY (name);
ALTER TABLE jdllist ALTER COLUMN NAME SET NOT NULL;
ALTER TABLE jdllist ALTER COLUMN SYSTEM SET NOT NULL;


CREATE TABLE jobclass (
	id integer NOT NULL,
	name varchar(30) NOT NULL,
	description varchar(30) NOT NULL,
	rights varchar(30),
	priority integer,
	quota1 bigint,
	quota7 bigint,
	quota30 bigint
) ;
ALTER  TABLE jobclass OWNER TO panda;
CREATE UNIQUE INDEX jobclass_name_idx ON jobclass (name);
ALTER TABLE jobclass ADD PRIMARY KEY (id);
ALTER TABLE jobclass ALTER COLUMN ID SET NOT NULL;
ALTER TABLE jobclass ALTER COLUMN NAME SET NOT NULL;
ALTER TABLE jobclass ALTER COLUMN DESCRIPTION SET NOT NULL;


CREATE TABLE logstable (
	pandaid bigint NOT NULL DEFAULT '0',
	log1 text NOT NULL,
	log2 text NOT NULL,
	log3 text NOT NULL,
	log4 text NOT NULL
) ;
ALTER  TABLE logstable OWNER TO panda;
ALTER TABLE logstable ADD PRIMARY KEY (pandaid);
ALTER TABLE logstable ALTER COLUMN LOG4 SET NOT NULL;
ALTER TABLE logstable ALTER COLUMN LOG3 SET NOT NULL;
ALTER TABLE logstable ALTER COLUMN LOG2 SET NOT NULL;
ALTER TABLE logstable ALTER COLUMN LOG1 SET NOT NULL;
ALTER TABLE logstable ALTER COLUMN PANDAID SET NOT NULL;


CREATE TABLE multicloud_history (
	site varchar(60) NOT NULL,
	multicloud varchar(64),
	last_update timestamp NOT NULL
) ;
ALTER  TABLE multicloud_history OWNER TO panda;
CREATE INDEX multicloud_history_site_idx ON multicloud_history (site);
ALTER TABLE multicloud_history ALTER COLUMN LAST_UPDATE SET NOT NULL;
ALTER TABLE multicloud_history ALTER COLUMN SITE SET NOT NULL;


CREATE TABLE pandaconfig (
	name varchar(60) NOT NULL,
	controller varchar(20) NOT NULL,
	pathena varchar(20)
) ;
ALTER  TABLE pandaconfig OWNER TO panda;
ALTER TABLE pandaconfig ADD PRIMARY KEY (name);
ALTER TABLE pandaconfig ALTER COLUMN NAME SET NOT NULL;
ALTER TABLE pandaconfig ALTER COLUMN CONTROLLER SET NOT NULL;


CREATE TABLE proxykey (
	id bigint NOT NULL,
	dn varchar(100) NOT NULL,
	credname varchar(40) NOT NULL,
	created timestamp NOT NULL DEFAULT LOCALTIMESTAMP,
	expires timestamp NOT NULL DEFAULT to_date('01-JAN-70 00:00:00','dd-MON-yy hh24:mi:ss'),
	origin varchar(80) NOT NULL,
	myproxy varchar(80) NOT NULL
) ;
ALTER  TABLE proxykey OWNER TO panda;
ALTER TABLE proxykey ADD PRIMARY KEY (id);
ALTER TABLE proxykey ALTER COLUMN ID SET NOT NULL;
ALTER TABLE proxykey ALTER COLUMN DN SET NOT NULL;
ALTER TABLE proxykey ALTER COLUMN CREDNAME SET NOT NULL;
ALTER TABLE proxykey ALTER COLUMN CREATED SET NOT NULL;
ALTER TABLE proxykey ALTER COLUMN EXPIRES SET NOT NULL;
ALTER TABLE proxykey ALTER COLUMN ORIGIN SET NOT NULL;
ALTER TABLE proxykey ALTER COLUMN MYPROXY SET NOT NULL;


CREATE TABLE schedconfig (
	name varchar(60) NOT NULL DEFAULT 'default',
	nickname varchar(60) NOT NULL,
	queue varchar(60),
	localqueue varchar(50),
	system varchar(60) NOT NULL,
	sysconfig varchar(20),
	environ varchar(250),
	gatekeeper varchar(120),
	jobmanager varchar(80),
	se varchar(400),
	ddm varchar(120),
	jdladd varchar(500),
	globusadd varchar(100),
	jdl varchar(60),
	jdltxt varchar(500),
	version varchar(60),
	site varchar(60) NOT NULL,
	region varchar(60),
	gstat varchar(60),
	tags varchar(200),
	cmd varchar(200),
	lastmod timestamp NOT NULL DEFAULT LOCALTIMESTAMP,
	errinfo varchar(80),
	nqueue bigint NOT NULL DEFAULT '0',
	comment_ varchar(500),
	appdir varchar(500),
	datadir varchar(80),
	tmpdir varchar(80),
	wntmpdir varchar(80),
	dq2url varchar(80),
	special_par varchar(80),
	python_path varchar(80),
	nodes bigint NOT NULL DEFAULT '0',
	status varchar(10) DEFAULT 'offline',
	copytool varchar(80),
	copysetup varchar(200),
	releases varchar(500),
	sepath varchar(400),
	envsetup varchar(200),
	copyprefix varchar(500),
	lfcpath varchar(80),
	seopt varchar(400),
	sein varchar(400),
	seinopt varchar(400),
	lfchost varchar(80),
	cloud varchar(60),
	siteid varchar(60),
	proxy varchar(80),
	retry varchar(10),
	queuehours integer NOT NULL DEFAULT '0',
	envsetupin varchar(200),
	copytoolin varchar(180),
	copysetupin varchar(200),
	seprodpath varchar(400),
	lfcprodpath varchar(80),
	copyprefixin varchar(360),
	recoverdir varchar(80),
	memory bigint NOT NULL DEFAULT '0',
	maxtime bigint NOT NULL DEFAULT '0',
	space bigint NOT NULL DEFAULT '0',
	tspace timestamp NOT NULL DEFAULT to_date('01-JAN-70 00:00:00','dd-MON-yy hh24:mi:ss'),
	cmtconfig varchar(250),
	setokens varchar(80),
	glexec varchar(10),
	priorityoffset varchar(60),
	allowedgroups varchar(100),
	defaulttoken varchar(100),
	pcache varchar(100),
	validatedreleases varchar(500),
	accesscontrol varchar(20),
	dn varchar(100),
	email varchar(60),
	allowednode varchar(80),
	maxinputsize bigint,
	timefloor integer,
	depthboost bigint,
	idlepilotsupression bigint,
	pilotlimit bigint,
	transferringlimit bigint,
	cachedse smallint,
	corecount smallint,
	countrygroup varchar(64),
	availablecpu varchar(64),
	availablestorage varchar(64),
	pledgedcpu varchar(64),
	pledgedstorage varchar(64),
	statusoverride varchar(256) DEFAULT 'offline',
	allowdirectaccess varchar(10) DEFAULT 'False',
	gocname varchar(64) GENERATED ALWAYS AS ('site') STORED,
	tier varchar(15),
	multicloud varchar(64),
	lfcregister varchar(10),
	stageinretry bigint DEFAULT 2,
	stageoutretry bigint DEFAULT 2,
	fairsharepolicy varchar(512),
	allowfax varchar(64),
	faxredirector varchar(256),
	maxwdir bigint,
	celist varchar(4000),
	minmemory bigint,
	maxmemory bigint,
	mintime bigint,
	allowjem varchar(64),
	catchall varchar(512),
	faxdoor varchar(128),
	wansourcelimit integer,
	wansinklimit integer,
	auto_mcu smallint DEFAULT 0,
	objectstore varchar(512),
	allowhttp varchar(64),
	httpredirector varchar(256),
	multicloud_append varchar(64),
	corepower bigint,
	wnconnectivity varchar(256),
	cloudrshare varchar(256),
	sitershare varchar(256),
	autosetup_post varchar(512),
	autosetup_pre varchar(512),
	direct_access_lan varchar(32) DEFAULT 'False',
	direct_access_wan varchar(32) DEFAULT 'False',
	maxrss integer DEFAULT 0,
	minrss integer DEFAULT 0,
	use_newmover varchar(32) DEFAULT 'False',
	pilotversion varchar(32) DEFAULT 'current',
	objectstores varchar(4000),
	container_options varchar(1024),
	container_type varchar(256),
	jobseed varchar(16),
	pilot_manager varchar(16),
	capability varchar(16),
	resource_type varchar(16),
	workflow varchar(16),
	maxdiskio bigint
) ;
COMMENT ON COLUMN schedconfig.accesscontrol IS E'Allows access to specific groups of people. Set to grouplist if desired';
COMMENT ON COLUMN schedconfig.allowdirectaccess IS E'Jobs with transferType=direct will be matched by brokerage to sites with allowdirectaccess=True, allowdirectaccess=True for all sites which have copysetup true for direct access. Default False';
COMMENT ON COLUMN schedconfig.allowedgroups IS E'Sets allowed VOMS groups for the queue. Example: /atlas/.+/Role=production';
COMMENT ON COLUMN schedconfig.allowednode IS E'Determines allowed worker node names within the queue. Example: (brndt3head|wrk[0-9]+prv)\.hep\.brandeis\.edu';
COMMENT ON COLUMN schedconfig.allowfax IS E'Is FAX allowed or not? (True/False)';
COMMENT ON COLUMN schedconfig.appdir IS E'Directory in which the ATLAS Athena software releases are installed';
COMMENT ON COLUMN schedconfig.autosetup_post IS E'Path to local setup files, or blank when not needed.';
COMMENT ON COLUMN schedconfig.autosetup_pre IS E'Path to local setup files, or blank when not needed.';
COMMENT ON COLUMN schedconfig.availablecpu IS E'Amount of the real CPU capacity of the site as seen by ATLAS in HS06 (cf. PLEDGEDCPU). It could be the entire capacity of the site for an ATLAS-only site, the capacity of the ATLAS share, or the capacity of the ATLAS share plus an average capacity increment from opportunistic ATLAS use of non-ATLAS resources at the site.';
COMMENT ON COLUMN schedconfig.availablestorage IS E'Amount of real storage compared to pledged PLEDGEDSTORAGE';
COMMENT ON COLUMN schedconfig.cachedse IS E'Enable PD2P by setting to 1. Only relevant for ANALY sites.';
COMMENT ON COLUMN schedconfig.celist IS E'A JSON representation of the list of CEs that a virtual queue (often seen in ANALY queues) may address. To populate, work by analogy from other queues where celist is set. This is ONLY for AGIS compatibility, to allow changes to schedconfig to auto-populate AGIS.';
COMMENT ON COLUMN schedconfig.cloud IS E'The home cloud, possibly at the start of a comma-separated list of clouds. The site can contribute to any cloud in the list(Multi-cloud) If disabled, the config file will be found in "Disabled"';
COMMENT ON COLUMN schedconfig.cmd IS E'Batch queue submit command for the queue. Examples: condor_submit -verbose %s, qsub -q panda %s';
COMMENT ON COLUMN schedconfig.cmtconfig IS E'Set to the appropriate CMTCONFIG for a queue. Mostly i686-slc5-gcc43-opt';
COMMENT ON COLUMN schedconfig.comment_ IS E'Any comment necessary to the queue. This is NOT stored in the SVN.';
COMMENT ON COLUMN schedconfig.copyprefix IS E'Prefix for SRM copies out from the queue. Example: ^srm://gk03.atlas-swt2.org. If COPYPREFIXIN is None, this covers all copies in and out of the queue.';
COMMENT ON COLUMN schedconfig.copyprefixin IS E'Prefix for SRM copies into the queue. Example: ^srm://gk03.atlas-swt2.org';
COMMENT ON COLUMN schedconfig.copysetup IS E'Commands to be run before (inbound) outbound copies; may be a script, or a set of commands like /somepath/setup.sh^srm://lcg-se0.ifh.de/^dcap://lcg-dc0.ifh.de:22125/^False^True. If COPYSETUPIN is None, this covers all copies in and out of the queue. For more info see https://twiki.cern.ch/twiki/bin/viewauth/Atlas/PandaPilot#Direct_access_vs_stage_in_mode';
COMMENT ON COLUMN schedconfig.copysetupin IS E'Commands to be run before inbound copies; essentially the same as COPYSETUP but can be used to specify a different stage-in setup than for stage-out';
COMMENT ON COLUMN schedconfig.copytool IS E'The (inbound) outbound copy tool for (in)output files. Examples: cp, lcg-cp, storm, xcp. If COPYTOOLIN is None, this covers all copies in and out of the queue.
        lcg-cp ( lcgcp ): pilots use lcg-cr for upload to SE and registration to LFC
        lcg-cp2 ( lcgcp2 ): pilots use lcg-cp for upload to SE and no registration to LFC by pilot. To make the registration done the panda server, the other parameter needs to be set (LFCREGISTER=''server'')';
COMMENT ON COLUMN schedconfig.copytoolin IS E'The inbound copy tool for input files. Examples: cp, lcg-cp, storm, xcp. If set to None, COPYTOOL will be used for both stage-in and stage-out';
COMMENT ON COLUMN schedconfig.corecount IS E'Number of cores per machine for AthenaMP use';
COMMENT ON COLUMN schedconfig.countrygroup IS E'Allows for national federations';
COMMENT ON COLUMN schedconfig.datadir IS E'Directory in which data are stored';
COMMENT ON COLUMN schedconfig.ddm IS E'A comma-separated list of DDM endpoints used for input data. For a T1 the order should match the setoken order, because this is used to translate the output file space token into the final ddm destination. It is ok for the ddm list to be longer than setokens, e.g. to have an extra input location. For a T2 this is typically just local PRODDISK. The first value in the list has some special meanings. 1) The free space in this endpoint ends up in schedconfig.space(updated via curl). 2) If the site is a T1, then it also ends up in the cloud table space, which is used for task assignment, 3) Bamboo may choose to subscribe EVNT input between clouds, to aid brokerage - the destination space token is this one.';
COMMENT ON COLUMN schedconfig.defaulttoken IS E'??';
COMMENT ON COLUMN schedconfig.depthboost IS E'Maximum number of pilotDepth block submissions when a site has enough jobs';
COMMENT ON COLUMN schedconfig.direct_access_lan IS E'To manage direct access (LAN) configuration, replacing the copysetup fields. We will still keep the copysetup[in] fields, but they will not be used in the same complex way';
COMMENT ON COLUMN schedconfig.direct_access_wan IS E'To manage direct access (WAN) configuration, replacing the copysetup fields. We will still keep the copysetup[in] fields, but they will not be used in the same complex way';
COMMENT ON COLUMN schedconfig.dn IS E'Grid DN of the most recent modifier';
COMMENT ON COLUMN schedconfig.dq2url IS E'DQ2 Access URL';
COMMENT ON COLUMN schedconfig.email IS E'The site admin contact email(s)';
COMMENT ON COLUMN schedconfig.environ IS E'List of environment variables to be set. Example: APP=/home/osgstore/app TMP=/home/osgstore/tmp DATA=/home/osgstore/data';
COMMENT ON COLUMN schedconfig.envsetup IS E'Command that is run (can be variable setting or script) to set up copy for (in)out transfers. If ENVSETUPIN is None, this covers all copies in and out of the queue.';
COMMENT ON COLUMN schedconfig.envsetupin IS E'Command that is run (can be variable setting or script) to set up copy for out transfers.';
COMMENT ON COLUMN schedconfig.errinfo IS E'Not used.';
COMMENT ON COLUMN schedconfig.faxredirector IS E'The FAX redirector (e.g. root://glrd.usatlas.org/)';
COMMENT ON COLUMN schedconfig.gatekeeper IS E'The physical hostname of the headnode for the queue. For virtual queues, it is to be set';
COMMENT ON COLUMN schedconfig.glexec IS E'Is GLEXEC set? (No, for the most part)';
COMMENT ON COLUMN schedconfig.globusadd IS E' A part of the JDL for some circumstances. ??';
COMMENT ON COLUMN schedconfig.gocname IS E' Set from AGIS rc_name';
COMMENT ON COLUMN schedconfig.gstat IS E' Derived from AGIS atlas_site variable Derived FROM BDII GSTAT variable. Site IDENTITY.';
COMMENT ON COLUMN schedconfig.idlepilotsupression IS E'O nly send an idling pilot every N cycles';
COMMENT ON COLUMN schedconfig.jdl IS E'The NAME of the entry in the jdllist table that provides the basic JDL for the jobs being submitted';
COMMENT ON COLUMN schedconfig.jdladd IS E'Any additional JDL needed for the queue. Must end with Queue, on its own line.';
COMMENT ON COLUMN schedconfig.jdltxt IS E'??';
COMMENT ON COLUMN schedconfig.jobmanager IS E'condor, lsf, cream, arc, pbs, etc. For virtual queues, it is to.be.set.';
COMMENT ON COLUMN schedconfig.lastmod IS E'Timestamp of last modification. Not stored in SVN.';
COMMENT ON COLUMN schedconfig.lfchost IS E'LFC (LHC File Catalog) to use with this queue.';
COMMENT ON COLUMN schedconfig.lfcpath IS E'LFC path on LFCHOST to use with this queue.';
COMMENT ON COLUMN schedconfig.lfcprodpath IS E'LFC path on LFCHOST to use with this queue for PROD jobs.';
COMMENT ON COLUMN schedconfig.lfcregister IS E'LFC registration is done by the pilot ( ''NONE'' ) or by the panda server ( ''server'' ). should be used with COPYTOOL=lcgcp2 . All the queues in the panda siteid MUST have the same value.';
COMMENT ON COLUMN schedconfig.localqueue IS E'local queue name to use in the queue''s batch SYSTEM. IF unset, this IS NOT specified.';
COMMENT ON COLUMN schedconfig.maxinputsize IS E'14336 is the default (14 GB), but can be higher. Maximum copy-to-scratch input data total. To be obsolete after MAXWDIR being set properly.';
COMMENT ON COLUMN schedconfig.maxrss IS E'Limit on the RSS memory available to the process being run by the pilot';
COMMENT ON COLUMN schedconfig.maxtime IS E'Wall time. Zero means infinite.';
COMMENT ON COLUMN schedconfig.maxwdir IS E'Maximum available workdir space per job. The initial value has been set as MAXINPUTSIZE + 2GB';
COMMENT ON COLUMN schedconfig.memory IS E'Memory available, MB. Zero means infinite. The pilot wrapper will set this as a virtual memory limit for athena to cause a clean malloc() failure.';
COMMENT ON COLUMN schedconfig.minrss IS E'Minimum RSS memory available to the process being run by the pilot';
COMMENT ON COLUMN schedconfig.name IS E'Unused. Set to default.';
COMMENT ON COLUMN schedconfig.nickname IS E'The unique PRIMARY KEY of the table. The queue is named by this parameter. Should match the config file name.';
COMMENT ON COLUMN schedconfig.nodes IS E'Number of compute elements in the queue''s possession.';
COMMENT ON COLUMN schedconfig.nqueue IS E'Baseline number of pilots to queue. Not stored in SVN.';
COMMENT ON COLUMN schedconfig.objectstores IS E'Stores the objectstore characteristics of a queue';
COMMENT ON COLUMN schedconfig.pcache IS E'pCache enabled ( None or 1)';
COMMENT ON COLUMN schedconfig.pilotlimit IS E'Maximum number of pilots to have (in any state) at a site';
COMMENT ON COLUMN schedconfig.pilotversion IS E'Allows specification of a pilot version that should run on the queue. Default is "current"';
COMMENT ON COLUMN schedconfig.pledgedstorage IS E'Storage Pledges (MoU), contributes to ration with AVAILABLESTORAGE';
COMMENT ON COLUMN schedconfig.priorityoffset IS E'??';
COMMENT ON COLUMN schedconfig.proxy IS E'donothide or noimport. Currently not used by the pilot';
COMMENT ON COLUMN schedconfig.python_path IS E'Sets the PYTHONPATH variable at run start';
COMMENT ON COLUMN schedconfig.queue IS E'GATEKEEPER/JOBMANAGER';
COMMENT ON COLUMN schedconfig.queuehours IS E'Max job lifetime in hours';
COMMENT ON COLUMN schedconfig.recoverdir IS E'Local env. variable for recovery data. Example: $ATLAS_RECOVERDIR';
COMMENT ON COLUMN schedconfig.region IS E'Region. Example: us';
COMMENT ON COLUMN schedconfig.releases IS E'Becoming obsolete. List of releases available, separated by pipes. Autogenerated for BDII sites. Example: 0.1.31|0.1.32|0.1.33|0.1.34|14.2.21|14.2.25|15.0.0|15.3.1|15.5.4|15.6.1|15.6.10|15.6.11|15.6.3|15.6.5|15.6.6|15.6.7|15.6.8|15.6.9|15.8.0';
COMMENT ON COLUMN schedconfig.retry IS E'(TRUE or FALSE) Turns on or off job recovery';
COMMENT ON COLUMN schedconfig.se IS E'space token and full endpoint of default output destination. The path is extracted from the matching token in seprodpath If output files do not have spacetoken set, then the token in this entry is used. This applies to direct storage from T1 jobs, but not to subscriptions from T2(see setokens).';
COMMENT ON COLUMN schedconfig.sein IS E'Comma separated list of SEs, same length as DDM and SEPATH/SEPRODPATH for input transfers';
COMMENT ON COLUMN schedconfig.seinopt IS E'Currently not used by the pilot';
COMMENT ON COLUMN schedconfig.seopt IS E'Comma separated list. seopt is used in combination with SETOKENS to select the proper SE corresponding to a given space token descriptor. The order of SE''s listed IN SEOPT has TO match THE ORDER OF tokens IN SETOKENS';
COMMENT ON COLUMN schedconfig.sepath IS E'Same as SEPRODPATH but for analysis sites';
COMMENT ON COLUMN schedconfig.seprodpath IS E'list of destination paths, to append to endpoint in ''se''. Compressed notation is supported /blah/[tok1,tok2]/more/. Must be the same length as setokens.';
COMMENT ON COLUMN schedconfig.setokens IS E'List of destination space tokens. The first token is the default destination(for subscription from T2) if an output file does not have spacetoken set. Must match length of SEPRODPATH';
COMMENT ON COLUMN schedconfig.site IS E'Site name';
COMMENT ON COLUMN schedconfig.siteid IS E'Name of similar queues in site (shared gatekeepers)';
COMMENT ON COLUMN schedconfig.space IS E'Available disk space on the site. Refers to first token in ddm.';
COMMENT ON COLUMN schedconfig.special_par IS E'Additional JDL to add to job';
COMMENT ON COLUMN schedconfig.status IS E'Site online/offline/test/brokeroff status. Not stored in SVN.';
COMMENT ON COLUMN schedconfig.statusoverride IS E'(offline, notonline, None) to manage changing of site status through cloud curl commands. Default IS ''offline'', site will not change status. notonline IS ''site cannot be set online. None IS ''all changes are possible''';
COMMENT ON COLUMN schedconfig.sysconfig IS E'(None or manual) IS Prevent BDII updating OF PARAMETERS';
COMMENT ON COLUMN schedconfig.system IS E'Same as JOBMANAGER';
COMMENT ON COLUMN schedconfig.tags IS E'Obsolete';
COMMENT ON COLUMN schedconfig.tier IS E'?';
COMMENT ON COLUMN schedconfig.timefloor IS E'The pilot will keep downloading jobs during the limit set by timefloor (minutes). If at the end of a job, more time has passed than that of timefloor since the beginning of the first job, the pilot will end';
COMMENT ON COLUMN schedconfig.tmpdir IS E'Temp directory';
COMMENT ON COLUMN schedconfig.transferringlimit IS E'Maximum number of transferring jobs to allow at a site';
COMMENT ON COLUMN schedconfig.tspace IS E'?';
COMMENT ON COLUMN schedconfig.validatedreleases IS E'Reprocessing jobs are brokered only to the queues with this value set to ''True''';
COMMENT ON COLUMN schedconfig.version IS E'Unused';
COMMENT ON COLUMN schedconfig.wntmpdir IS E'Worker node temp DIRECTORY ';
ALTER  TABLE schedconfig OWNER TO panda;
ALTER TABLE schedconfig ADD PRIMARY KEY (nickname);
ALTER TABLE schedconfig ADD CONSTRAINT direct_access_lan_chk CHECK (direct_access_lan IN ('True','False'));
ALTER TABLE schedconfig ADD CONSTRAINT direct_access_wan_chk CHECK (direct_access_wan IN ('True','False'));
ALTER TABLE schedconfig ADD CONSTRAINT schedconfig_auto_mcu_check CHECK (auto_mcu IN (0,1));
ALTER TABLE schedconfig ALTER COLUMN auto_mcu SET NOT NULL;
ALTER TABLE schedconfig ALTER COLUMN NAME SET NOT NULL;
ALTER TABLE schedconfig ALTER COLUMN NICKNAME SET NOT NULL;
ALTER TABLE schedconfig ALTER COLUMN SYSTEM SET NOT NULL;
ALTER TABLE schedconfig ALTER COLUMN SITE SET NOT NULL;
ALTER TABLE schedconfig ALTER COLUMN LASTMOD SET NOT NULL;
ALTER TABLE schedconfig ALTER COLUMN NQUEUE SET NOT NULL;
ALTER TABLE schedconfig ALTER COLUMN NODES SET NOT NULL;
ALTER TABLE schedconfig ALTER COLUMN QUEUEHOURS SET NOT NULL;
ALTER TABLE schedconfig ALTER COLUMN MEMORY SET NOT NULL;
ALTER TABLE schedconfig ALTER COLUMN MAXTIME SET NOT NULL;
ALTER TABLE schedconfig ALTER COLUMN SPACE SET NOT NULL;
ALTER TABLE schedconfig ALTER COLUMN TSPACE SET NOT NULL;
ALTER TABLE schedconfig ADD CONSTRAINT use_newmover_chk CHECK (use_newmover IN ('True','False'));


CREATE TABLE schedinstance (
	name varchar(60) NOT NULL DEFAULT 'default',
	nickname varchar(60) NOT NULL,
	pandasite varchar(60) NOT NULL,
	nqueue bigint NOT NULL DEFAULT '5',
	nqueued bigint NOT NULL DEFAULT '0',
	nrunning bigint NOT NULL DEFAULT '0',
	nfinished bigint NOT NULL DEFAULT '0',
	nfailed bigint NOT NULL DEFAULT '0',
	naborted bigint NOT NULL DEFAULT '0',
	njobs bigint NOT NULL DEFAULT '0',
	tvalid timestamp NOT NULL DEFAULT LOCALTIMESTAMP,
	lastmod timestamp NOT NULL DEFAULT to_date('01-JAN-70 00:00:00','dd-MON-yy hh24:mi:ss'),
	errinfo varchar(150),
	ndone bigint NOT NULL DEFAULT '0',
	totrunt bigint NOT NULL DEFAULT '0',
	comment_ varchar(500)
) ;
COMMENT ON COLUMN schedinstance.comment_ IS E'ORIGINAL NAME:comment';
ALTER  TABLE schedinstance OWNER TO panda;
CREATE INDEX schedinstance_nickname_idx ON schedinstance (nickname);
ALTER TABLE schedinstance ADD PRIMARY KEY (nickname,pandasite);
ALTER TABLE schedinstance ALTER COLUMN NAME SET NOT NULL;
ALTER TABLE schedinstance ALTER COLUMN NICKNAME SET NOT NULL;
ALTER TABLE schedinstance ALTER COLUMN NQUEUE SET NOT NULL;
ALTER TABLE schedinstance ALTER COLUMN NQUEUED SET NOT NULL;
ALTER TABLE schedinstance ALTER COLUMN NRUNNING SET NOT NULL;
ALTER TABLE schedinstance ALTER COLUMN NFINISHED SET NOT NULL;
ALTER TABLE schedinstance ALTER COLUMN NFAILED SET NOT NULL;
ALTER TABLE schedinstance ALTER COLUMN NABORTED SET NOT NULL;
ALTER TABLE schedinstance ALTER COLUMN NJOBS SET NOT NULL;
ALTER TABLE schedinstance ALTER COLUMN TVALID SET NOT NULL;
ALTER TABLE schedinstance ALTER COLUMN LASTMOD SET NOT NULL;
ALTER TABLE schedinstance ALTER COLUMN NDONE SET NOT NULL;
ALTER TABLE schedinstance ALTER COLUMN TOTRUNT SET NOT NULL;


CREATE TABLE siteaccess (
	id bigint NOT NULL,
	dn varchar(100),
	pandasite varchar(100),
	poffset bigint NOT NULL DEFAULT 0,
	rights varchar(30),
	status varchar(20),
	workinggroups varchar(100),
	created timestamp
) ;
ALTER  TABLE siteaccess OWNER TO panda;
CREATE UNIQUE INDEX siteaccess_dnsite_idx ON siteaccess (dn, pandasite);
ALTER TABLE siteaccess ADD PRIMARY KEY (id);
ALTER TABLE siteaccess ALTER COLUMN ID SET NOT NULL;
ALTER TABLE siteaccess ALTER COLUMN POFFSET SET NOT NULL;


CREATE TABLE sitedata (
	site varchar(60) NOT NULL,
	flag varchar(30) NOT NULL,
	hours integer NOT NULL DEFAULT '0',
	nwn integer,
	memmin integer,
	memmax integer,
	si2000min integer,
	si2000max integer,
	os varchar(30),
	space varchar(30),
	minjobs integer,
	maxjobs integer,
	laststart timestamp,
	lastend timestamp,
	lastfail timestamp,
	lastpilot timestamp,
	lastpid integer,
	nstart integer NOT NULL DEFAULT '0',
	finished integer NOT NULL DEFAULT '0',
	failed integer NOT NULL DEFAULT '0',
	defined integer NOT NULL DEFAULT '0',
	assigned integer NOT NULL DEFAULT '0',
	waiting integer NOT NULL DEFAULT '0',
	activated integer NOT NULL DEFAULT '0',
	holding integer NOT NULL DEFAULT '0',
	running integer NOT NULL DEFAULT '0',
	transferring integer NOT NULL DEFAULT '0',
	getjob integer NOT NULL DEFAULT '0',
	updatejob integer NOT NULL DEFAULT '0',
	lastmod timestamp NOT NULL DEFAULT LOCALTIMESTAMP,
	ncpu integer,
	nslot integer,
	nojob integer,
	getjobabs bigint,
	updatejobabs bigint,
	nojobabs bigint
) ;
COMMENT ON COLUMN sitedata.getjobabs IS E'Absolute number of getJobs requests';
COMMENT ON COLUMN sitedata.nojob IS E'Number of getJobs requests that did not get a Job';
COMMENT ON COLUMN sitedata.nojobabs IS E'Absolute number of getJobs requests that did not get a Job';
COMMENT ON COLUMN sitedata.updatejobabs IS E'Absolute number of updateJobs';
ALTER  TABLE sitedata OWNER TO panda;
ALTER TABLE sitedata ADD PRIMARY KEY (site,flag,hours);
ALTER TABLE sitedata ALTER COLUMN SITE SET NOT NULL;
ALTER TABLE sitedata ALTER COLUMN FLAG SET NOT NULL;
ALTER TABLE sitedata ALTER COLUMN HOURS SET NOT NULL;
ALTER TABLE sitedata ALTER COLUMN NSTART SET NOT NULL;
ALTER TABLE sitedata ALTER COLUMN FINISHED SET NOT NULL;
ALTER TABLE sitedata ALTER COLUMN FAILED SET NOT NULL;
ALTER TABLE sitedata ALTER COLUMN DEFINED SET NOT NULL;
ALTER TABLE sitedata ALTER COLUMN ASSIGNED SET NOT NULL;
ALTER TABLE sitedata ALTER COLUMN WAITING SET NOT NULL;
ALTER TABLE sitedata ALTER COLUMN ACTIVATED SET NOT NULL;
ALTER TABLE sitedata ALTER COLUMN HOLDING SET NOT NULL;
ALTER TABLE sitedata ALTER COLUMN RUNNING SET NOT NULL;
ALTER TABLE sitedata ALTER COLUMN TRANSFERRING SET NOT NULL;
ALTER TABLE sitedata ALTER COLUMN GETJOB SET NOT NULL;
ALTER TABLE sitedata ALTER COLUMN UPDATEJOB SET NOT NULL;
ALTER TABLE sitedata ALTER COLUMN LASTMOD SET NOT NULL;


CREATE TABLE sites_matrix_data (
	source varchar(256) NOT NULL,
	destination varchar(256) NOT NULL,
	meas_date timestamp NOT NULL,
	sonarsmlval bigint,
	sonarsmldev bigint,
	sonarmedval bigint,
	sonarmeddev bigint,
	sonarlrgval bigint,
	sonarlrgdev bigint,
	perfsonaravgval bigint,
	xrdcpval bigint,
	sonarsml_last_update timestamp,
	sonarmed_last_update timestamp,
	sonarlrg_last_update timestamp,
	perfsonaravg_last_update timestamp,
	xrdcp_last_update timestamp
) ;
ALTER  TABLE sites_matrix_data OWNER TO panda;
ALTER TABLE sites_matrix_data ADD PRIMARY KEY (source,destination);
ALTER TABLE sites_matrix_data ALTER COLUMN MEAS_DATE SET NOT NULL;
ALTER TABLE sites_matrix_data ALTER COLUMN DESTINATION SET NOT NULL;
ALTER TABLE sites_matrix_data ALTER COLUMN SOURCE SET NOT NULL;


CREATE TABLE taginfo (
	tag varchar(30) NOT NULL,
	description varchar(100) NOT NULL,
	nqueues bigint NOT NULL DEFAULT '0',
	queues varchar(4000)
) ;
ALTER  TABLE taginfo OWNER TO panda;
ALTER TABLE taginfo ADD PRIMARY KEY (tag);
ALTER TABLE taginfo ALTER COLUMN DESCRIPTION SET NOT NULL;
ALTER TABLE taginfo ALTER COLUMN NQUEUES SET NOT NULL;


CREATE TABLE usercacheusage (
	username varchar(128) NOT NULL,
	filename varchar(256) NOT NULL,
	hostname varchar(64) NOT NULL,
	creationtime timestamp NOT NULL,
	modificationtime timestamp,
	filesize bigint,
	checksum varchar(36),
	aliasname varchar(256)
) PARTITION BY RANGE (creationtime) ;
COMMENT ON TABLE usercacheusage IS E'This table is required to keep track on the disk usage per user, so that can be seen who unfairly occupies too much disk space and eventually ban the user';
ALTER  TABLE usercacheusage OWNER TO panda;
CREATE INDEX usercacheusage_usr_crdate_indx ON usercacheusage (username, creationtime);
ALTER TABLE usercacheusage ADD PRIMARY KEY (filename,hostname,creationtime);
ALTER TABLE usercacheusage ALTER COLUMN USERNAME SET NOT NULL;
ALTER TABLE usercacheusage ALTER COLUMN FILENAME SET NOT NULL;
ALTER TABLE usercacheusage ALTER COLUMN HOSTNAME SET NOT NULL;
ALTER TABLE usercacheusage ALTER COLUMN CREATIONTIME SET NOT NULL;


CREATE TABLE users (
	id integer NOT NULL,
	name varchar(60) NOT NULL,
	dn varchar(150),
	email varchar(60),
	url varchar(100),
	location varchar(60),
	classa varchar(30),
	classp varchar(30),
	classxp varchar(30),
	sitepref varchar(60),
	gridpref varchar(20),
	queuepref varchar(60),
	scriptcache varchar(100),
	types varchar(60),
	sites varchar(250),
	njobsa bigint,
	njobsp bigint,
	njobs1 bigint,
	njobs7 bigint,
	njobs30 bigint,
	cpua1 bigint,
	cpua7 bigint,
	cpua30 bigint,
	cpup1 bigint,
	cpup7 bigint,
	cpup30 bigint,
	cpuxp1 bigint,
	cpuxp7 bigint,
	cpuxp30 bigint,
	quotaa1 bigint,
	quotaa7 bigint,
	quotaa30 bigint,
	quotap1 bigint,
	quotap7 bigint,
	quotap30 bigint,
	quotaxp1 bigint,
	quotaxp7 bigint,
	quotaxp30 bigint,
	space1 bigint,
	space7 bigint,
	space30 bigint,
	lastmod timestamp NOT NULL DEFAULT LOCALTIMESTAMP,
	firstjob timestamp NOT NULL DEFAULT to_date('01-JAN-70 00:00:00','dd-MON-yy hh24:mi:ss'),
	latestjob timestamp NOT NULL DEFAULT to_date('01-JAN-70 00:00:00','dd-MON-yy hh24:mi:ss'),
	pagecache text,
	cachetime timestamp NOT NULL DEFAULT to_date('01-JAN-70 00:00:00','dd-MON-yy hh24:mi:ss'),
	ncurrent bigint NOT NULL DEFAULT '0',
	jobid bigint NOT NULL DEFAULT '0',
	status varchar(20),
	vo varchar(20)
) ;
ALTER  TABLE users OWNER TO panda;
CREATE INDEX users_name_idx ON users (name, vo);
ALTER TABLE users ADD PRIMARY KEY (id);
ALTER TABLE users ALTER COLUMN ID SET NOT NULL;
ALTER TABLE users ALTER COLUMN NAME SET NOT NULL;
ALTER TABLE users ALTER COLUMN LASTMOD SET NOT NULL;
ALTER TABLE users ALTER COLUMN FIRSTJOB SET NOT NULL;
ALTER TABLE users ALTER COLUMN LATESTJOB SET NOT NULL;
ALTER TABLE users ALTER COLUMN CACHETIME SET NOT NULL;
ALTER TABLE users ALTER COLUMN NCURRENT SET NOT NULL;
ALTER TABLE users ALTER COLUMN JOBID SET NOT NULL;


CREATE TABLE usersubs (
	datasetname varchar(255) NOT NULL,
	site varchar(64) NOT NULL,
	creationdate timestamp,
	modificationdate timestamp,
	nused integer,
	state varchar(30) DEFAULT 'subscribed'
) ;
ALTER  TABLE usersubs OWNER TO panda;
ALTER TABLE usersubs ADD PRIMARY KEY (datasetname,site);
ALTER TABLE usersubs ALTER COLUMN DATASETNAME SET NOT NULL;
ALTER TABLE usersubs ALTER COLUMN SITE SET NOT NULL;
