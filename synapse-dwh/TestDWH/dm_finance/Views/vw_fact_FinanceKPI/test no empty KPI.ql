CREATE PROCEDURE [tc.dm_finance.vw_fact_FinanceKPI].[test no empty KPI]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
    
  -- Assemble: Fake Table
  EXEC tSQLt.FakeTable '[edw]', '[dim_FiscalCalendar]';
  EXEC tSQLt.FakeTable '[edw]', '[dim_CompanyCode]';
  EXEC tSQLt.FakeTable '[edw]', '[fact_ACDOCA]';
  EXEC tSQLt.FakeTable '[edw]', '[dim_ExchangeRates]';
  EXEC tSQLt.FakeTable '[edw]', '[dim_CurrencyType]';
  EXEC tSQLt.FakeTable '[edw]', '[dim_ZE_EXQLMAP_DT]';
  EXEC tSQLt.FakeTable '[edw]', '[fact_VendorInvoice_ApprovedAndPosted]';
  EXEC tSQLt.FakeTable '[edw]', '[fact_GRIRAccountReconciliation]';
  EXEC tSQLt.FakeTable '[edw]', '[fact_ScheduleLineShippedNotBilled]';
   
  INSERT INTO edw.vw_fact_ACDOCA_EPM_Base (
    FiscalYear,
    FiscalPeriod,
    FiscalYearPeriod
  )
  VALUES
    ('2023', '008', '2023008'),
    ('2023', '009', '2023009'),
    ('2023', '010', '2023010');

  INSERT INTO edw.dim_CompanyCode (
    CompanyCodeID
  )
  VALUES
    ('NZ35');

  INSERT INTO edw.fact_ACDOCA (
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
  ('NZ35',
    '2023',
    '8',
    '2023008',
    123,
    123,
    100,
    'GBP',
    '1111',
    'TST1',
    'T',
    '12345',
    '1111')
    , ('NZ35',
    '2023',
    '8',
    '2023008',
    123,
    123,
    100,
    'GBP',
    '1112',
    'TST1',
    'T',
    '12345',
    '1111');

  INSERT INTO edw.dim_ExchangeRates (
    SourceCurrency,
    TargetCurrency,
    ExchangeRate,
    ExchangeRateEffectiveDate,
    ExchangeRateType,
  )
  VALUES
  ('GBP','EUR','1.1', '2020-01-01', 'P'),
  ('USD','EUR','1.2', '2020-01-01', 'P');

  INSERT INTO edw.dim_ZE_EXQLMAP_DT (
    GLAccountID,
    FunctionalAreaID,
    CONTIGENCY4,
    CONTIGENCY5
  )
  VALUES
  ( '1111', 'TST1', 'Gross Margin',null)
  ,( '1112', 'TST1', null, 'Opex');

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
  SELECT *
  INTO actual
  FROM [dm_finance].[vw_fact_ACDOCA_EPMSalesView];

  INSERT INTO [edw].[fact_VendorInvoice_ApprovedAndPosted] (
    CompanyCodeID,
    HDR1_PostingDate,
    HDR2_AccountingDocument,
    HDR1_DocumentType,
    HDR1_NotFirstPass
  )
  VALUES
    ('NZ35', '2023-08-01', 1, 'PO_S4', '')
    ,('NZ35', '2023-08-01', 1, 'NPO_S4', '');

  INSERT INTO [edw].[fact_GRIRAccountReconciliation] (
    CompanyCodeID,
    ReportDate,
    OldestOpenItemPostingDate,
    PurchasingDocument,
    BalAmtInCompanyCodeCrcy
  )
  VALUES
    ('NZ35', '2023-08-01', '2023-05-01',1,100)
    ,('NZ35', '2023-08-01', '2023-09-01',1,100)
    ('NZ35', '2023-08-01', '2023-04-01',2,100);

  INSERT INTO [edw].[fact_ScheduleLineShippedNotBilled]
  ( CompanyCode,
    ReportDate,
    SDI_ODB_LatestActualGoodsMovmtDate,
    OpenInvoicedValue)
  VALUES
    ('NZ35', '2023-08-01', '2023-04-01', 100)
    ,('NZ35', '2023-09-01', '2023-04-01', 100)
    ,('NZ35', '2023-10-01', '2023-04-01', 100)
    ,('NZ35', '2023-11-01', '2023-04-01', 100);

-- Act: 
  SELECT
    CompanyCodeID,
    FiscalYear,
    FiscalPeriod,
    FiscalYearPeriod,
    ManualJournalEntriesCount,
    ManualInventoryAdjustmentsCount,
    IC_Balance_KPI,
    SalesAmount,
    OtherCoSExclFreight,
    CustomerInvoicesCount,
    InvoicesCount,
    POInvoicesCount,
    NPOInvoicesCount,
    FirstTimePassCount,
    AgedGRPurchaseOrderCount,
    AgedGRPurchaseOrdersAmount,
    SOShippedNotBilledAmount
  INTO actual
  FROM [dm_finance].[vw_fact_FinanceKPI]
  WHERE
    ManualJournalEntriesCount IS NULL OR
    ManualInventoryAdjustmentsCount IS NULL OR
    IC_Balance_KPI IS NULL OR
    SalesAmount IS NULL OR
    OtherCoSExclFreight IS NULL OR
    CustomerInvoicesCount IS NULL OR
    InvoicesCount IS NULL OR
    POInvoicesCount IS NULL OR
    NPOInvoicesCount IS NULL OR
    FirstTimePassCount IS NULL OR
    AgedGRPurchaseOrderCount IS NULL OR
    AgedGRPurchaseOrdersAmount IS NULL OR
    SOShippedNotBilledAmount IS NULL;
  -- Assert:
  EXEC tSQLt.AssertEmptyTable 'actual';
END;
