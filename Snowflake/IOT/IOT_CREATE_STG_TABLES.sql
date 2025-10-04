
USE DATABASE IOT_DB;
USE SCHEMA STG;

CREATE OR REPLACE TABLE STG_FRIDGE (
  date              STRING,
  time              STRING,
  fridge_temperature FLOAT,
  temp_condition    STRING,
  label             STRING,
  type              STRING
);

CREATE OR REPLACE TABLE STG_GARAGE_DOOR (
  date           STRING,
  time           STRING,
  door_state     STRING,
  sphone_signal  BOOLEAN,
  label          STRING,
  type           STRING
);



-- GPS Tracker
CREATE OR REPLACE TABLE STG_GPS_TRACKER (
  date       DATE,
  label      VARCHAR(50),
  latitude   FLOAT,
  longitude  FLOAT,
  time       VARCHAR(20),
  type       VARCHAR(50)
);

-- Garage Door
CREATE OR REPLACE TABLE STG_GARAGE_DOOR (
  date           DATE,
  time           VARCHAR(20),
  door_state     VARCHAR(20),
  sphone_signal  VARCHAR(20),
  label          VARCHAR(50),
  type           VARCHAR(50)
);

-- Modbus
CREATE OR REPLACE TABLE STG_MODBUS (
  FC1_Read_Input_Register   FLOAT,
  FC2_Read_Discrete_Value   VARCHAR(20),
  FC3_Read_Holding_Register FLOAT,
  FC4_Read_Coil             VARCHAR(20),
  date                      DATE,
  label                     VARCHAR(50),
  time                      VARCHAR(20),
  type                      VARCHAR(50)
);

-- Motion Light
CREATE OR REPLACE TABLE STG_MOTION_LIGHT (
  date           DATE,
  label          VARCHAR(50),
  light_status   VARCHAR(20),
  motion_status  VARCHAR(20),
  time           VARCHAR(20),
  type           VARCHAR(50)
);

-- Thermostat
CREATE OR REPLACE TABLE STG_THERMOSTAT (
  current_temperature FLOAT,
  date                DATE,
  label               VARCHAR(50),
  thermostat_status   VARCHAR(20),
  time                VARCHAR(20),
  type                VARCHAR(50)
);

-- Weather
CREATE OR REPLACE TABLE STG_WEATHER (
  date         DATE,
  humidity     FLOAT,
  label        VARCHAR(50),
  pressure     FLOAT,
  temperature  FLOAT,
  time         VARCHAR(20),
  type         VARCHAR(50)
);



select * 
from STG_FRIDGE 