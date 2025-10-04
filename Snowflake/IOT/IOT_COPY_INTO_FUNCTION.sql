USE DATABASE IOT_DB;
USE SCHEMA STG;


CREATE OR REPLACE PROCEDURE load_from_stage(
    p_stage    STRING,                            -- e.g. 'AZURE_IOT_STAGE'
    p_format   STRING,                            -- e.g. 'ff_csv_iot'
    p_control  STRING,                            -- e.g. 'STAGING.ETL_CONTROL'
    p_on_error STRING DEFAULT 'CONTINUE',         -- 'CONTINUE' or 'ABORT_STATEMENT' or 'SKIP_FILE'
    p_force    BOOLEAN DEFAULT FALSE              -- TRUE to reload already loaded files
)
RETURNS STRING
LANGUAGE SQL
AS
$$
DECLARE
  v_stage    STRING := COALESCE(p_stage,  'AZURE_IOT_STAGE');
  v_format   STRING := COALESCE(p_format, 'ff_csv_iot');
  v_control  STRING := COALESCE(p_control,'STG.ETL_CONTROL');
  v_force    STRING := CASE WHEN p_force THEN ' FORCE=TRUE' ELSE '' END;
  v_sql      STRING;
  v_qry      STRING;
  rs         RESULTSET;
  n          NUMBER DEFAULT 0;
BEGIN
  -- pull rows from the control table
  v_qry := 'SELECT file_name, target_table FROM ' || v_control;
  rs := (EXECUTE IMMEDIATE :v_qry);

  FOR rec IN rs DO
    v_sql :=
      'COPY INTO ' || rec.target_table ||
      ' FROM @' || v_stage || '/' || rec.file_name ||
      ' FILE_FORMAT=(FORMAT_NAME=''' || v_format || ''') '  ||
      ' MATCH_BY_COLUMN_NAME = CASE_INSENSITIVE '||
      ' ON_ERROR=' || p_on_error || v_force;

    EXECUTE IMMEDIATE v_sql;
    n := n + 1;
  END FOR;

  RETURN 'Submitted ' || n || ' COPY commands';
END;
$$;
