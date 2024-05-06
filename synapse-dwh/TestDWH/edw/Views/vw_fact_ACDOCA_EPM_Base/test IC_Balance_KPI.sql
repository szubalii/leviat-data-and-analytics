CREATE PROCEDURE [tc.edw.vw_fact_ACDOCA_EPM_Base].[test IC_Balance_KPI]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
  IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;
  IF OBJECT_ID('tempdb..#vw_CurrencyConversionRate') IS NOT NULL DROP TABLE #vw_CurrencyConversionRate;
  IF OBJECT_ID('tempdb..#vw_dim_CurrencyType') IS NOT NULL DROP TABLE #vw_dim_CurrencyType;

  -- Assemble: Fake Table
  EXEC tSQLt.FakeTable '[base_ff]', '[IC_ReconciliationGLAccounts]';
  EXEC tSQLt.FakeTable '[edw]', '[vw_CurrencyConversionRate]';
  EXEC tSQLt.FakeTable '[edw]', '[fact_ACDOCA_active]';
  EXEC tSQLt.FakeTable '[dm_sales]', '[vw_dim_CurrencyType]';

  INSERT INTO base_ff.IC_ReconciliationGLAccounts (
    GLAccountID
  )
  VALUES
    ('0015112100'),
    ('0015112105'),
    ('0015112110'),
    ('0015112199'),
    ('0018300100'),
    ('0021102100'),
    ('0021102101'),
    ('0021102110'),
    ('0021102111'),
    ('0021102198'),
    ('0021102199'),
    ('0021390121'),
    ('0026200100'),
    ('0035200100'),
    ('0035500100'),
    ('0035500101'),
    ('0035600100'),
    ('0035700100'),
    ('0035800100');
  
  INSERT INTO edw.fact_ACDOCA_active (
    GLAccountID,
    PartnerCompanyID,
    AmountInCompanyCodeCurrency,
    CompanyCodeCurrency
  )
  VALUES
    ('0015112100', 'DE35', 10, 'PLN'),
    ('0015112105', 'DE35', 10, 'PLN'),
    ('0015112110', 'DE35', 10, 'PLN'),
    ('0015112199', 'DE35', 10, 'PLN'),
    ('0018300100', 'DE35', 10, 'PLN'),
    ('0021102100', 'DE35', 10, 'PLN'),
    ('0021102101', 'DE35', 10, 'PLN'),
    ('0021102110', 'DE35', 10, 'PLN'),
    ('0021102111', 'DE35', 10, 'PLN'),
    ('0021102198', 'DE35', 10, 'PLN'),
    ('0021102199', 'DE35', 10, 'PLN'),
    ('0021390121', 'DE35', 10, 'PLN'),
    ('0026200100', 'DE35', 10, 'PLN'),
    ('0035200100', 'DE35', 10, 'PLN'),
    ('0035500100', 'DE35', 10, 'PLN'),
    ('0035500101', 'DE35', 10, 'PLN'),
    ('0035600100', 'DE35', 10, 'PLN'),
    ('0035700100', 'DE35', 10, 'PLN'),
    ('0035800100', 'DE35', 10, 'PLN'),
    (NULL,         'DE35', 10, 'PLN'),
    ('0015112100', '',     10, 'PLN'),
    ('0015112105', '',     10, 'PLN'),
    ('0015112110', '',     10, 'PLN'),
    ('0015112199', '',     10, 'PLN'),
    ('0018300100', '',     10, 'PLN'),
    ('0021102100', '',     10, 'PLN'),
    ('0021102101', '',     10, 'PLN'),
    ('0021102110', '',     10, 'PLN'),
    ('0021102111', '',     10, 'PLN'),
    ('0021102198', '',     10, 'PLN'),
    ('0021102199', '',     10, 'PLN'),
    ('0021390121', '',     10, 'PLN'),
    ('0026200100', '',     10, 'PLN'),
    ('0035200100', '',     10, 'PLN'),
    ('0035500100', '',     10, 'PLN'),
    ('0035500101', '',     10, 'PLN'),
    ('0035600100', '',     10, 'PLN'),
    ('0035700100', '',     10, 'PLN'),
    ('0035800100', '',     10, 'PLN'),
    ('0015112100', NULL,   10, 'PLN'),
    ('0015112105', NULL,   10, 'PLN'),
    ('0015112110', NULL,   10, 'PLN'),
    ('0015112199', NULL,   10, 'PLN'),
    ('0018300100', NULL,   10, 'PLN'),
    ('0021102100', NULL,   10, 'PLN'),
    ('0021102101', NULL,   10, 'PLN'),
    ('0021102110', NULL,   10, 'PLN'),
    ('0021102111', NULL,   10, 'PLN'),
    ('0021102198', NULL,   10, 'PLN'),
    ('0021102199', NULL,   10, 'PLN'),
    ('0021390121', NULL,   10, 'PLN'),
    ('0026200100', NULL,   10, 'PLN'),
    ('0035200100', NULL,   10, 'PLN'),
    ('0035500100', NULL,   10, 'PLN'),
    ('0035500101', NULL,   10, 'PLN'),
    ('0035600100', NULL,   10, 'PLN'),
    ('0035700100', NULL,   10, 'PLN'),
    ('0035800100', NULL,   10, 'PLN');

  SELECT TOP(0) *
  INTO #vw_CurrencyConversionRate
  FROM edw.vw_CurrencyConversionRate;

  INSERT INTO #vw_CurrencyConversionRate (
    SourceCurrency,
    CurrencyTypeID,
    ExchangeRate
  )
  VALUES
    ('PLN', 10, .1);

  EXEC ('INSERT INTO edw.vw_CurrencyConversionRate SELECT * FROM #vw_CurrencyConversionRate');


  SELECT TOP(0) *
  INTO #vw_dim_CurrencyType
  FROM dm_sales.vw_dim_CurrencyType;

  INSERT INTO #vw_dim_CurrencyType (
    CurrencyTypeID
  )
  VALUES
    (10);

  EXEC ('INSERT INTO dm_sales.vw_dim_CurrencyType SELECT * FROM #vw_dim_CurrencyType');

  -- Act: 
  SELECT
    GLAccountID,
    PartnerCompanyID,
    IC_Balance_KPI
  INTO actual
  FROM [edw].[vw_fact_ACDOCA_EPM_Base];

  -- Assert:
  CREATE TABLE expected (
    [GLAccountID] NVARCHAR(20),
    [PartnerCompanyID] CHAR(4),
    [IC_Balance_KPI] INT
  );

  INSERT INTO expected (
    GLAccountID,
    PartnerCompanyID,
    IC_Balance_KPI
  )
  VALUES
    ('0015112100', 'DE35', 1),
    ('0015112105', 'DE35', 1),
    ('0015112110', 'DE35', 1),
    ('0015112199', 'DE35', 1),
    ('0018300100', 'DE35', 1),
    ('0021102100', 'DE35', 1),
    ('0021102101', 'DE35', 1),
    ('0021102110', 'DE35', 1),
    ('0021102111', 'DE35', 1),
    ('0021102198', 'DE35', 1),
    ('0021102199', 'DE35', 1),
    ('0021390121', 'DE35', 1),
    ('0026200100', 'DE35', 1),
    ('0035200100', 'DE35', 1),
    ('0035500100', 'DE35', 1),
    ('0035500101', 'DE35', 1),
    ('0035600100', 'DE35', 1),
    ('0035700100', 'DE35', 1),
    ('0035800100', 'DE35', 1),
    (NULL,         'DE35', NULL),
    ('0015112100', '',     NULL),
    ('0015112105', '',     NULL),
    ('0015112110', '',     NULL),
    ('0015112199', '',     NULL),
    ('0018300100', '',     NULL),
    ('0021102100', '',     NULL),
    ('0021102101', '',     NULL),
    ('0021102110', '',     NULL),
    ('0021102111', '',     NULL),
    ('0021102198', '',     NULL),
    ('0021102199', '',     NULL),
    ('0021390121', '',     NULL),
    ('0026200100', '',     NULL),
    ('0035200100', '',     NULL),
    ('0035500100', '',     NULL),
    ('0035500101', '',     NULL),
    ('0035600100', '',     NULL),
    ('0035700100', '',     NULL),
    ('0035800100', '',     NULL),
    ('0015112100', NULL,   NULL),
    ('0015112105', NULL,   NULL),
    ('0015112110', NULL,   NULL),
    ('0015112199', NULL,   NULL),
    ('0018300100', NULL,   NULL),
    ('0021102100', NULL,   NULL),
    ('0021102101', NULL,   NULL),
    ('0021102110', NULL,   NULL),
    ('0021102111', NULL,   NULL),
    ('0021102198', NULL,   NULL),
    ('0021102199', NULL,   NULL),
    ('0021390121', NULL,   NULL),
    ('0026200100', NULL,   NULL),
    ('0035200100', NULL,   NULL),
    ('0035500100', NULL,   NULL),
    ('0035500101', NULL,   NULL),
    ('0035600100', NULL,   NULL),
    ('0035700100', NULL,   NULL),
    ('0035800100', NULL,   NULL);

  EXEC tSQLt.AssertEqualsTable 'expected', 'actual';
END;
