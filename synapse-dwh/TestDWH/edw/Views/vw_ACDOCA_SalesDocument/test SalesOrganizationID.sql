CREATE PROCEDURE [tc.edw.vw_ACDOCA_SalesDocument].[test SalesOrganizationID]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
  IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;
  IF OBJECT_ID('tempdb..#vw_GLAccountLineItemRawData') IS NOT NULL DROP TABLE #vw_GLAccountLineItemRawData;


  -- Assemble: Fake Table
  EXEC tSQLt.FakeTable '[edw]', '[vw_GLAccountLineItemRawData]';
  EXEC tSQLt.FakeTable '[edw]', '[fact_SalesDocumentItem]';
  

  SELECT TOP(0) *
  INTO #vw_GLAccountLineItemRawData
  FROM edw.vw_GLAccountLineItemRawData;

 INSERT INTO #vw_GLAccountLineItemRawData (
    SourceLedgerID,
    CompanyCodeID,
    FiscalYear,
    AccountingDocument,
    LedgerGLLineItem,
    SalesDocumentID
  )
  VALUES
  ('OC', 'DE35', '2024', '9900000007', '000001', '0020071703'),
  ('OC', 'DE35', '2024', '9900000007', '000002', '0020071703'),
  ('OC', 'DE35', '2024', '9900000007', '000003', '0020071703'),
  ('OC', 'DE35', '2024', '9900000007', '000004', ''),
  ('L1', 'CH35', '2024', '3333333333', '000001', '0020077777');
  

  EXEC ('INSERT INTO edw.vw_GLAccountLineItemRawData SELECT * FROM #vw_GLAccountLineItemRawData');



  INSERT INTO edw.fact_SalesDocumentItem (
     SalesDocument
    ,SalesOrganizationID
    ,CurrencyTypeID
  )
  VALUES
   ('0020071703', 'DE01', '10')
  ,('0020077777', 'CH01', '10');
  

  -- Act: 
  SELECT
    SourceLedgerID,
    CompanyCodeID, 
    FiscalYear,
    AccountingDocument, 
    LedgerGLLineItem,
    SalesOrganizationID_SDI
  INTO actual
  FROM [edw].[vw_ACDOCA_SalesDocument];

  -- Assert:
  SELECT TOP(0) *
  INTO expected
  FROM actual;

  INSERT INTO expected (
    SourceLedgerID,
    CompanyCodeID, 
    FiscalYear,
    AccountingDocument, 
    LedgerGLLineItem,
    SalesOrganizationID_SDI
  )
  VALUES
  ('OC', 'DE35', '2024', '9900000007', '000001', 'DE01'),
  ('OC', 'DE35', '2024', '9900000007', '000002', 'DE01'),
  ('OC', 'DE35', '2024', '9900000007', '000003', 'DE01'),
  ('OC', 'DE35', '2024', '9900000007', '000004', NULL),
  ('L1', 'CH35', '2024', '3333333333', '000001', 'CH01');



  EXEC tSQLt.AssertEqualsTable 'expected', 'actual';

END