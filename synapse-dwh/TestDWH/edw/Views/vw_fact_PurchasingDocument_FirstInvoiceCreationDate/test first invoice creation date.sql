CREATE PROCEDURE [tc.edw.vw_fact_PurchasingDocument_FirstInvoiceCreationDate].[test first invoice creation date]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
  IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;

  -- Assemble: Fake Table
  EXEC tSQLt.FakeTable '[edw]', '[fact_PurchasingDocument]';
  EXEC tSQLt.FakeTable '[edw]', '[fact_VendorInvoice_ApprovedAndPosted]';
  EXEC tSQLt.FakeTable '[edw]', '[fact_SupplierInvoice]';

  
  INSERT INTO edw.fact_PurchasingDocument (PurchasingDocument)
  VALUES
    (1),
    (2);

  INSERT INTO edw.fact_VendorInvoice_ApprovedAndPosted (
    DocumentLedgerID,
    DocumentItemID,
    PurchasingDocument,
    HDR2_SupplierInvoiceID
  )
  VALUES
    (1, 1, 1, 1),
    (1, 1, 1, 2),
    (1, 1, 2, 3),
    (1, 1, 2, 4);

  INSERT INTO edw.fact_SupplierInvoice (SupplierInvoiceID, CreationDate)
  VALUES
    (1, '2020-12-31'),
    (2, '2020-12-31'),
    (3, '2020-12-31'),
    (4, '2020-11-30');

  -- Act: 
  SELECT
    PurchasingDocument,
    FirstInvoiceCreationDate
  INTO actual
  FROM [edw].[vw_fact_PurchasingDocument_FirstInvoiceCreationDate]

  -- Assert:
  CREATE TABLE expected (
    PurchasingDocument INT,
    FirstInvoiceCreationDate DATE
  )

  INSERT INTO expected (PurchasingDocument, FirstInvoiceCreationDate)
  VALUES
    (1, '2020-12-31'),
    (2, '2020-11-30');

  EXEC tSQLt.AssertEqualsTable 'expected', 'actual';
END;
GO