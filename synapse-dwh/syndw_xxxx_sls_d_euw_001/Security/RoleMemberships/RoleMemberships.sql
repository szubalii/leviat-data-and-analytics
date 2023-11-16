-- Add the member to role db_developer
EXEC sp_addrolemember 'db_developer', '<user>@crh.com';
GO

-- Add the rest of the team to role db_reader
EXEC sp_addrolemember 'db_datareader', '<user>@crh.com';
GO

-- Add the data factory to role db_datadeveloper 
-- required for writing data and executing sprocs
-- EXEC sp_addrolemember 'db_datawriter', 'df-<user>-d-euw-001';
-- EXEC sp_addrolemember 'db_developer', 'df-<user>-d-euw-001';

-- Add the azure service to role db_owner (required for deployment)
EXEC sp_addrolemember 'db_owner', 'leviatazure-Pilot_Leviat_Sales';
GO

-- The user that loads data into Azure Synapse Analytics must have "CONTROL" permission on the target database
-- Also to write data, and execute sprocs
EXEC sp_addrolemember 'db_owner', 'df-<user>-d-euw-001';
GO
