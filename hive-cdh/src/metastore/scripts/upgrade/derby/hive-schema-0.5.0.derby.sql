-- Timestamp: 2011-03-18 02:54:30.078
-- Source database is: /Users/carl/metastore/derby/mdb-0.5.0
-- Connection URL is: jdbc:derby:/Users/carl/metastore/derby/mdb-0.5.0
-- appendLogs: false

-- ----------------------------------------------
-- DDL Statements for functions
-- ----------------------------------------------

CREATE FUNCTION "APP"."NUCLEUS_ASCII" (C CHAR(1)) RETURNS INTEGER LANGUAGE JAVA PARAMETER STYLE JAVA READS SQL DATA CALLED ON NULL INPUT EXTERNAL NAME 'org.datanucleus.store.rdbms.adapter.DerbySQLFunction.ascii' ;

CREATE FUNCTION "APP"."NUCLEUS_MATCHES" (TEXT VARCHAR(8000),PATTERN VARCHAR(8000)) RETURNS INTEGER LANGUAGE JAVA PARAMETER STYLE JAVA READS SQL DATA CALLED ON NULL INPUT EXTERNAL NAME 'org.datanucleus.store.rdbms.adapter.DerbySQLFunction.matches' ;

-- ----------------------------------------------
-- DDL Statements for tables
-- ----------------------------------------------

CREATE TABLE "APP"."TYPE_FIELDS" ("TYPE_NAME" BIGINT NOT NULL, "COMMENT" VARCHAR(256), "FIELD_NAME" VARCHAR(128) NOT NULL, "FIELD_TYPE" VARCHAR(128) NOT NULL, "INTEGER_IDX" INTEGER NOT NULL);

CREATE TABLE "APP"."SERDES" ("SERDE_ID" BIGINT NOT NULL, "NAME" VARCHAR(128), "SLIB" VARCHAR(767));

CREATE TABLE "APP"."TABLE_PARAMS" ("TBL_ID" BIGINT NOT NULL, "PARAM_KEY" VARCHAR(256) NOT NULL, "PARAM_VALUE" VARCHAR(767));

CREATE TABLE "APP"."PARTITION_PARAMS" ("PART_ID" BIGINT NOT NULL, "PARAM_KEY" VARCHAR(256) NOT NULL, "PARAM_VALUE" VARCHAR(767));

CREATE TABLE "APP"."SEQUENCE_TABLE" ("SEQUENCE_NAME" VARCHAR(256) NOT NULL, "NEXT_VAL" BIGINT NOT NULL);

CREATE TABLE "APP"."NUCLEUS_TABLES" ("CLASS_NAME" VARCHAR(128) NOT NULL, "TABLE_NAME" VARCHAR(128) NOT NULL, "TYPE" VARCHAR(4) NOT NULL, "OWNER" VARCHAR(2) NOT NULL, "VERSION" VARCHAR(20) NOT NULL, "INTERFACE_NAME" VARCHAR(256) DEFAULT NULL);

CREATE TABLE "APP"."TYPES" ("TYPES_ID" BIGINT NOT NULL, "TYPE_NAME" VARCHAR(128), "TYPE1" VARCHAR(128), "TYPE2" VARCHAR(128));

CREATE TABLE "APP"."SERDE_PARAMS" ("SERDE_ID" BIGINT NOT NULL, "PARAM_KEY" VARCHAR(256) NOT NULL, "PARAM_VALUE" VARCHAR(767));

CREATE TABLE "APP"."SD_PARAMS" ("SD_ID" BIGINT NOT NULL, "PARAM_KEY" VARCHAR(256) NOT NULL, "PARAM_VALUE" VARCHAR(767));

CREATE TABLE "APP"."COLUMNS" ("SD_ID" BIGINT NOT NULL, "COMMENT" VARCHAR(256), "COLUMN_NAME" VARCHAR(128) NOT NULL, "TYPE_NAME" VARCHAR(128) NOT NULL, "INTEGER_IDX" INTEGER NOT NULL);

CREATE TABLE "APP"."BUCKETING_COLS" ("SD_ID" BIGINT NOT NULL, "BUCKET_COL_NAME" VARCHAR(256), "INTEGER_IDX" INTEGER NOT NULL);

CREATE TABLE "APP"."PARTITIONS" ("PART_ID" BIGINT NOT NULL, "CREATE_TIME" INTEGER NOT NULL, "LAST_ACCESS_TIME" INTEGER NOT NULL, "PART_NAME" VARCHAR(767), "SD_ID" BIGINT, "TBL_ID" BIGINT);

