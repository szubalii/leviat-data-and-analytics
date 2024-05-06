-- test we have latest HDR_ActualGoodsMovementDate in dm_sales.vw_fact_ScheduleLineStatus
CREATE PROCEDURE [tc.edw.vw_LatestGlobalParent].[test latest GlobalParentID]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
  IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;

  -- Assemble: Fake Table
  EXEC tSQLt.FakeTable '[base_s4h_cax]', '[KNVH]';

  INSERT INTO base_s4h_cax.KNVH (
        KUNNR,
        VKORG,
        VTWEG,
        SPART,
        DATAB,
        HKUNNR
  )
  VALUES
    (1, 1, 10, 01, '2022-10-01', 1)
  , (1, 1, 10, 01, '2023-01-17', 2)
  , (1, 1, 10, 01, '2020-01-01', 3)
  , (2, 1, 10, 01, '2020-01-10', 4)
  , (3, 2, 10, 01, '2023-07-11', 5)
  , (3, 2, 10, 01, '2022-05-11', 6);

  -- Act
  SELECT
       CustomerID,
       SalesOrganizationID,
       DistributionChannel,
       Division,
       ValidityStartDate,
       GlobalParentID
  INTO actual
  FROM [edw].[vw_LatestGlobalParent]

  -- Assert:
  CREATE TABLE expected (
    [CustomerID]              nvarchar(10)  NOT NULL,
    [SalesOrganizationID]     nvarchar(4)   NOT NULL,
    [DistributionChannel]     nvarchar(2)   NOT NULL,
    [Division]                nvarchar(2)   NOT NULL,
    [ValidityStartDate]       date          NOT NULL,
    [GlobalParentID]          nvarchar(10)
  );

  INSERT INTO expected(
     [CustomerID]
    ,[SalesOrganizationID]
    ,[DistributionChannel]
    ,[Division]
    ,[ValidityStartDate]
    ,[GlobalParentID]
  )
  VALUES
    (1, 1, 10, 01, '2023-01-17', 2),
    (2, 1, 10, 01, '2020-01-10', 4),
    (3, 2, 10, 01, '2023-07-11', 5);


  EXEC tSQLt.AssertEqualsTable 'expected', 'actual';
END
