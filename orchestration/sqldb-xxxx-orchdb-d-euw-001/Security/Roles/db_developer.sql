CREATE ROLE db_developer;
GO

GRANT ALTER, DELETE, EXECUTE, INSERT, REFERENCES, SELECT,
          UPDATE, VIEW DEFINITION TO db_developer;
GO

GRANT
    CREATE TABLE,
    CREATE VIEW,
    CREATE PROCEDURE,
    CREATE FUNCTION,
    CREATE SCHEMA,
    SHOWPLAN TO db_developer;
GO