USE DATABASE IOT_DB;
USE SCHEMA dbt_hravat;

create or replace sequence seq_dim_fridge start = 1 increment = 1;
create or replace sequence seq_dim_garage_sr_key start = 1 increment = 1;

create or replace sequence seq_fact_fridge start = 1 increment = 1;