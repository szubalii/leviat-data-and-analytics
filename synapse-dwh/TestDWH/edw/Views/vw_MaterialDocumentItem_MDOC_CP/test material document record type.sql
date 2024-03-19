CREATE PROCEDURE [tc.edw.vw_MaterialDocumentItem_MDOC_CP].[test material document record type]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
  IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;

  -- Assemble: Fake Table
  EXEC tSQLt.FakeTable '[base_s4h_cax]', '[I_MaterialDocumentItem]';
  EXEC tSQLt.FakeTable '[base_s4h_cax]', '[Z_I_MaterialDocumentItem_MDOC_CP]';


  INSERT INTO [base_s4h_cax].[I_MaterialDocumentItem] (
    MANDT,
    MaterialDocumentYear,
    MaterialDocument,
    MaterialDocumentItem,
    MaterialDocumentRecordType
  )
  VALUES
    ( 200, 2024, 1, 1, 'MDOC'),
    ( 200, 2024, 1, 2, 'MDOC'),
    ( 200, 2024, 2, 1, 'MDOC'),    
    ( 200, 2024, 3, 1, 'MDOC');

-- #2
  INSERT INTO [base_s4h_cax].[Z_I_MaterialDocumentItem_MDOC_CP] (
    MANDT,
    MaterialDocumentYear,
    MaterialDocument,
    MaterialDocumentItem,
    MaterialDocumentRecordType
  )
  VALUES
    ( 200, 2024, 2, 1, 'MDOC_CP'),    
    ( 200, 2024, 3, 1, 'MDOC_CP'),
    ( 200, 2024, 4, 1, 'MDOC_CP'),
    ( 200, 2024, 5, 1, 'MDOC_CP')    ;

  -- Act: 
  SELECT
    MaterialDocumentYear,
    MaterialDocument,
    MaterialDocumentItem,
    MaterialDocumentRecordType
  INTO actual
  FROM [edw].[vw_MaterialDocumentItem_MDOC_CP];

  -- Assert:
  SELECT TOP(0) *
  INTO expected
  FROM actual;

  INSERT INTO expected (
    MaterialDocumentYear,
    MaterialDocument,
    MaterialDocumentItem,
    MaterialDocumentRecordType
  )
  VALUES
    (200, 2024, 1, 1, 'MDOC'),
    (200, 2024, 1, 2, 'MDOC'),
    (200, 2024, 2, 1, 'MDOC'),
    (200, 2024, 3, 1, 'MDOC'),
    (200, 2024, 4, 1, 'MDOC_CP'),
    (200, 2024, 5, 1, 'MDOC_CP');

  EXEC tSQLt.AssertEqualsTable 'expected', 'actual';
END