CREATE TABLE "APP"."SORT_COLS" ("SD_ID" BIGINT NOT NULL, "COLUMN_NAME" VARCHAR(128), "ORDER" INTEGER NOT NULL, "INTEGER_IDX" INTEGER NOT NULL);

CREATE TABLE "APP"."DBS" ("DB_ID" BIGINT NOT NULL, "DESC" VARCHAR(767), "NAME" VARCHAR(128));

CREATE TABLE "APP"."PARTITION_KEY_VALS" ("PART_ID" BIGINT NOT NULL, "PART_KEY_VAL" VARCHAR(256), "INTEGER_IDX" INTEGER NOT NULL);

CREATE TABLE "APP"."SDS" ("SD_ID" BIGINT NOT NULL, "INPUT_FORMAT" VARCHAR(256), "IS_COMPRESSED" CHAR(1) NOT NULL, "LOCATION" VARCHAR(767), "NUM_BUCKETS" INTEGER NOT NULL, "OUTPUT_FORMAT" VARCHAR(256), "SERDE_ID" BIGINT);

CREATE TABLE "APP"."PARTITION_KEYS" ("TBL_ID" BIGINT NOT NULL, "PKEY_COMMENT" VARCHAR(767), "PKEY_NAME" VARCHAR(128) NOT NULL, "PKEY_TYPE" VARCHAR(767) NOT NULL, "INTEGER_IDX" INTEGER NOT NULL);

CREATE TABLE "APP"."TBLS" ("TBL_ID" BIGINT NOT NULL, "CREATE_TIME" INTEGER NOT NULL, "DB_ID" BIGINT, "LAST_ACCESS_TIME" INTEGER NOT NULL, "OWNER" VARCHAR(128), "RETENTION" INTEGER NOT NULL, "SD_ID" BIGINT, "TBL_NAME" VARCHAR(128));

-- ----------------------------------------------
-- DDL Statements for indexes
-- ----------------------------------------------

CREATE UNIQUE INDEX "APP"."UNIQUEPARTITION" ON "APP"."PARTITIONS" ("PART_NAME", "TBL_ID");

CREATE UNIQUE INDEX "APP"."UNIQUETABLE" ON "APP"."TBLS" ("TBL_NAME", "DB_ID");

CREATE UNIQUE INDEX "APP"."UNIQUE_TYPE" ON "APP"."TYPES" ("TYPE_NAME");

CREATE UNIQUE INDEX "APP"."UNIQUE_DATABASE" ON "APP"."DBS" ("NAME");

-- ----------------------------------------------
-- DDL Statements for keys
-- ----------------------------------------------

-- primary/unique
ALTER TABLE "APP"."SERDES" ADD CONSTRAINT "SERDES_PK" PRIMARY KEY ("SERDE_ID");

ALTER TABLE "APP"."BUCKETING_COLS" ADD CONSTRAINT "BUCKETING_COLS_PK" PRIMARY KEY ("SD_ID", "INTEGER_IDX");

ALTER TABLE "APP"."SORT_COLS" ADD CONSTRAINT "SORT_COLS_PK" PRIMARY KEY ("SD_ID", "INTEGER_IDX");

ALTER TABLE "APP"."SD_PARAMS" ADD CONSTRAINT "SD_PARAMS_PK" PRIMARY KEY ("SD_ID", "PARAM_KEY");

ALTER TABLE "APP"."PARTITIONS" ADD CONSTRAINT "PARTITIONS_PK" PRIMARY KEY ("PART_ID");

ALTER TABLE "APP"."TYPE_FIELDS" ADD CONSTRAINT "TYPE_FIELDS_PK" PRIMARY KEY ("TYPE_NAME", "FIELD_NAME");

ALTER TABLE "APP"."PARTITION_KEY_VALS" ADD CONSTRAINT "PARTITION_KEY_VALS_PK" PRIMARY KEY ("PART_ID", "INTEGER_IDX");

ALTER TABLE "APP"."TBLS" ADD CONSTRAINT "TBLS_PK" PRIMARY KEY ("TBL_ID");

ALTER TABLE "APP"."SERDE_PARAMS" ADD CONSTRAINT "SERDE_PARAMS_PK" PRIMARY KEY ("SERDE_ID", "PARAM_KEY");

ALTER TABLE "APP"."COLUMNS" ADD CONSTRAINT "COLUMNS_PK" PRIMARY KEY ("SD_ID", "COLUMN_NAME", "TYPE_NAME");

ALTER TABLE "APP"."TYPES" ADD CONSTRAINT "TYPES_PK" PRIMARY KEY ("TYPES_ID");

ALTER TABLE "APP"."SDS" ADD CONSTRAINT "SDS_PK" PRIMARY KEY ("SD_ID");

