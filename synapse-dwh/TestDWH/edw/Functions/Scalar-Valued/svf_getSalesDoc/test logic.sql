CREATE PROCEDURE [tc.edw.svf_getSalesDoc].[test logic]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
  IF OBJECT_ID('testdata') IS NOT NULL DROP TABLE testdata;
  IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;

  -- Assemble:
  CREATE TABLE testdata (
    SalesDocumentID NVARCHAR(10),
    SubsequentDocument NVARCHAR(10),
    PrecedingDocument NVARCHAR(10)
  );
  INSERT INTO testdata (SalesDocumentID, SubsequentDocument, PrecedingDocument)
  VALUES 
    ('001008', '1', null)
    ,('001008', null, null)
    ,('008001', null, '2')
    ,('008001', null, null)
    ,('000', null, null);

  -- Act:
  SELECT
    SalesDocumentID, SubsequentDocument, PrecedingDocument,
    [edw].[svf_getSalesDoc](SalesDocumentID, SubsequentDocument, PrecedingDocument) AS [SalesDoc]
  INTO actual
  FROM testdata;

  -- Assert:
  CREATE TABLE expected (
    SalesDocumentID NVARCHAR(10),
    SubsequentDocument NVARCHAR(10),
    PrecedingDocument NVARCHAR(10),
    SalesDoc NVARCHAR(10)
  );

  INSERT INTO expected (SalesDocumentID, SubsequentDocument, PrecedingDocument, SalesDoc)
  VALUES 
    ('001008', '1', null, '1')
    ,('001008', null, null, '001008')
    ,('008001', null, '2', '2')
    ,('008001', null, null, '008001')
    ,('000', null, null, '000');

  EXEC tSQLt.AssertEqualsTable 'expected', 'actual';
END;
