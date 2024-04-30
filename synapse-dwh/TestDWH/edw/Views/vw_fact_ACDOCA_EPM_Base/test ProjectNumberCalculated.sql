CREATE PROCEDURE [tc.edw.vw_fact_ACDOCA_EPM_Base].[test ProjectNumberCalculated]
AS
BEGIN
  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
  IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;
  IF OBJECT_ID('tempdb..#vw_CurrencyConversionRate') IS NOT NULL DROP TABLE #vw_CurrencyConversionRate;

  -- Assemble: Fake Table
  EXEC tSQLt.FakeTable '[edw]', '[fact_ACDOCA_active]';
  EXEC tSQLt.FakeTable '[edw]', '[dim_BillingDocProject]';
  EXEC tSQLt.FakeTable '[edw]', '[vw_CurrencyConversionRate]';
  EXEC tSQLt.FakeTable '[dm_sales]', '[vw_dim_CurrencyType]';

  INSERT INTO edw.fact_ACDOCA_active (
    AccountingDocument,
    CompanyCodeCurrency,
    SalesReferenceDocumentCalculated,
    ProjectNumber
  )
  VALUES
  ('AD1', 'EUR', 'SD1', 'ProjID_A'),
  ('AD2', 'EUR', 'SD2', ''),
  ('AD3', 'EUR', 'SD3', NULL),
  ('AD4', 'EUR', '', 'ProjID_B'),
  ('AD5', 'EUR', '', ''),
  ('AD6', 'EUR', '', NULL),
  ('AD7', 'EUR', NULL, 'ProjID_C'),
  ('AD8', 'EUR', NULL, ''),
  ('AD9', 'EUR', NULL, NULL);

  INSERT INTO edw.dim_BillingDocProject (
    SDDocument,
    ProjectID
  )
  VALUES
  ('SD1', 'ProjID_D'),
  ('SD2', 'ProjID_E'),
  ('SD3', 'ProjID_F');

  -- INSERT INTO edw.vw_CurrencyConversionRate (
  --   SourceCurrency,
  --   CurrencyTypeID
  -- )
  -- VALUES
  -- ('EUR', '10');

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
    AccountingDocument,
    ProjectNumberCalculated
  INTO actual
  FROM [edw].[vw_fact_ACDOCA_EPM_Base];

  -- Assert:
  SELECT TOP(0) *
  INTO expected
  FROM actual;

  INSERT INTO expected (
    AccountingDocument,
    ProjectNumberCalculated
  )
  VALUES
    ('AD1', 'ProjID_A'),
    ('AD2', 'ProjID_E'),
    ('AD3', 'ProjID_F'),
    ('AD4', 'ProjID_B'),
    ('AD5', ''),
    ('AD6', ''),
    ('AD7', 'ProjID_C'),
    ('AD8', ''),
    ('AD9', '');

  EXEC tSQLt.AssertEqualsTable 'expected', 'actual';

END