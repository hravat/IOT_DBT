USE DATABASE IOT_DB;
USE SCHEMA DWH;


CREATE OR REPLACE TABLE DIM_DATE (
  DATE_SR_KEY   number primary key,
  FULL_DATE     DATE,
  DAY           NUMBER(2,0),
  DAY_NAME      VARCHAR,
  DAY_OF_WEEK   NUMBER(1,0),
  WEEK          NUMBER(2,0),
  WEEKDAY_FLAG  BOOLEAN,
  MONTH         NUMBER(2,0),
  MONTH_NAME    VARCHAR,
  QUARTER       NUMBER(1,0),
  YEAR          NUMBER(4,0),
  IS_WEEKEND    BOOLEAN,
  HOLIDAY_FLAG  BOOLEAN
);

CREATE OR REPLACE TABLE DIM_TIME (
  TIME_SR_KEY  number primary key,
  FULL_TIME    TIME,
  HOUR         NUMBER(2,0),
  MINUTE       NUMBER(2,0),
  SECOND       NUMBER(2,0),
  AM_PM        VARCHAR(2),
  HOUR_OF_DAY  NUMBER(2,0)
);


create or replace table DIM_FRIDGE (
  DIM_FRIDGE_SR_KEY number identity(1,1) primary key,
  LABEL            varchar,
  TEMP_CONDITION   varchar,
  TYPE             varchar,
  INSERT_TIME TIMESTAMP,
  UPDATE_TIME TIMESTAMP
  
);

create or replace table FACT_FRIDGE (
    FACT_FRIDGE_SR_KEY   number          primary key,
    DATE_SR_KEY          number          not null,
    TIME_SR_KEY          number          not null,
    DIM_FRIDGE_SR_KEY    number          not null,
    MAX_FRIDGE_TEMPERATURE float,
    MIN_FRIDGE_TEMPERATURE float,
    AVG_FRIDGE_TEMPERATURE float,
    INSERT_TIME          timestamp_ntz   default current_timestamp,
    UPDATE_TIME          timestamp_ntz   default current_timestamp,
  constraint fk_fridge_date foreign key (DATE_SR_KEY) references DIM_DATE(DATE_SR_KEY),
  constraint fk_fridge_time foreign key (TIME_SR_KEY) references DIM_TIME(TIME_SR_KEY),
  constraint fk_fridge_dim  foreign key (DIM_FRIDGE_SR_KEY) references DIM_FRIDGE(DIM_FRIDGE_SR_KEY)
);

create or replace table DIM_GARAGE_DOOR (
  DIM_GARAGE_DOOR_SR_KEY number identity(1,1) primary key,
  DOOR_STATE    varchar,
  LABEL         varchar,
  SPHONE_SIGNAL varchar,
  TYPE          varchar,
  INSERT_TIME TIMESTAMP,
  UPDATE_TIME TIMESTAMP
);

create or replace table FACT_GARAGE_DOOR (
  FACT_GARAGE_DOOR_SR_KEY number identity(1,1) primary key,
  DATE_SR_KEY             number not null,
  TIME_SR_KEY             number not null,
  DIM_GARAGE_DOOR_SR_KEY  number not null,
  constraint fk_gdoor_date foreign key (DATE_SR_KEY) references DIM_DATE(DATE_SR_KEY),
  constraint fk_gdoor_time foreign key (TIME_SR_KEY) references DIM_TIME(TIME_SR_KEY),
  constraint fk_gdoor_dim  foreign key (DIM_GARAGE_DOOR_SR_KEY) references DIM_GARAGE_DOOR(DIM_GARAGE_DOOR_SR_KEY)
);


