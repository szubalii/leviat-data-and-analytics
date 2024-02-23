CREATE PROCEDURE [tc.edw.vw_fact_ACDOCA_EPM_Base].[test SalesOrganizationID]
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
    SalesOrganizationID
  )
  VALUES
  ('SD1', '01', 'EUR', '', ''),
  ('SD2', '02', 'EUR', '', NULL),
  ('SD3', '03', 'EUR', 'BT3', 'SO3'),
  ('SD4', '04', 'EUR', '', 'SO4'),
  ('SD5', '05', 'EUR', '', '');

  INSERT INTO edw.fact_SalesDocumentItem (
    SalesDocument,
    SalesDocumentItem,
    SalesOrganizationID,
    CurrencyTypeID
  )
  VALUES
  ('SD1', '01', 'SO01', '10'),
  ('SD2', '02', 'SO02', '10'),
  ('SD3', '03', 'SO03', '10'),
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
    SalesOrganizationID
  INTO actual
  FROM [edw].[vw_fact_ACDOCA_EPM_Base];

  -- Assert:
  SELECT TOP(0) *
  INTO expected
  FROM actual;

  INSERT INTO expected (
    SalesReferenceDocumentCalculated,
    SalesOrganizationID
  )
  VALUES
    ('SD1', 'SO01'),
    ('SD2', 'SO02'),
    ('SD3', 'SO3'),
    ('SD4', 'SO4'),
    ('SD5', 'MA-Dummy');

  EXEC tSQLt.AssertEqualsTable 'expected', 'actual';

END