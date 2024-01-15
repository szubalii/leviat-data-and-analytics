CREATE PROCEDURE [tc.edw.svf_replaceZero].[test logic]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
  IF OBJECT_ID('testdata') IS NOT NULL DROP TABLE testdata;
  IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;

  -- Assemble:
  CREATE TABLE testdata (
     VPRS   DECIMAL(15,2)
    ,EK02   DECIMAL(15,2)
  );
  INSERT INTO testdata (VPRS, EK02)
  VALUES 
     ( 0, 1.0)
    ,(-1.0, 2)
    ,( 3, 4);

  -- Act:
  SELECT
    VPRS,
    EK02,
    [edw].[svf_replaceZero](VPRS, EK02) AS [VPRS/EK02]
  INTO actual
  FROM testdata;

  -- Assert:
  CREATE TABLE expected (
     VPRS        DECIMAL(15,2)
    ,EK02        DECIMAL(15,2)
    ,[VPRS/EK02] DECIMAL(15,2)
  );

  INSERT INTO expected (VPRS, EK02, [VPRS/EK02])
  VALUES 
     ( 0,   1.0, 1.0)
    ,(-1.0, 2,  -1.0)
    ,( 3,   4,   3);

  EXEC tSQLt.AssertEqualsTable 'expected', 'actual';
END;
