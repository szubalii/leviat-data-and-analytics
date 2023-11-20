CREATE PROCEDURE [tc.dm_sales.vw_fact_ScheduleLineStatus].[test with flag]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;

  -- Assemble: Fake Table
  EXEC tSQLt.FakeTable '[edw]', '[vw_fact_ScheduleLineStatus]';
   
  SELECT TOP(0) *
  INTO #vw_fact_ScheduleLineStatus
  FROM edw.vw_fact_ScheduleLineStatus;

  -- #2
  INSERT INTO #vw_fact_ScheduleLineStatus (
    sk_fact_SalesDocumentItem, 
    SalesDocumentID, 
    SalesDocumentItem,
    CurrencyTypeID,
    ScheduleLine,
    IsScheduleLineBlockedFlag,
    IsOrderItemBlockedFlag
    )
  VALUES
    (1, 1, 1, 10, 1, 1, 1), 
    (2, 1, 1, 30, 1, 1, 1), 
    (3, 1, 1, 40, 1, 1, 1);

  EXEC ('INSERT INTO edw.vw_fact_ScheduleLineStatus SELECT * FROM #vw_fact_ScheduleLineStatus');

  -- Act: 
  SELECT *
  INTO actual
  FROM [dm_sales].[vw_fact_ScheduleLineStatus]
  WHERE IsBlockedFlag <> 1;

  -- Assert:
  EXEC tSQLt.AssertEmptyTable 'actual';
END;
