-- map file to table once
USE DATABASE IOT_DB;
USE SCHEMA STG;


CREATE OR REPLACE TABLE STG.ETL_CONTROL (
  file_name    STRING,
  target_table STRING
);

INSERT INTO STG.ETL_CONTROL VALUES
('IoT_Fridge.csv',       'STG.STG_FRIDGE'),
('IoT_Garage_Door.csv',  'STG.STG_GARAGE_DOOR'),
('IoT_GPS_Tracker.csv',  'STG.STG_GPS_TRACKER'),
('IoT_Thermostat.csv',   'STG.STG_THERMOSTAT'),
('IoT_Weather.csv',      'STG.STG_WEATHER'),
('IoT_Motion_Light.csv', 'STG.STG_MOTION_LIGHT'),
('IoT_Modbus.csv',       'STG.STG_MODBUS');



SELECT * 
FROM STG.ETL_CONTROL; 

