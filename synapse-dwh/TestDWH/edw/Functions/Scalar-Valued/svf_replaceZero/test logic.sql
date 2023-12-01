CREATE PROCEDURE [tc.edw.svf_replaceZero].[test logic]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
  IF OBJECT_ID('testdata') IS NOT NULL DROP TABLE testdata;
  IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;

  -- Assemble:
  CREATE TABLE testdata (
    VPRS    decimal
    ,EK02   decimal
  );
  INSERT INTO testdata (OT_DaysDiff)
  VALUES 
    (0, 1)
    ,(-1, 2)
    ,(3, 4);

  -- Act:
  SELECT
    VPRS,
    EK02,
    [edw].[svf_replaceZero](VPRS, EK02) AS [VPRS/EK02]
  INTO actual
  FROM testdata;

  -- Assert:
  CREATE TABLE expected (
    VPRS    decimal
    ,EK02   decimal
    ,[VPRS/EK02]  decimal
  );

  INSERT INTO expected (VPRS, EK02, [VPRS/EK02])
  VALUES 
    (0, 1, 1)
    ,(-1, 2, -1)
    ,(3, 4, 3);

  EXEC tSQLt.AssertEqualsTable 'expected', 'actual';
END;
