{{ minimal_dim(
  src_name='staging',
  src_table='STG_GARAGE_DOOR',
  unique_keys=['DOOR_STATE','LABEL','SPHONE_SIGNAL','TYPE'],
  select_cols=['DOOR_STATE','LABEL','SPHONE_SIGNAL','TYPE'],
  merge_update_columns=['update_time'],
  sequence_name='seq_dim_garage_sr_key',
  surrogate_key_column='DIM_GARAGE_DOOR_SR_KEY'
) }}






/*
{{ config(
    materialized='incremental',
    unique_key=['label','temp_condition','type'],
    incremental_strategy='merge',
    merge_update_columns = ['update_time']
) }}

with deduped as (
    select distinct
        label,
        temp_condition,
        type
    from {{ source('staging','STG_FRIDGE') }}
)

select
    seq_dim_fridge.nextval as dim_fridge_sr_key,
    label,
    temp_condition,
    type,
    current_timestamp as insert_time,
    current_timestamp as update_time
from deduped


----unique_key
----merge_update_columns
---{{ source('staging','STG_FRIDGE') }}

*/