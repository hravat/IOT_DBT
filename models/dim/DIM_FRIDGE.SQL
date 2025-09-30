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
