-- test we have latest HDR_ActualGoodsMovementDate in dm_sales.vw_fact_ScheduleLineStatus
CREATE PROCEDURE [tc.edw.vw_Latest_HKUNNR].[test latest HKUNNR]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
  IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;

  -- Assemble: Fake Table
  EXEC tSQLt.FakeTable '[base_s4h_cax]', '[KNVH]';

  INSERT INTO base_s4h_cax.KNVH (
        HKUNNR,
        KUNNR,
        VKORG,
        VTWEG,
        SPART,
        DATAB
  )
  VALUES
    (1, 1, 1, 10, 01, '2022-10-01')
  , (2, 1, 1, 10, 01, '2023-01-17')
  , (3, 1, 1, 10, 01, '2020-01-01')
  , (4, 2, 1, 10, 01, '2020-01-10')
  , (5, 3, 2, 10, 01, '2023-07-11')
  , (6, 3, 2, 10, 01, '2022-05-11');

  -- Act
  SELECT
       HKUNNR,
       KUNNR,
       VKORG,
       VTWEG,
       SPART,
       DATAB
  INTO actual
  FROM [edw].[vw_Latest_HKUNNR]

  -- Assert:
  CREATE TABLE expected (
    [HKUNNR]          nvarchar(10),
    [KUNNR]           nvarchar(10)  NOT NULL,
    [VKORG]           nvarchar(4)   NOT NULL,
    [VTWEG]           nvarchar(2)   NOT NULL,
    [SPART]           nvarchar(2)   NOT NULL,
    [DATAB]           date          NOT NULL
  );

  INSERT INTO expected(
     [HKUNNR]
    ,[KUNNR]
    ,[VKORG]
    ,[VTWEG]
    ,[SPART]
    ,[DATAB]
  )
  VALUES
    (2, 1, 1, 10, 01, '2023-01-17'),
    (4, 2, 1, 10, 01, '2020-01-10'),
    (5, 3, 2, 10, 01, '2023-07-11');


  EXEC tSQLt.AssertEqualsTable 'expected', 'actual';
END
