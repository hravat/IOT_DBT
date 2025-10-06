{{ minimal_dim(
  src_name='staging',
  src_table='STG_MODBUS',
  unique_keys=['label','type'],
  select_cols=['label','type'],
  merge_update_columns=['update_time'],
  sequence_name='SEQ_DIM_MODBUS',
  surrogate_key_column='DIM_MODBUS_SR_KEY'
) }}