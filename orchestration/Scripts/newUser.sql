USE [sqldb-xxxx-sls-d-euw-001]
CREATE USER [<alias@domain.com>] FROM EXTERNAL PROVIDER;
ALTER ROLE [db_datareader] ADD MEMBER [<alias@domain.com>];
ALTER ROLE [db_developer] ADD MEMBER [<alias@domain.com>];
ALTER ROLE [db_datawriter] ADD MEMBER [<alias@domain.com>];
GO
