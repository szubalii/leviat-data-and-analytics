﻿CREATE PROCEDURE [tc.edw.svf_getSalesDocItem].[test logic]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
  IF OBJECT_ID('testdata') IS NOT NULL DROP TABLE testdata;
  IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;

  -- Assemble:
  CREATE TABLE testdata (
    SalesDocumentID NVARCHAR(10),
    SalesDocumentItemID CHAR(6),
    SubsequentDocument NVARCHAR(10),
    PrecedingDocument NVARCHAR(10),
    AccountingDocumentTypeID VARCHAR(2)
  );
  INSERT INTO testdata (SalesDocumentID, SalesDocumentItemID, SubsequentDocument, PrecedingDocument)
  VALUES 
    ('001008', '000001', '1', null)
    ,('001008', '000002', null, null)
    ,('008001', '000003', null, '2')
    ,('008001', '000004', null, null)
    ,('000', '000005', null, null);

  -- Act:
  SELECT
    SalesDocumentID, SalesDocumentItemID, SubsequentDocument, PrecedingDocument,
    [edw].[svf_getSalesDocItem](SalesDocumentID, SalesDocumentItemID, SubsequentDocument, PrecedingDocument) AS [SalesDoc]
  INTO actual
  FROM testdata;

  -- Assert:
  CREATE TABLE expected (
    SalesDocumentID NVARCHAR(10),
    SalesDocumentItemID CHAR(6),
    SubsequentDocument NVARCHAR(10),
    PrecedingDocument NVARCHAR(10),
    SalesDoc NVARCHAR(10)
  );

  INSERT INTO expected (SalesDocumentID, SalesDocumentItemID, SubsequentDocument, PrecedingDocument, SalesDoc)
  VALUES 
    ('001008', '000001', '1', null, '1')
    ,('001008', '000002', null, null, '000002')
    ,('008001', '000003', null, '2', '2')
    ,('008001', '000004', null, null, '000004')
    ,('000', '000005', null, null, '000005');

  EXEC tSQLt.AssertEqualsTable 'expected', 'actual';
END;
