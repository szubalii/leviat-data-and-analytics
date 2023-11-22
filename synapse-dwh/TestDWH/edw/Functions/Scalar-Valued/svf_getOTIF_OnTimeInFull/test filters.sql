CREATE PROCEDURE [tc.edw.svf_getOTIF_OnTimeInFull].[test filters]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
  IF OBJECT_ID('testdata') IS NOT NULL DROP TABLE testdata;
  IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;

  -- Assemble:
  CREATE TABLE testdata (
    OT_Group NVARCHAR(6),
    OT_IsOnTime BIT,
    IF_IsInFull BIT
  );

  INSERT INTO testdata (OT_Group,OT_IsOnTime,IF_IsInFull)
  VALUES (NULL,1,1),(NULL,0,0),('OnTime',1,1),('Late',1,0),('Early',0,1),('Early',0,0);

  -- Act:
  SELECT
    [OT_Group],
    [OT_IsOnTime],
    [IF_IsInFull],
    [edw].[svf_getOTIF_OnTimeInFull](OT_Group,OT_IsOnTime,IF_IsInFull) AS OTIF_OnTimeInFull
  INTO actual
  FROM testdata;

  -- Assert:
  CREATE TABLE expected (
    OT_Group NVARCHAR(6),
    OT_IsOnTime BIT,
    IF_IsInFull BIT,
    OTIF_OnTimeInFull NVARCHAR(6)
  );
  INSERT INTO expected (OT_Group,OT_IsOnTime,IF_IsInFull,OTIF_OnTimeInFull)
  VALUES (NULL,1,1,NULL),(NULL,0,0,NULL),('OnTime',1,1,'OTIF'),
  ('Late',1,0,'OTNIF'),('Early',0,1,'NOTIF'),('Early',0,0,'NOTNIF');

  EXEC tSQLt.AssertEqualsTable 'expected', 'actual';
END;