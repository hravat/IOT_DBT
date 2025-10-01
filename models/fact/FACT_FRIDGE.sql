{{ config(
    materialized='incremental',
    unique_key=['DATE_SR_KEY',
                'TIME_SR_KEY',
                'DIM_FRIDGE_SR_KEY'],
    incremental_strategy='merge',
    merge_update_columns = ['MAX_FRIDGE_TEMPERATURE',
                            'MIN_FRIDGE_TEMPERATURE',
                            'AVG_FRIDGE_TEMPERATURE',
                            'DIM_FRIDGE_SR_KEY',
                            'UPDATE_TIME']
) }}


with agg as 
(
select
  NVL(DIM_DATE.DATE_SR_KEY,-1) AS DATE_SR_KEY,
  NVL(DIM_TIME.TIME_SR_KEY,-1) AS TIME_SR_KEY,
  DIM_FRIDGE_SR_KEY,
  MAX(FRIDGE_TEMPERATURE) AS MAX_FRIDGE_TEMPERATURE,
  MIN(FRIDGE_TEMPERATURE) AS MIN_FRIDGE_TEMPERATURE,
  AVG(FRIDGE_TEMPERATURE) AS AVG_FRIDGE_TEMPERATURE,
  current_timestamp as INSERT_TIME,
  current_timestamp as UPDATE_TIME  
    from {{ source('staging','STG_FRIDGE') }} stg_fridge 
    left outer join {{ source('dwh','DIM_FRIDGE') }} DIM_FRIDGE
        ON DIM_FRIDGE.label = stg_fridge.label
        AND DIM_FRIDGE.temp_condition = stg_fridge.temp_condition
        AND DIM_FRIDGE.type = stg_fridge.type
    left outer join {{ source('dwh','DIM_DATE') }} DIM_DATE 
        ON DIM_DATE.DATE_SR_KEY= to_number(to_char(to_date(stg_fridge."DATE", 'DD-MON-YY'),'YYYYMMDD'))
    left outer join {{ source('dwh','DIM_TIME') }}  DIM_TIME 
        ON DIM_TIME.TIME_SR_KEY = to_number(to_char(to_time(stg_fridge."TIME", 'HH24:MI:SS'), 'HH24MISS'))
GROUP BY NVL(DIM_TIME.TIME_SR_KEY,-1),
        NVL(DIM_DATE.DATE_SR_KEY,-1),
        DIM_FRIDGE_SR_KEY
) 
select 
    seq_fact_fridge.nextval AS FACT_FRIDGE_SR_KEY,
    DATE_SR_KEY,
    TIME_SR_KEY,
    DIM_FRIDGE_SR_KEY,
    MAX_FRIDGE_TEMPERATURE,
    MIN_FRIDGE_TEMPERATURE,
    AVG_FRIDGE_TEMPERATURE,
    INSERT_TIME,
    UPDATE_TIME
from agg
