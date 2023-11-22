CREATE PROCEDURE [tc.edw.vw_fact_ACDOCA_FinanceKPI_agg].[test manual filter]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
    
  -- Assemble: Fake Table
  EXEC tSQLt.FakeTable '[edw]', '[fact_ACDOCA]';
  EXEC tSQLt.FakeTable '[edw]', '[dim_ExchangeRates]';
  EXEC tSQLt.FakeTable '[edw]', '[dim_CurrencyType]';
  EXEC tSQLt.FakeTable '[edw]', '[dim_ZE_EXQLMAP_DT]';
  EXEC tSQLt.FakeTable '[base_ff]', '[IC_ReconciliationGLAccounts]';

  INSERT INTO base_ff.IC_ReconciliationGLAccounts (
    GLAccountID
  )
  VALUES ('1111');

  INSERT INTO edw.fact_ACDOCA (
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
    [PartnerCompanyID],
    [BusinessTransactionTypeID],
    [ReferenceDocumentTypeID],
    [TransactionTypeDeterminationID]
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
    'SA',
    '12345',
    '1111',
    'RFBU',
    'BKPFF',
    'TST')
    , (
      '0L','NZ35',
    '2023',
    '8',
    '2023008',
    123,
    123,
    50,
    'GBP',
    '1112',
    'TST1',
    'RV',
    '12345',
    '1111',
    'RMBL',
    'TST',
    'UMB');

  INSERT INTO edw.dim_ExchangeRates (
    SourceCurrency,
    TargetCurrency,
    ExchangeRate,
    ExchangeRateEffectiveDate,
    ExchangeRateType
  )
  VALUES
  ('GBP','EUR','1.1', '2020-01-01', 'P'),
  ('USD','EUR','1.2', '2020-01-01', 'P');

  INSERT INTO edw.dim_ZE_EXQLMAP_DT (
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

  INSERT INTO edw.dim_CurrencyType (
    CurrencyTypeID,
    CurrencyType
  )
  VALUES
    ('00','Local'),
    ('10','Transaction'),
    ('20','Group EUR'),
    ('30','Group USD');

-- Act: 
  SELECT
    *
  INTO actual
  FROM [edw].[vw_fact_ACDOCA_FinanceKPI_agg]
  WHERE
    CompanyCodeID = 'NZ35'
    AND FiscalYearPeriod = '2023008'
    AND (
      [ManualJournalEntriesCount] <> 1
      OR
      [ManualInventoryAdjustmentsCount] <> 1
      OR [IC_Balance_KPI] <> 210
    );
  -- Assert:
  EXEC tSQLt.AssertEmptyTable 'actual';
END;
