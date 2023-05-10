CREATE ROLE db_tester;

GRANT EXECUTE, REFERENCES, SELECT, VIEW DEFINITION TO db_tester;

GRANT
    SHOWPLAN,
    VIEW DATABASE STATE TO db_tester;

EXEC sp_addrolemember 'db_tester', [Tester];
