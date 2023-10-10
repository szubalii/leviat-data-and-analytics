CREATE PROCEDURE [tc.edw.vw_ScheduleLineShippedNotBilled].[test DeliveryStatus filter]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
  IF OBJECT_ID('tempdb..#vw_fact_ScheduleLineStatus') IS NOT NULL DROP TABLE #vw_fact_ScheduleLineStatus;
  -- IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;

  -- Assemble: Fake Table
  EXEC tSQLt.FakeTable '[edw]', '[vw_fact_ScheduleLineStatus]';

  SELECT TOP(0) *
  INTO #vw_fact_ScheduleLineStatus
  FROM edw.vw_fact_ScheduleLineStatus;
   
  INSERT INTO #vw_fact_ScheduleLineStatus (
    SLDeliveryStatus
  )
  VALUES
    ('P'),
    ('C'),
    ('A');

  EXEC ('INSERT INTO edw.vw_fact_ScheduleLineStatus SELECT * FROM #vw_fact_ScheduleLineStatus');

  -- Act: 
  SELECT SLDeliveryStatus
  INTO actual
  FROM [edw].[vw_ScheduleLineShippedNotBilled]
  WHERE SLDeliveryStatus NOT IN ('P', 'C');

  -- Assert:
  EXEC tSQLt.AssertEmptyTable 'actual';
END;
