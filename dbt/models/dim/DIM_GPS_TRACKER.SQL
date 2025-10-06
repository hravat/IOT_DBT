{{ minimal_dim(
  src_name='staging',
  src_table='STG_GPS_TRACKER',
  unique_keys=['label','type'],
  select_cols=['label','type'],
  merge_update_columns=['update_time'],
  sequence_name='SEQ_DIM_GPS_TRACKER',
  surrogate_key_column='DIM_GPS_TRACKER_SR_KEY'
) }}