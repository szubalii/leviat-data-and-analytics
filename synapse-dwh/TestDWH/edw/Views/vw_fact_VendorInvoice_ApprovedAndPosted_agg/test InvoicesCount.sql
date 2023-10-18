CREATE PROCEDURE [tc.edw.vw_fact_VendorInvoice_ApprovedAndPosted_agg].[test InvoicesCount]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
  IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;

  -- Assemble: Fake Table
  EXEC tSQLt.FakeTable '[edw]', '[fact_VendorInvoice_ApprovedAndPosted]';

  INSERT INTO edw.fact_VendorInvoice_ApprovedAndPosted (
    CompanyCodeID,
    HDR1_FiscalYear,
    -- HDR1_AccountingDocumentTypeID,
    HDR2_AccountingDocument
  )
  VALUES
    (1, 2019, 1),
    (1, 2020, 2),
    (1, 2020, 3),
    (1, 2020, 3),
    (1, 2021, 4),
    (2, 2019, 1),
    (2, 2020, 2),
    (2, 2020, 3),
    (2, 2020, 3),
    (2, 2021, 4);

  -- Act: 
  SELECT
    CompanyCodeID,
    FiscalYear,
    InvoicesCount
  INTO actual
  FROM [edw].[vw_fact_VendorInvoice_ApprovedAndPosted_agg]

  -- Assert:
  CREATE TABLE expected (
    CompanyCodeID INT,
    FiscalYear INT,
    InvoicesCount INT
  )

  INSERT INTO expected (
    CompanyCodeID,
    FiscalYear,
    InvoicesCount
  )
  VALUES
  (1, 2019, 1),
  (1, 2020, 2),
  (1, 2021, 1),
  (2, 2019, 1),
  (2, 2020, 2),
  (2, 2021, 1);

  EXEC tSQLt.AssertEqualsTable 'expected', 'actual';
END;
