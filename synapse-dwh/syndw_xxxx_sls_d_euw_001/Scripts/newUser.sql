--Create user in the database
CREATE USER [<alias@domain.com>] FROM EXTERNAL PROVIDER;

--Grant role to the user in the database
EXEC sp_addrolemember 'db_datareader', '<alias@domain.com>';
EXEC sp_addrolemember 'db_datawriter', '<alias@domain.com>';
EXEC sp_addrolemember 'db_developer', '<alias@domain.com>';
