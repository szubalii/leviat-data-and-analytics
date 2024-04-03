CREATE PROCEDURE [tc.edw.svf_get3PartNaturalKey].[test filters]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
  IF OBJECT_ID('testdata') IS NOT NULL DROP TABLE testdata;
  IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;

  -- Assemble:
  CREATE TABLE testdata (
    MaterialDocumentYear CHAR(4),
    MaterialDocument NVARCHAR(10),
    MaterialDocumentItem CHAR(4)
  );
  INSERT INTO testdata (MaterialDocumentYear, MaterialDocument, MaterialDocumentItem)
  VALUES 
    ('2023', '5000243437', '0001')

  -- Act:
  SELECT
    MaterialDocumentYear,
    MaterialDocument,
    MaterialDocumentItem,
    [edw].[svf_get3PartNaturalKey](MaterialDocumentYear, MaterialDocument, MaterialDocumentItem) AS [nk_MaterialDocumentItem]
  INTO actual
  FROM testdata;

  -- Assert:
  CREATE TABLE expected (
    MaterialDocumentYear CHAR(4),
    MaterialDocument NVARCHAR(10),
    MaterialDocumentItem CHAR(4),
    nk_MaterialDocumentItem NVARCHAR(302)
  );

  INSERT INTO expected (MaterialDocumentYear, MaterialDocument, MaterialDocumentItem, nk_MaterialDocumentItem)
  VALUES 
     ('2023', '5000243437', '0001', '2023¦5000243437¦0001')

  EXEC tSQLt.AssertEqualsTable 'expected', 'actual';
END;
