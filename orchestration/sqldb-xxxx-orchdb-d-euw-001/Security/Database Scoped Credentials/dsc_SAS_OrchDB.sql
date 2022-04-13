-- Write your own SQL object definition here, and it'll be included in your package.
CREATE MASTER KEY ENCRYPTION BY PASSWORD = '$(masterKeyPwd)'
GO

CREATE DATABASE SCOPED CREDENTIAL dsc_SAS_OrchDB
WITH IDENTITY = 'SHARED ACCESS SIGNATURE',
SECRET = '$(sasToken_OrchDB)';
