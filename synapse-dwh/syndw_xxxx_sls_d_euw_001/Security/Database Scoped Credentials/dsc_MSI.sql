-- Write your own SQL object definition here, and it'll be included in your package.
CREATE MASTER KEY ENCRYPTION BY PASSWORD = '$(masterKeyPwd)' 
--ALTER MASTER KEY REGENERATE WITH ENCRYPTION BY PASSWORD = 'dsjdkflJ435907NnmM#sX003';
GO

CREATE DATABASE SCOPED CREDENTIAL dsc_MSI
WITH IDENTITY = 'Managed Service Identity';
