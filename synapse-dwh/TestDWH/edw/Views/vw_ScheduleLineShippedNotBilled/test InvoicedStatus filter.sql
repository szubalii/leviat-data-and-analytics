CREATE PROCEDURE [tc.edw.vw_ScheduleLineShippedNotBilled].[test InvoicedStatus filter]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
  IF OBJECT_ID('tempdb..#vw_fact_ScheduleLineStatus') IS NOT NULL DROP TABLE #vw_fact_ScheduleLineStatus;
  -- IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;

  -- Assemble: Fake Table
  EXEC tSQLt.FakeTable '[edw]', '[vw_fact_ScheduleLineStatus]';
   
  INSERT INTO #vw_fact_ScheduleLineStatus (
    SLInvoicedStatus
  )
  VALUES
    ('P'),
    ('N'),
    ('F');

  EXEC ('INSERT INTO edw.vw_fact_ScheduleLineStatus SELECT * FROM #vw_fact_ScheduleLineStatus');

  -- Act: 
  SELECT SLInvoicedStatus
  INTO actual
  FROM [edw].[vw_ScheduleLineShippedNotBilled]
  WHERE SLInvoicedStatus NOT IN ('P', 'N');

  -- Assert:
  EXEC tSQLt.AssertEmptyTable 'actual';
END;
