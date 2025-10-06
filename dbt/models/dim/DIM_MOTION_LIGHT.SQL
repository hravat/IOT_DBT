{{ minimal_dim(
  src_name='staging',
  src_table='STG_MOTION_LIGHT',
  unique_keys=['label','type'],
  select_cols=['label','type'],
  merge_update_columns=['update_time'],
  sequence_name='SEQ_DIM_MOTION_LIGHT',
  surrogate_key_column='DIM_MOTION_LIGHT_SR_KEY'
) }}