USE DATABASE IOT_DB;
USE SCHEMA DWH;

create or replace sequence seq_dim_fridge start = 1 increment = 1;
create or replace sequence seq_dim_garage_sr_key start = 1 increment = 1;


create or replace sequence seq_dim_gps_tracker start = 1 increment = 1;
create or replace sequence seq_dim_modbus start = 1 increment = 1;
create or replace sequence seq_dim_motion_light start = 1 increment = 1;
create or replace sequence seq_dim_thermostat start = 1 increment = 1;
create or replace sequence seq_dim_weather start = 1 increment = 1;
create or replace sequence seq_dim_date start = 1 increment = 1;
create or replace sequence seq_dim_time start = 1 increment = 1;

create or replace sequence seq_fact_fridge start = 1 increment = 1;