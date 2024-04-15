CREATE PROCEDURE [tc.edw.vw_ACDOCA].[test SalesOrganizationID]
AS
BEGIN
  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
  IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;
  IF OBJECT_ID('tempdb..#vw_GLAccountLineItemRawData') IS NOT NULL DROP TABLE #vw_GLAccountLineItemRawData;
  IF OBJECT_ID('tempdb..#vw_ACDOCA_ReferenceSalesDocument') IS NOT NULL DROP TABLE #vw_ACDOCA_ReferenceSalesDocument;

  -- Assemble: Fake Table
  EXEC tSQLt.FakeTable '[edw]', '[vw_GLAccountLineItemRawData]';
  EXEC tSQLt.FakeTable '[edw]', '[vw_ACDOCA_ReferenceSalesDocument]';
  EXEC tSQLt.FakeTable '[edw]', '[fact_SalesDocumentItem]';

  INSERT INTO edw.fact_SalesDocumentItem (
    SalesDocument,
    SalesDocumentItem,
    CurrencyTypeID,
    SalesOrganizationID
  )
  VALUES
  ('0020038952', '000010', '10', 'PL01'),
  ('0020038952', '000020', '10', 'PL01'),
  ('0020038952', '000030', '10', 'PL01'),
  ('0020038952', '000040', '10', 'PL01');


  SELECT TOP(0) *
  INTO #vw_GLAccountLineItemRawData
  FROM edw.vw_GLAccountLineItemRawData;

 INSERT INTO #vw_GLAccountLineItemRawData (
    SourceLedgerID,
    CompanyCodeID,
    FiscalYear,
    AccountingDocument,
    LedgerGLLineItem,
    SalesDocumentID,
    SalesDocumentItemID
  )
  VALUES
  ('OC', 'PL35', '2023', '9900000093', '000001', '0020038952', '000000'),
  ('OC', 'PL35', '2023', '9900000093', '000008', '', ''),
  ('L1', 'CH35', '2023', '0090011594', '000016', '0020020683', '000030');

  EXEC ('INSERT INTO edw.vw_GLAccountLineItemRawData SELECT * FROM #vw_GLAccountLineItemRawData');
  

  SELECT TOP(0) *
  INTO #vw_ACDOCA_ReferenceSalesDocument
  FROM edw.vw_ACDOCA_ReferenceSalesDocument;

  INSERT INTO #vw_ACDOCA_ReferenceSalesDocument (
    SourceLedgerID,
    CompanyCodeID, 
    FiscalYear,
    AccountingDocument, 
    LedgerGLLineItem,
    SalesReferenceDocumentCalculated,
    SalesReferenceDocumentItemCalculated,
    SDI_SalesOrganizationID
  )
  VALUES
  ('L1', 'CH35', '2023', '0090011594', '000016', '0020020683', '000030', 'CH01');

  EXEC ('INSERT INTO edw.vw_ACDOCA_ReferenceSalesDocument SELECT * FROM #vw_ACDOCA_ReferenceSalesDocument');


  -- Act: 
  SELECT
    SourceLedgerID,
    CompanyCodeID, 
    FiscalYear,
    AccountingDocument, 
    LedgerGLLineItem,
    SDI_SalesOrganizationID
  INTO actual
  FROM [edw].[vw_ACDOCA];

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
    SDI_SalesOrganizationID
  )
  VALUES
    ('OC', 'PL35', '2023', '9900000093', '000001', 'PL01'),
    ('OC', 'PL35', '2023', '9900000093', '000008', NULL),
    ('L1', 'CH35', '2023', '0090011594', '000016', 'CH01');



  EXEC tSQLt.AssertEqualsTable 'expected', 'actual';

END