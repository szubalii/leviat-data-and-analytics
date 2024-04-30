CREATE PROCEDURE [tc.edw.vw_fact_MaterialDocumentItem_s4h].[test filter on s4h]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
  -- IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;

  -- Assemble: Fake Table
  EXEC tSQLt.FakeTable '[edw]', '[fact_MaterialDocumentItem]';

  INSERT INTO edw.fact_MaterialDocumentItem (
    MaterialID,
    t_applicationId
  )
  VALUES
    (1, 's4h-cap-100')
  , (2, 'test');

  -- Act
  SELECT *
  INTO actual
  FROM [edw].[vw_fact_MaterialDocumentItem_s4h]
  WHERE t_applicationId NOT LIKE '%s4h%'

  -- Assert:
  EXEC tSQLt.AssertEmptyTable 'actual';
END
