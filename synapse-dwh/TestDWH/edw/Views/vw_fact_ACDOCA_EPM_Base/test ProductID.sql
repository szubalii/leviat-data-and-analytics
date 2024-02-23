CREATE PROCEDURE [tc.edw.vw_fact_ACDOCA_EPM_Base].[test ProductID]
AS
BEGIN
  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
  IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;
  IF OBJECT_ID('tempdb..#vw_CurrencyConversionRate') IS NOT NULL DROP TABLE #vw_CurrencyConversionRate;

  -- Assemble: Fake Table
  EXEC tSQLt.FakeTable '[edw]', '[fact_ACDOCA]';
  EXEC tSQLt.FakeTable '[edw]', '[fact_SalesDocumentItem]';
  EXEC tSQLt.FakeTable '[edw]', '[vw_CurrencyConversionRate]';
  EXEC tSQLt.FakeTable '[dm_sales]', '[vw_dim_CurrencyType]';

  INSERT INTO edw.fact_ACDOCA (
    SalesReferenceDocumentCalculated,
    SalesReferenceDocumentItemCalculated,
    CompanyCodeCurrency,
    BillingDocumentTypeID,
    ProductID,
    GLAccountID,
    SoldProduct
  )
  VALUES
  ('SD1', '01', 'EUR', '', '', '0001', '111'),
  ('SD2', '02', 'EUR', '', NULL, '0002', ''),
  ('SD3', '03', 'EUR', 'BT3', '', '0003', '333'),
  ('SD4', '04', 'EUR', 'XC4', '114', '0004', '444'),
  ('SD5', '05', 'EUR', 'VM5', '', '0005', '555');

  INSERT INTO edw.fact_SalesDocumentItem (
    SalesDocument,
    SalesDocumentItem,
    MaterialID,
    CurrencyTypeID
  )
  VALUES
  ('SD1', '01', '', '10'),
  ('SD2', '02', '', '10'),
  ('SD3', '03', '0003', '10'),
  ('SD4', '04', '', '10'),
  ('SD5', '05', '', '10');


  INSERT INTO dm_sales.vw_dim_CurrencyType (
    CurrencyTypeID
  )
  VALUES
  ('10');

  
  SELECT TOP(0) *
  INTO #vw_CurrencyConversionRate
  FROM edw.vw_CurrencyConversionRate;

  INSERT INTO #vw_CurrencyConversionRate (
    SourceCurrency,
    CurrencyTypeID
  )
  VALUES
    ('EUR', 10);

  EXEC ('INSERT INTO edw.vw_CurrencyConversionRate SELECT * FROM #vw_CurrencyConversionRate');


  -- Act: 
  SELECT
    SalesReferenceDocumentCalculated,
    ProductID
  INTO actual
  FROM [edw].[vw_fact_ACDOCA_EPM_Base];

  -- Assert:
  SELECT TOP(0) *
  INTO expected
  FROM actual;

  INSERT INTO expected (
    SalesReferenceDocumentCalculated,
    ProductID
  )
  VALUES
    ('SD1', '111'),
    ('SD2', '(MA)-0002'),
    ('SD3', '0003'),
    ('SD4', '114'),
    ('SD5', '555');

  EXEC tSQLt.AssertEqualsTable 'expected', 'actual';

END