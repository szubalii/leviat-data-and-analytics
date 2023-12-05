CREATE PROCEDURE [tc.dm_sales.vw_fact_SalesOrderItem].[test uniqueness]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
  -- Assemble: Fake Table
  EXEC tSQLt.FakeTable '[edw]', '[fact_SalesOrderItemPricingElement]'; 
  EXEC tSQLt.FakeTable '[edw]', '[vw_fact_SalesDocumentItem]';

  INSERT INTO edw.fact_SalesOrderItemPricingElement (
    [SalesOrder]
    ,[SalesOrderItem]
    ,[CurrencyTypeID]
    ,[ConditionType]
    ,[ConditionAmount]
    ,[nk_SalesOrderItem]
    ,[PricingProcedureStep]
    ,[PricingProcedureCounter]
  )
  VALUES
    ('0000000001', '000010', '10', 'ZC10', 100, '1000010', 'TST','TST')
    ,('0000000001', '000010', '10', 'ZCF1', 200, '1000010', 'TST','TST')
    ,('0000000001', '000010', '10', 'VPRS', 400, '1000010', 'TST','TST')
    ,('0000000001', '000010', '10', 'EK02', 300, '1000010', 'TST','TST')
    ,('0000000001', '000010', '10', 'TST1', 100, '1000010', 'TST','TST');

  INSERT INTO edw.vw_fact_SalesDocumentItem (
    [SalesDocument]
    ,[SalesDocumentItem]
    ,[CurrencyTypeID]
    ,[CurrencyType]
    ,[SDDocumentCategoryID]
  )
  VALUES
    ('0000000001', '000010', '10', 'Transaction Currency','A');

  -- Act: 
  SELECT
    sk_fact_SalesDocumentItem
  INTO actual
  FROM [dm_sales].[vw_fact_SalesOrderItem]
  GROUP BY
    sk_fact_SalesDocumentItem
  HAVING COUNT(*) > 1

  -- Assert:
  EXEC tSQLt.AssertEmptyTable 'actual';
END;
