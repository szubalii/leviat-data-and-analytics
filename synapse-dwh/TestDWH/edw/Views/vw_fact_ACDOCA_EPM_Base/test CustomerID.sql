CREATE PROCEDURE [tc.edw.vw_fact_ACDOCA_EPM_Base].[test CustomerID]
AS
BEGIN
  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
  IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;
  IF OBJECT_ID('tempdb..#vw_CurrencyConversionRate') IS NOT NULL DROP TABLE #vw_CurrencyConversionRate;

  -- Assemble: Fake Table
  EXEC tSQLt.FakeTable '[edw]', '[fact_ACDOCA]';
  EXEC tSQLt.FakeTable '[edw]', '[vw_CurrencyConversionRate]';
  EXEC tSQLt.FakeTable '[dm_sales]', '[vw_dim_CurrencyType]';

  INSERT INTO edw.fact_ACDOCA (
    SalesReferenceDocumentCalculated,
    SalesReferenceDocumentItemCalculated,
    CompanyCodeCurrency,
    BillingDocumentTypeID,
    CustomerID,
    SDI_SoldToPartyID,
    GLAccountID
  )
  VALUES
  ('SD1', '01', 'EUR', '', '', '', '0001'),
  ('SD2', '02', 'EUR', 'BT2', NULL, '', '0002'),
  ('SD3', '03', 'EUR', 'BT3', '', '333', '0003'),
  ('SD4', '04', 'EUR', 'XC4', '114','444', '0004'),
  ('SD5', '05', 'EUR', '', '', '555', '0005');

 

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
    CustomerID
  INTO actual
  FROM [edw].[vw_fact_ACDOCA_EPM_Base];

  -- Assert:
  SELECT TOP(0) *
  INTO expected
  FROM actual;

  INSERT INTO expected (
    SalesReferenceDocumentCalculated,
    CustomerID
  )
  VALUES
    ('SD1', '(MA)-0001'),
    ('SD2', ''),
    ('SD3', '333'),
    ('SD4', '114'),
    ('SD5', '555');

  EXEC tSQLt.AssertEqualsTable 'expected', 'actual';

END