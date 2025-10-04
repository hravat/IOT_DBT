CREATE DATABASE IOT_DB;
CREATE SCHEMA IOT_DB.STG;
CREATE SCHEMA IOT_DB.DWH;



CREATE OR REPLACE STORAGE INTEGRATION azure_iot_integration
  TYPE = EXTERNAL_STAGE
  STORAGE_PROVIDER = AZURE
  ENABLED = TRUE
  AZURE_TENANT_ID = '56d4a3ff-d1b6-458d-856e-7eb75385d795'   -- e.g. from Azure AD overview
  STORAGE_ALLOWED_LOCATIONS = ('azure://hrstorageaccount123.blob.core.windows.net/iot-files');


DESC STORAGE INTEGRATION azure_iot_integration;


CREATE OR REPLACE STAGE AZURE_IOT_STAGE
  URL = 'azure://hrstorageaccount123.blob.core.windows.net/iot-files'
  STORAGE_INTEGRATION = azure_iot_integration
  FILE_FORMAT = (TYPE = CSV SKIP_HEADER=1 FIELD_OPTIONALLY_ENCLOSED_BY='"');


LIST @AZURE_IOT_STAGE;



