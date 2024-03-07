IF EXISTS (
  SELECT 1
  FROM sys.symmetric_keys
  WHERE name = '##MS_DatabaseMasterKey##'
)
BEGIN
  ALTER MASTER KEY REGENERATE WITH ENCRYPTION
  BY PASSWORD = '$(masterKeyPwd)'
END
ELSE
BEGIN
  CREATE MASTER KEY ENCRYPTION
  BY PASSWORD = '$(masterKeyPwd)'
END
GO

IF EXISTS (
  SELECT 1
  FROM sys.database_scoped_credentials
  WHERE name = 'dsc_SAS_OrchDB'
)
BEGIN
  ALTER DATABASE SCOPED CREDENTIAL dsc_SAS_OrchDB
  WITH IDENTITY = 'SHARED ACCESS SIGNATURE',
  SECRET = '$(sasToken_OrchDB)';
END
ELSE
BEGIN
  CREATE DATABASE SCOPED CREDENTIAL dsc_SAS_OrchDB
  WITH IDENTITY = 'SHARED ACCESS SIGNATURE',
  SECRET = '$(sasToken_OrchDB)';
END
GO

IF EXISTS (
  SELECT 1
  FROM sys.external_data_sources
  WHERE name = 'eds_OrchDB'
)
BEGIN
  ALTER EXTERNAL DATA SOURCE eds_OrchDB SET
    LOCATION = '$(containerURL)', --https://$(storageAccount).blob.core.windows.net/orch-db',
    CREDENTIAL= dsc_SAS_OrchDB;
END
ELSE
BEGIN
  CREATE EXTERNAL DATA SOURCE eds_OrchDB
  WITH (
    TYPE = BLOB_STORAGE,
    LOCATION = '$(containerURL)', --https://$(storageAccount).blob.core.windows.net/orch-db',
    CREDENTIAL= dsc_SAS_OrchDB
  );
END
GO

-- IF EXISTS (

-- )
--   DROP MASTER KEY;
-- GO

-- CREATE MASTER KEY ENCRYPTION
-- BY PASSWORD = '$(masterKeyPwd)';
-- GO

-- CREATE DATABASE SCOPED CREDENTIAL dsc_SAS_OrchDB
-- WITH IDENTITY = 'SHARED ACCESS SIGNATURE',
-- SECRET = '$(sasToken_OrchDB)';
-- GO

-- CREATE EXTERNAL DATA SOURCE eds_OrchDB
-- WITH (
--   TYPE = BLOB_STORAGE,
--   LOCATION = '$(containerURL)', --https://$(storageAccount).blob.core.windows.net/orch-db',
--   CREDENTIAL= dsc_SAS_OrchDB
-- );
-- GO
