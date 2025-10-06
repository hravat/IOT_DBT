{{ minimal_dim(
  src_name='staging',
  src_table='STG_THERMOSTAT',
  unique_keys=['label','type','thermostat_status'],
  select_cols=['label','type','thermostat_status'],
  merge_update_columns=['update_time'],
  sequence_name='SEQ_DIM_THERMOSTAT',
  surrogate_key_column='DIM_THERMOSTAT_SR_KEY'
) }}