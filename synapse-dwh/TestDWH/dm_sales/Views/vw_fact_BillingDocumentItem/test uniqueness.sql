CREATE PROCEDURE [tc.dm_sales.vw_fact_BillingDocumentItem].[test uniqueness]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
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
    sk_fact_BillingDocumentItem
  INTO actual
  FROM [dm_sales].[vw_fact_BillingDocumentItem]
  GROUP BY
    sk_fact_BillingDocumentItem
  HAVING COUNT(*) > 1

  -- Assert:
  EXEC tSQLt.AssertEmptyTable 'actual';
END;
