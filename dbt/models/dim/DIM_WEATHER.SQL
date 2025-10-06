{{ minimal_dim(
  src_name='staging',
  src_table='STG_WEATHER',
  unique_keys=['label','type'],
  select_cols=['label','type'],
  merge_update_columns=['update_time'],
  sequence_name='SEQ_DIM_WEATHER',
  surrogate_key_column='DIM_WEATHER_SR_KEY'
) }}