-- Write your own SQL object definition here, and it'll be included in your package.


EXEC sp_configure 'show advanced option', '1';
RECONFIGURE;
GO
EXEC sp_configure 'clr strict security', 0;
RECONFIGURE;
GO
EXEC sp_configure 'clr enabled', 1;
RECONFIGURE;
GO
