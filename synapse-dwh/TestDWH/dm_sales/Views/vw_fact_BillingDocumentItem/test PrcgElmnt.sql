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

  SELECT 
    '0000000001'        AS [BillingDocument]
    ,'000010'           AS [BillingDocumentItem]
    ,100                AS [PrcgElmntZC10ConditionAmount]
    ,200                AS [PrcgElmntZCF1ConditionAmount]
    ,400                AS [PrcgElmntVPRS/EK02ConditionAmount]
  INTO expected;
  -- Assert:
  EXEC tSQLt.AssertEqualsTable 'expected', 'actual';;
END;
