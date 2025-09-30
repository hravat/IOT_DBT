{{ minimal_dim(
  src_name='staging',
  src_table='STG_GARAGE_DOOR',
  unique_keys=['DOOR_STATE','LABEL','SPHONE_SIGNAL','TYPE'],
  select_cols=['DOOR_STATE','LABEL','SPHONE_SIGNAL','TYPE'],
  merge_update_columns=['update_time'],
  sequence_name='seq_dim_garage_sr_key',
  surrogate_key_column='DIM_GARAGE_DOOR_SR_KEY'
) }}
