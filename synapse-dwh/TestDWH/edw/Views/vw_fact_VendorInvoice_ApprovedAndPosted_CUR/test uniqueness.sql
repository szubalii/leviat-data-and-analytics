CREATE PROCEDURE [tc.edw.vw_fact_VendorInvoice_ApprovedAndPosted_CUR].[test uniqueness]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
  IF OBJECT_ID('tempdb..#vw_CurrencyConversionRate') IS NOT NULL DROP TABLE #vw_CurrencyConversionRate;
  -- IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;

  -- Assemble: Fake Table
  EXEC tSQLt.FakeTable '[edw]', '[fact_VendorInvoice_ApprovedAndPosted]';
  EXEC tSQLt.FakeTable '[edw]', '[vw_CurrencyConversionRate]';
  EXEC tSQLt.FakeTable '[edw]', '[fact_PurchasingDocumentItem]';

  INSERT INTO edw.fact_VendorInvoice_ApprovedAndPosted (
    DocumentLedgerID,
    DocumentItemID,
    HDR1_CurrencyID,
    PurchasingDocument,
    PurchasingDocumentItem
  )
  VALUES
    (1, 1, 'EUR', 1, 1),
    (1, 2, 'EUR', 1, 2),
    (2, 1, 'PLN', 2, 1),
    (2, 2, 'PLN', 2, 2);

  SELECT TOP(0) *
  INTO #vw_CurrencyConversionRate
  FROM edw.vw_CurrencyConversionRate;

  -- #2
  INSERT INTO #vw_CurrencyConversionRate (SourceCurrency, CurrencyTypeID, ExchangeRate)
  VALUES
    ('EUR', '30', 1.0),
    ('EUR', '40', 0.9),
    ('PLN', '30', 0.05),
    ('PLN', '40', 0.04);

  EXEC ('INSERT INTO edw.vw_CurrencyConversionRate SELECT * FROM #vw_CurrencyConversionRate');

  INSERT INTO edw.fact_PurchasingDocumentItem (
    PurchasingDocument,
    PurchasingDocumentItem
  )
  VALUES
    (1, 1),
    (1, 2),
    (2, 1),
    (2, 2);

  -- Act: 
  SELECT
    DocumentLedgerID,
    DocumentItemID
  INTO actual
  FROM [edw].[vw_fact_VendorInvoice_ApprovedAndPosted_CUR]
  GROUP BY
    DocumentLedgerID,
    DocumentItemID
  HAVING COUNT(*) > 1

  -- Assert:
  EXEC tSQLt.AssertEmptyTable 'actual';
END;
