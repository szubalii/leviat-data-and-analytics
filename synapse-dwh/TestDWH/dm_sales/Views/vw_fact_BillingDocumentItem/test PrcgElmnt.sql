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
    ,[PricingProcedureCounter]
    ,[ConditionAmount]
    ,[ConditionRateValue]
  )
  VALUES
     ('0000000001', '000010', '10', 'ZC10', 1, 100, 100)
    ,('0000000001', '000010', '10', 'ZC10', 2, 100, 100)
    ,('0000000001', '000010', '10', 'ZCF1', 1, 200, 200)
    ,('0000000001', '000010', '10', 'ZCF1', 2, 200, 200)
    ,('0000000001', '000010', '10', 'VPRS', 1, 400, 400)
    ,('0000000001', '000010', '10', 'VPRS', 2, 400, 400)
    ,('0000000001', '000010', '10', 'EK02', 1, 300, 300)
    ,('0000000001', '000010', '10', 'EK02', 2, 300, 300)
    ,('0000000001', '000010', '10', 'TST1', 1, 100, 100)
    ,('0000000001', '000010', '10', 'TST1', 2, 100, 100);

  INSERT INTO edw.fact_BillingDocumentItem (
     [BillingDocument]
    ,[BillingDocumentItem]
    ,[CurrencyTypeID]
    ,[CurrencyType]
  )
  VALUES
    ('0000000001', '000010', '10', 'Transaction Currency');

 
-- Act: 
  SELECT
     [BillingDocument]
    ,[BillingDocumentItem]
    ,[CurrencyType]
    ,[PrcgElmntZC10ConditionAmount]
    ,[PrcgElmntZCF1ConditionAmount]
    ,[PrcgElmntVPRS/EK02ConditionAmount]
    ,[PrcgElmntZC10ConditionRate]
    ,[PrcgElmntZCF1ConditionRate]
    ,[PrcgElmntVPRS/EK02ConditionRate]
  INTO actual
  FROM [dm_sales].[vw_fact_BillingDocumentItem];

  SELECT TOP 0 * INTO expected FROM actual;

  INSERT INTO expected (
    [BillingDocument]
    ,[BillingDocumentItem]
    ,[CurrencyType]
    ,[PrcgElmntZC10ConditionAmount]
    ,[PrcgElmntZCF1ConditionAmount]
    ,[PrcgElmntVPRS/EK02ConditionAmount]
    ,[PrcgElmntZC10ConditionRate]
    ,[PrcgElmntZCF1ConditionRate]
    ,[PrcgElmntVPRS/EK02ConditionRate]
  )
  VALUES
    ('0000000001', '000010', 'Transaction Currency', 200, 400, 800, 200, 400, 800);
  
  -- Assert:
  EXEC tSQLt.AssertEqualsTable 'expected', 'actual';;
END;
