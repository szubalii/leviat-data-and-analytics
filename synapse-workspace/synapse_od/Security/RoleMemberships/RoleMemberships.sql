use master;
create login [df-<user>-d-euw-001] from external provider
create login [<user>@crh.com] from external provider


ALTER SERVER ROLE [BULKADMIN] ADD MEMBER [<user>@crh.com]
ALTER SERVER ROLE [BULKADMIN] ADD MEMBER [df-<user>-d-euw-001]



use synapse_od;

-- Add the rest of the team to role db_reader
EXEC sp_addrolemember 'db_datareader', '<user>@crh.com';

-- Add the data factory to role db_datadeveloper 
-- required for reading data and executing sprocs
EXEC sp_addrolemember 'db_executor', 'df-<user>-d-euw-001';
