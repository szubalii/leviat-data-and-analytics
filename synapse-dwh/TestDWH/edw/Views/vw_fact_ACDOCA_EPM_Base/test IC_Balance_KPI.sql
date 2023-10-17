CREATE PROCEDURE [tc.dm_finance.vw_fact_ACDOCA_EPMSalesView].[test IC_Balance_KPI]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
  IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;

  -- Assemble: Fake Table
  EXEC tSQLt.FakeTable '[edw]', '[fact_ACDOCA]';
  EXEC tSQLt.FakeTable '[edw]', '[vw_CurrencyConversionRate]';
   
  SELECT *
  INTO edw.fact_ACDOCA
  FROM (
      SELECT *
    FROM
    ( SELECT  GLAccountID FROM base_ff.IC_ReconciliationGLAccounts
      UNION ALL SELECT '1111111111'
      UNION ALL SELECT NULL
    ) a
    CROSS JOIN (
        SELECT 'DE35' AS PartnerCompanyID
        UNION ALL SELECT ''
        UNION ALL SELECT NULL
    ) b
    CROSS JOIN (
      SELECT 10 AS AmountInCompanyCodeCurrency
    ) c
  ) d;

  SELECT TOP(0) *
  INTO #vw_CurrencyConversionRate
  FROM edw.vw_CurrencyConversionRate;

  -- #2
  INSERT INTO #vw_CurrencyConversionRate (SourceCurrency, CurrencyTypeID, ExchangeRate)
  VALUES
    ('EUR', '30', 50),
    ('EUR', '40', 50),
    ('PLN', '30', 50),
    ('PLN', '40', 50);

  EXEC ('INSERT INTO edw.vw_CurrencyConversionRate SELECT * FROM #vw_CurrencyConversionRate');


  -- Act: 
  SELECT IC_Balance_KPI
  INTO actual
  FROM [edw].[vw_fact_ACDOCA_EPM_Base];

  -- Assert:
  CREATE TABLE expected (
    IC_Balance_KPI INT
  );

  INSERT INTO expected(
    IC_Balance_KPI
    
  )
  VALUES
    (NULL),
    (500);

  EXEC tSQLt.AssertEqualsTable 'expected', 'actual';
END;
