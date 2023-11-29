CREATE PROCEDURE [tc.dm_sales.vw_fact_BillingDocumentItem].[test PrcgElmnt]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
  IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;
    
  -- Assemble: Fake Table
  EXEC tSQLt.FakeTable '[edw]', '[fact_BillingDocumentItemPrcgElmnt]'; 
  EXEC tSQLt.FakeTable '[edw]', '[fact_BillingDocumentItem]';

  INSERT INTO edw.fact_BillingDocumentItemPrcgElmnt (
    [BillingDocument]
    ,[BillingDocumentItem]
    ,[CurrencyTypeID]
    ,[ConditionType]
    ,[ConditionAmount]
    ,[nk_BillingDocumentItem]
    ,[PricingProcedureStep]
    ,[PricingProcedureCounter]
  )
  VALUES
    ('0000000001', '000010', '10', 'ZC10', 100, '1000010', 'TST','TST')
    ,('0000000001', '000010', '10', 'ZCF1', 200, '1000010', 'TST','TST')
    ,('0000000001', '000010', '10', 'VPRS', 400, '1000010', 'TST','TST')
    ,('0000000001', '000010', '10', 'EK02', 300, '1000010', 'TST','TST')
    ,('0000000001', '000010', '10', 'TST1', 100, '1000010', 'TST','TST');

  INSERT INTO edw.fact_BillingDocumentItem (
    [BillingDocument]
    ,[BillingDocumentItem]
    ,[CurrencyTypeID]
    ,[nk_fact_BillingDocumentItem]
    ,[CurrencyType]
  )
  VALUES
    ('0000000001', '000010', '10', '1000010', 'Transaction Currency');

 
-- Act: 
  SELECT
    [BillingDocument]
    ,[BillingDocumentItem]
    ,[PrcgElmntZC10ConditionAmount]
    ,[PrcgElmntZCF1ConditionAmount]
    ,[PrcgElmntVPRS/EK02ConditionAmount]
  INTO actual
  FROM [dm_sales].[vw_fact_BillingDocumentItem];

  CREATE TABLE expected AS SELECT TOP 0
    [BillingDocument]
    ,[BillingDocumentItem]
    ,[PrcgElmntZC10ConditionAmount]
    ,[PrcgElmntZCF1ConditionAmount]
    ,[PrcgElmntVPRS/EK02ConditionAmount]
  FROM actual;

  INSERT INTO expected (
    [BillingDocument]
    ,[BillingDocumentItem]
    ,[PrcgElmntZC10ConditionAmount]
    ,[PrcgElmntZCF1ConditionAmount]
    ,[PrcgElmntVPRS/EK02ConditionAmount]
  )
  VALUES (
    '0000000001'
    ,'000010'   
    ,100        
    ,200        
    ,400        
  );
  
  -- Assert:
  EXEC tSQLt.AssertEqualsTable 'expected', 'actual';;
END;
