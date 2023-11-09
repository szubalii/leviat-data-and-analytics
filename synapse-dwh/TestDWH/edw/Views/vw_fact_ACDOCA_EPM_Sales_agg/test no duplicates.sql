CREATE PROCEDURE [tc.edw.vw_fact_ACDOCA_EPM_Sales_agg].[test no duplicates]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
    
  -- Assemble: Fake Table
  IF OBJECT_ID('tempdb..#fact_ACDOCA')                          IS NOT NULL DROP TABLE #fact_ACDOCA;
  IF OBJECT_ID('tempdb..#dim_ExchangeRates')                    IS NOT NULL DROP TABLE #dim_ExchangeRates;
  IF OBJECT_ID('tempdb..#dim_CurrencyType')                     IS NOT NULL DROP TABLE #dim_CurrencyType;
  IF OBJECT_ID('tempdb..#dim_ZE_EXQLMAP_DT')                    IS NOT NULL DROP TABLE #dim_ZE_EXQLMAP_DT;
  IF OBJECT_ID('tempdb..#IC_ReconciliationGLAccounts')          IS NOT NULL DROP TABLE #IC_ReconciliationGLAccounts;

  EXEC tSQLt.FakeTable '[edw]', '[fact_ACDOCA]';
  EXEC tSQLt.FakeTable '[edw]', '[dim_ExchangeRates]';
  EXEC tSQLt.FakeTable '[edw]', '[dim_CurrencyType]';
  EXEC tSQLt.FakeTable '[edw]', '[dim_ZE_EXQLMAP_DT]';
  EXEC tSQLt.FakeTable '[base_ff]', '[IC_ReconciliationGLAccounts]';
  
  SELECT TOP(0) *
  INTO #IC_ReconciliationGLAccounts
  FROM base_ff.IC_ReconciliationGLAccounts;

  INSERT INTO #IC_ReconciliationGLAccounts (
    GLAccountID
  )
  VALUES ('1111');

  INSERT INTO base_ff.IC_ReconciliationGLAccounts SELECT * FROM #IC_ReconciliationGLAccounts;

  SELECT TOP(0) *
  INTO #fact_ACDOCA
  FROM edw.fact_ACDOCA;

  INSERT INTO #fact_ACDOCA (
    [SourceLedgerID],
    [CompanyCodeID],
    [FiscalYear],
    [FiscalPeriod],
    [FiscalYearPeriod],
    [AccountingDocument],
    [LedgerGLLineItem],
    [AmountInCompanyCodeCurrency],
    [CompanyCodeCurrency],
    [GLAccountID],
    [FunctionalAreaID],
    [AccountingDocumentTypeID],
    [ReferenceDocument],
    [PartnerCompanyID]
  )
  VALUES
  ( '0L',
    'NZ35',
    '2023',
    '8',
    '2023008',
    123,
    123,
    100,
    'GBP',
    '1111',
    'TST1',
    'RV',
    '12345',
    '1111')
    , (
      '0L','NZ35',
    '2023',
    '8',
    '2023008',
    123,
    123,
    100,
    'GBP',
    '1112',
    'TST1',
    'RV',
    '12345',
    '1111')
    , ('0L',
    'NZ35',
    '2023',
    '8',
    '2023008',
    123,
    123,
    120,
    'GBP',
    '1113',
    'TST1',
    'RV',
    '12345',
    '1111');

  INSERT INTO edw.fact_ACDOCA SELECT * FROM #fact_ACDOCA;
  
  SELECT TOP(0) *
  INTO #dim_ExchangeRates
  FROM edw.dim_ExchangeRates;

  INSERT INTO #dim_ExchangeRates (
    SourceCurrency,
    TargetCurrency,
    ExchangeRate,
    ExchangeRateEffectiveDate,
    ExchangeRateType
  )
  VALUES
  ('GBP','EUR','1.1', '2020-01-01', 'P'),
  ('USD','EUR','1.2', '2020-01-01', 'P');

  INSERT INTO edw.dim_ExchangeRates SELECT * FROM #dim_ExchangeRates;

  SELECT TOP(0) *
  INTO #dim_ZE_EXQLMAP_DT
  FROM edw.dim_ZE_EXQLMAP_DT;

  INSERT INTO #dim_ZE_EXQLMAP_DT (
    nk_ExQLmap,
    GLAccountID,
    FunctionalAreaID,
    Contingency4,
    Contingency5
  )
  VALUES
  ( '1', '1111', 'TST1', 'Gross Margin',null)
  ,( '2', '1112', 'TST1', null, 'Opex')
  ,( '3', '1113', 'TST1', null, 'Sales');

  INSERT INTO edw.dim_ZE_EXQLMAP_DT  SELECT * FROM #dim_ZE_EXQLMAP_DT;

  SELECT TOP(0) *
  INTO #dim_CurrencyType
  FROM edw.dim_CurrencyType;

  INSERT INTO #dim_CurrencyType (
    CurrencyTypeID,
    CurrencyType
  )
  VALUES
    ('00','Local'),
    ('10','Transaction'),
    ('20','Group EUR'),
    ('30','Group USD');

  INSERT INTO edw.dim_CurrencyType SELECT * FROM #dim_CurrencyType;

-- Act: 
  SELECT
    CompanyCodeID,
    FiscalYear,
    FiscalPeriod,
    FiscalYearPeriod,
    COUNT(*)      AS cnt
  INTO actual
  FROM [edw].[vw_fact_ACDOCA_EPM_Sales_agg]
  GROUP BY 
    CompanyCodeID,
    FiscalYear,
    FiscalPeriod,
    FiscalYearPeriod
  HAVING COUNT(*)>1;
  -- Assert:
  EXEC tSQLt.AssertEmptyTable 'actual';
END;
