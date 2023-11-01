CREATE PROCEDURE [tc.edw.vw_fact_VendorInvoice_ApprovedAndPosted_agg].[test POInvoicesCount]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
  IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;

  -- Assemble: Fake Table
  EXEC tSQLt.FakeTable '[edw]', '[fact_VendorInvoice_ApprovedAndPosted]';

  INSERT INTO edw.fact_VendorInvoice_ApprovedAndPosted (
    CompanyCodeID,
    HDR1_PostingDate,
    HDR1_DocumentType,
    HDR2_AccountingDocument
  )
  VALUES
    (1, '2019-01-01', 'PO_S4', 1),
    (1, '2020-01-01', 'ZPO_S4', 2),
    (1, '2020-01-01', 'ZPO_S4', 3),
    (1, '2020-01-01', 'ZPO_S4', 3),
    (1, '2021-01-01', NULL, 4),
    (2, '2019-01-01', 'PO_S4', 1),
    (2, '2020-01-01', 'ZPO_S4', 2),
    (2, '2020-01-01', 'ZPO_S4', 3),
    (2, '2020-01-01', 'ZPO_S4', 3),
    (2, '2021-01-01', NULL, 4);

  -- Act: 
  SELECT
    CompanyCodeID,
    FiscalYear,
    POInvoicesCount
  INTO actual
  FROM [edw].[vw_fact_VendorInvoice_ApprovedAndPosted_agg]

  -- Assert:
  CREATE TABLE expected (
    CompanyCodeID INT,
    FiscalYear INT,
    POInvoicesCount INT
  )

  INSERT INTO expected (
    CompanyCodeID,
    FiscalYear,
    POInvoicesCount
  )
  VALUES
  (1, 2019, 1),
  (1, 2020, 2),
  (1, 2021, NULL),
  (2, 2019, 1),
  (2, 2020, 2),
  (2, 2021, NULL);

  EXEC tSQLt.AssertEqualsTable 'expected', 'actual';
END;
