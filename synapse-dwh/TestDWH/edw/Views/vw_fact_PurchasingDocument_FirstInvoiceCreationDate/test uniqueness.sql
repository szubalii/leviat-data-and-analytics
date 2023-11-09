CREATE PROCEDURE [tc.edw.vw_fact_PurchasingDocument_FirstInvoiceCreationDate].[test uniqueness]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
  -- IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;

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

  INSERT INTO edw.fact_SupplierInvoice (SupplierInvoiceID)
  VALUES
    (1),
    (2),
    (3),
    (4);

  -- Act: 
  SELECT
    PurchasingDocument
  INTO actual
  FROM [edw].[vw_fact_PurchasingDocument_FirstInvoiceCreationDate]
  GROUP BY PurchasingDocument
  HAVING COUNT(*) > 1

  -- Assert:
  EXEC tSQLt.AssertEmptyTable 'actual';
END;
GO