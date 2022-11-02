CREATE ROLE db_developer;

GRANT ALTER, DELETE, EXECUTE, INSERT, REFERENCES, SELECT,
          UPDATE, VIEW DEFINITION TO db_developer;

GRANT
    CREATE TABLE,
    CREATE PROCEDURE,
    CREATE FUNCTION,
    CREATE VIEW,
    CREATE SCHEMA TO db_developer;
