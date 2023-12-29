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
    ,[ConditionRateValue]
  )
  VALUES
    ('0000000001', '000010', '10', 'ZC10', 100, '1000010', 'TST','TST', 100)
    ,('0000000001', '000010', '10', 'ZCF1', 200, '1000010', 'TST','TST', 200)
    ,('0000000001', '000010', '10', 'VPRS', 400, '1000010', 'TST','TST', 400)
    ,('0000000001', '000010', '10', 'EK02', 300, '1000010', 'TST','TST', 300)
    ,('0000000001', '000010', '10', 'TST1', 100, '1000010', 'TST','TST', 100);

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
    ,[PrcgElmntZC10ConditionRate]
    ,[PrcgElmntZCF1ConditionRate]
    ,[PrcgElmntVPRS/EK02ConditionRate]
  INTO actual
  FROM [dm_sales].[vw_fact_BillingDocumentItem];

  SELECT TOP 0 * INTO expected FROM actual;

  INSERT INTO expected (
    [BillingDocument]
    ,[BillingDocumentItem]
    ,[PrcgElmntZC10ConditionAmount]
    ,[PrcgElmntZCF1ConditionAmount]
    ,[PrcgElmntVPRS/EK02ConditionAmount]
    ,[PrcgElmntZC10ConditionRate]
    ,[PrcgElmntZCF1ConditionRate]
    ,[PrcgElmntVPRS/EK02ConditionRate]
  )
  VALUES (
    '0000000001'
    ,'000010'   
    ,100        
    ,200        
    ,400   
    ,100        
    ,200        
    ,400           
  );
  
  -- Assert:
  EXEC tSQLt.AssertEqualsTable 'expected', 'actual';;
END;
