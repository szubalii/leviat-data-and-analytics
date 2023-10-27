CREATE PROCEDURE [tc.edw.svf_getOT_Group].[test filters]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
  IF OBJECT_ID('testdata') IS NOT NULL DROP TABLE testdata;
  IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;

  -- Assemble:
  CREATE TABLE testdata (
    OT_DaysDiff INT,
    OT_GroupValue NVARCHAR(6)
  );
  INSERT INTO testdata (OT_DaysDiff)
  VALUES (NULL),(0),(1),(-1);

  -- Act:
  SELECT
    OT_DaysDiff,
    [edw].[svf_getOT_Group](OT_DaysDiff) AS OT_GroupValue
  INTO actual
  FROM testdata;

  -- Assert:
  CREATE TABLE expected (
    OT_DaysDiff INT,
    OT_GroupValue NVARCHAR(6)
  );
  INSERT INTO expected (OT_DaysDiff,OT_GroupValue)
  VALUES (NULL,NULL),(0,'OnTime'),(1,'Late'),(-1,'Early');

  EXEC tSQLt.AssertEqualsTable 'expected', 'actual';
END;
