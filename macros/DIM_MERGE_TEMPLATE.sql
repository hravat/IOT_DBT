{% macro minimal_dim(src_name, 
                    src_table, 
                    unique_keys, 
                    select_cols,
                    merge_update_columns,
                    sequence_name,
                    surrogate_key_column
                    ) %}

{{ config(
  materialized='incremental',
  unique_key=unique_keys,
  incremental_strategy='merge',
  merge_update_columns=merge_update_columns
) }}



with deduped as (
    select distinct
        {% for c in select_cols %}
        {{ c }}{% if not loop.last %},{% endif %}
        {% endfor %}
    from {{ source(src_name, src_table) }}
)

select
    {{ sequence_name }}.nextval as {{ surrogate_key_column }},
    {% for c in select_cols %}
    {{ c }}{% if not loop.last %},{% endif %}
    {% endfor %},
    current_timestamp as insert_time,
    current_timestamp as update_time
from deduped

{% endmacro %}