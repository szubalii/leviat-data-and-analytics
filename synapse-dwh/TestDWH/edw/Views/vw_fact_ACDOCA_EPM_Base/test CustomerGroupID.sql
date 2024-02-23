CREATE PROCEDURE [tc.edw.vw_fact_ACDOCA_EPM_Base].[test CustomerGroupID]
AS
BEGIN
  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
  IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;
  IF OBJECT_ID('tempdb..#vw_CurrencyConversionRate') IS NOT NULL DROP TABLE #vw_CurrencyConversionRate;

  -- Assemble: Fake Table
  EXEC tSQLt.FakeTable '[edw]', '[fact_ACDOCA]';
  EXEC tSQLt.FakeTable '[edw]', '[fact_SalesDocumentItem]';
  EXEC tSQLt.FakeTable '[edw]', '[dim_CustomerGroup]';
  EXEC tSQLt.FakeTable '[base_s4h_cax]','[I_CustomerSalesArea]';
  EXEC tSQLt.FakeTable '[edw]', '[vw_CurrencyConversionRate]';
  EXEC tSQLt.FakeTable '[dm_sales]', '[vw_dim_CurrencyType]';

  INSERT INTO edw.fact_ACDOCA (
    SalesReferenceDocumentCalculated,
    SalesReferenceDocumentItemCalculated,
    CompanyCodeCurrency,
    BillingDocumentTypeID,
    GLAccountID,
    CustomerID,
    SalesOrganizationID
  )
  VALUES
  ('SD1', '01', 'EUR', '',  '0001', 'Cust1', '01'),
  ('SD2', '02', 'EUR', '',  '0002', 'Cust2', '02'),
  ('SD3', '03', 'EUR', 'BT3', '0003', 'Cust3', '03'),
  ('SD4', '04', 'EUR', 'XC4', '0004', 'Cust4', '04'),
  ('SD5', '05', 'EUR', 'VM5', '0005', 'Cust5', '05');

  INSERT INTO edw.fact_SalesDocumentItem (
    SalesDocument,
    SalesDocumentItem,
    SoldToPartyID,
    CurrencyTypeID
  )
  VALUES
  ('SD1', '01', '0001', '10'),
  ('SD2', '02', '0002', '10'),
  ('SD3', '03', '0003', '10'),
  ('SD4', '04', '', '10'),
  ('SD5', '05', '0005', '10');

  INSERT INTO edw.dim_CustomerGroup ( CustomerGroupID ) VALUES ('0003');

  INSERT INTO [base_s4h_cax].[I_CustomerSalesArea] (
    Customer,
    SalesOrganization,
    CustomerGroup
  )
  VALUES
  ('Cust1', '01', ''),
  ('Cust2', '02', NULL),
  ('Cust3', '03', '0003'),
  ('Cust4', '04', ''),
  ('Cust5', '05', '');


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
    CustomerGroupID
  INTO actual
  FROM [edw].[vw_fact_ACDOCA_EPM_Base];

  -- Assert:
  SELECT TOP(0) *
  INTO expected
  FROM actual;

  INSERT INTO expected (
    SalesReferenceDocumentCalculated,
    CustomerGroupID
  )
  VALUES
    ('SD1', 'MA'),
    ('SD2', 'MA'),
    ('SD3', '0003'),
    ('SD4', 'MA'),
    ('SD5', '');

  EXEC tSQLt.AssertEqualsTable 'expected', 'actual';

END