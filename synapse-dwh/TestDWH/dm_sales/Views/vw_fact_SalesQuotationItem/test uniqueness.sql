CREATE PROCEDURE [tc.dm_sales.vw_fact_SalesQuotationItem].[test uniqueness]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
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
    sk_fact_SalesQuotationItem
  INTO actual
  FROM [dm_sales].[vw_fact_SalesQuotationItem]
  GROUP BY
    sk_fact_SalesQuotationItem
  HAVING COUNT(*) > 1

  -- Assert:
  EXEC tSQLt.AssertEmptyTable 'actual';
END;
