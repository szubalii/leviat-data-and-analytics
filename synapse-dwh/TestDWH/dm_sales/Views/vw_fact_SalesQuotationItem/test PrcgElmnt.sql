CREATE PROCEDURE [tc.dm_sales.vw_fact_SalesQuotationItem].[test PrcgElmnt]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
  IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;
    
  -- Assemble: Fake Table
  EXEC tSQLt.FakeTable '[edw]', '[fact_SalesQuotationItemPrcgElmnt]'; 
  EXEC tSQLt.FakeTable '[edw]', '[fact_SalesDocumentItem]';

  INSERT INTO edw.fact_SalesQuotationItemPrcgElmnt (
    [SalesQuotation]
    ,[SalesQuotationItem]
    ,[CurrencyTypeID]
    ,[ConditionType]
    ,[ConditionAmount]
    ,[nk_SalesQuotationItem]
    ,[PricingProcedureStep]
    ,[PricingProcedureCounter]
  )
  VALUES
    ('0000000001', '000010', '10', 'ZC10', 100, '1000010', 'TST','TST')
    ,('0000000001', '000010', '10', 'ZCF1', 200, '1000010', 'TST','TST')
    ,('0000000001', '000010', '10', 'VPRS', 400, '1000010', 'TST','TST')
    ,('0000000001', '000010', '10', 'EK02', 300, '1000010', 'TST','TST')
    ,('0000000001', '000010', '10', 'TST1', 100, '1000010', 'TST','TST');

  INSERT INTO edw.fact_SalesDocumentItem (
    [SalesDocument]
    ,[SalesDocumentItem]
    ,[CurrencyTypeID]
    ,[nk_fact_SalesDocumentItem]
    ,[CurrencyType]
    ,[SDDocumentCategoryID]
  )
  VALUES
    ('0000000001', '000010', '10', '1000010', 'Transaction Currency','B');

 
-- Act: 
  SELECT
    [QuotationID]
    ,[QuotationItemID]
    ,[PrcgElmntZC10ConditionAmount]
    ,[PrcgElmntZCF1ConditionAmount]
    ,[PrcgElmntVPRS/EK02ConditionAmount]
  INTO actual
  FROM [dm_sales].[vw_fact_SalesQuotationItem];

  SELECT TOP 0 * INTO expected FROM actual;

  INSERT INTO expected (
    [QuotationID]
    ,[QuotationItemID]
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
