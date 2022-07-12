-- First check if the database scoped credential already exists.
-- If not, create it, if so, alter it.
IF NOT EXISTS (
    SELECT *
    FROM sys.database_scoped_credentials
    WHERE name = 'dsc_SAS_OrchDB'
)
BEGIN
    CREATE DATABASE SCOPED CREDENTIAL dsc_SAS_OrchDB
    WITH IDENTITY = 'SHARED ACCESS SIGNATURE',
    SECRET = '$(sasToken_OrchDB)'
END
ELSE
BEGIN
    ALTER DATABASE SCOPED CREDENTIAL dsc_SAS_OrchDB
    WITH IDENTITY = 'SHARED ACCESS SIGNATURE',
    SECRET = '$(sasToken_OrchDB)'
END;
