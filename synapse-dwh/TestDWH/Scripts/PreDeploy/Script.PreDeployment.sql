-- This file contains SQL statements that will be executed before the build script.

/*
Pre-Deployment Script Template							
--------------------------------------------------------------------------------------
 This file contains SQL statements that will be executed before the build script.		
 Use SQLCMD syntax to include a file in the pre-deployment script.			
 Example:      :r .\myfile.sql								
 Use SQLCMD syntax to reference a variable in the pre-deployment script.		
 Example:      :setvar TableName MyTable							
               SELECT * FROM [$(TableName)]					
--------------------------------------------------------------------------------------
*/

:r .\Script.ConfigureCLR.sql
:r .\Script.InstallTSQLT.sql

-- Test Classes
-- :r ..\..\TestClasses\Uniqueness.sql
-- :r ..\..\TestClasses\ACDOCA.sql
-- :r ..\..\TestClasses\ScalarValuedFunctions.sql
-- :r ..\..\TestClasses\CurrencyConversion.sql
-- :r ..\..\TestClasses\OutboundDelivery.sql

-- EXEC tSQLt.NewTestClass 'dm_sales.vw_fact_OutboundDeliveryItem';
-- GO
-- EXEC tSQLt.NewTestClass 'edw.vw_fact_BillingDocumentItemFreight';
-- GO
-- EXEC tSQLt.NewTestClass 'edw.vw_LatestOutboundDeliveryItem';
-- GO
-- EXEC tSQLt.NewTestClass 'edw.vw_OutboundDeliveryItem_s4h';
-- GO
-- EXEC tSQLt.NewTestClass 'edw.vw_TransportationOrderItemFreightCost';
-- GO

EXEC [tSQLt].[SetFakeViewOn] 'edw';
GO