ALTER TABLE "APP"."DBS" ADD CONSTRAINT "DBS_PK" PRIMARY KEY ("DB_ID");

ALTER TABLE "APP"."PARTITION_KEYS" ADD CONSTRAINT "PARTITION_KEY_PK" PRIMARY KEY ("TBL_ID", "PKEY_NAME");

ALTER TABLE "APP"."TABLE_PARAMS" ADD CONSTRAINT "TABLE_PARAMS_PK" PRIMARY KEY ("TBL_ID", "PARAM_KEY");

ALTER TABLE "APP"."PARTITION_PARAMS" ADD CONSTRAINT "PARTITION_PARAMS_PK" PRIMARY KEY ("PART_ID", "PARAM_KEY");

ALTER TABLE "APP"."NUCLEUS_TABLES" ADD CONSTRAINT "NUCLEUS_TABLES_PK" PRIMARY KEY ("CLASS_NAME");

ALTER TABLE "APP"."TYPE_FIELDS" ADD CONSTRAINT "TYPE_FIELDS_PK" PRIMARY KEY ("TYPE_NAME", "FIELD_NAME");

-- foreign
ALTER TABLE "APP"."BUCKETING_COLS" ADD CONSTRAINT "BUCKETING_COLS_FK1" FOREIGN KEY ("SD_ID") REFERENCES "APP"."SDS" ("SD_ID") ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE "APP"."SORT_COLS" ADD CONSTRAINT "SORT_COLS_FK1" FOREIGN KEY ("SD_ID") REFERENCES "APP"."SDS" ("SD_ID") ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE "APP"."SD_PARAMS" ADD CONSTRAINT "SD_PARAMS_FK1" FOREIGN KEY ("SD_ID") REFERENCES "APP"."SDS" ("SD_ID") ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE "APP"."PARTITIONS" ADD CONSTRAINT "PARTITIONS_FK1" FOREIGN KEY ("TBL_ID") REFERENCES "APP"."TBLS" ("TBL_ID") ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE "APP"."PARTITIONS" ADD CONSTRAINT "PARTITIONS_FK2" FOREIGN KEY ("SD_ID") REFERENCES "APP"."SDS" ("SD_ID") ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE "APP"."TYPE_FIELDS" ADD CONSTRAINT "TYPE_FIELDS_FK1" FOREIGN KEY ("TYPE_NAME") REFERENCES "APP"."TYPES" ("TYPES_ID") ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE "APP"."PARTITION_KEY_VALS" ADD CONSTRAINT "PARTITION_KEY_VALS_FK1" FOREIGN KEY ("PART_ID") REFERENCES "APP"."PARTITIONS" ("PART_ID") ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE "APP"."TBLS" ADD CONSTRAINT "TBLS_FK2" FOREIGN KEY ("DB_ID") REFERENCES "APP"."DBS" ("DB_ID") ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE "APP"."TBLS" ADD CONSTRAINT "TBLS_FK1" FOREIGN KEY ("SD_ID") REFERENCES "APP"."SDS" ("SD_ID") ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE "APP"."SERDE_PARAMS" ADD CONSTRAINT "SERDE_PARAMS_FK1" FOREIGN KEY ("SERDE_ID") REFERENCES "APP"."SERDES" ("SERDE_ID") ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE "APP"."COLUMNS" ADD CONSTRAINT "COLUMNS_FK1" FOREIGN KEY ("SD_ID") REFERENCES "APP"."SDS" ("SD_ID") ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE "APP"."SDS" ADD CONSTRAINT "SDS_FK1" FOREIGN KEY ("SERDE_ID") REFERENCES "APP"."SERDES" ("SERDE_ID") ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE "APP"."PARTITION_KEYS" ADD CONSTRAINT "PARTITION_KEYS_FK1" FOREIGN KEY ("TBL_ID") REFERENCES "APP"."TBLS" ("TBL_ID") ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE "APP"."TABLE_PARAMS" ADD CONSTRAINT "TABLE_PARAMS_FK1" FOREIGN KEY ("TBL_ID") REFERENCES "APP"."TBLS" ("TBL_ID") ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE "APP"."PARTITION_PARAMS" ADD CONSTRAINT "PARTITION_PARAMS_FK1" FOREIGN KEY ("PART_ID") REFERENCES "APP"."PARTITIONS" ("PART_ID") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- ----------------------------------------------
-- DDL Statements for checks
-- ----------------------------------------------

ALTER TABLE "APP"."SDS" ADD CONSTRAINT "SQL110318025428840" CHECK (IS_COMPRESSED IN ('Y','N'));
