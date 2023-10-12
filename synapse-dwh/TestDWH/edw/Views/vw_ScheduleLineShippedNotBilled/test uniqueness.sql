
CREATE PROCEDURE [tc.edw.vw_ScheduleLineShippedNotBilled].[test uniqueness]
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
    nk_fact_SalesDocumentItem,
    SalesDocumentID,
    SalesDocumentItem,
    IsUnconfirmedDelivery,
    CurrencyTypeID,
    ScheduleLine,
    InScope
  )
  VALUES
    ('1¦1¦10', 1, 1, 'X', 10, 1, '1')
   ,('1¦1¦30', 1, 1, 'X', 30, 1, '1')
   ,('1¦1¦40', 1, 1, 'X', 40, 1, '1')
   ,('1¦1¦10', 1, 1, '', 10, 2, '1')
   ,('1¦1¦30', 1, 1, '', 30, 2, '1')
   ,('1¦1¦40', 1, 1, '', 40, 2, '1')
   ,('1¦2¦10', 1, 2, 'X', 10, 1, '1')
   ,('1¦2¦30', 1, 2, 'X', 30, 1, '1')
   ,('1¦2¦40', 1, 2, 'X', 40, 1, '1')
   ,('1¦2¦10', 1, 2, 'X', 10, 2, '1')
   ,('1¦2¦30', 1, 2, 'X', 30, 2, '1')
   ,('1¦2¦40', 1, 2, 'X', 40, 2, '1')
   ,('2¦1¦10', 2, 1, '', 10, 1, '1')
   ,('2¦1¦30', 2, 1, '', 30, 1, '1')
   ,('2¦1¦40', 2, 1, '', 40, 1, '1')
   ,('2¦1¦10', 2, 1, 'X', 10, 2, '1')
   ,('2¦1¦30', 2, 1, 'X', 30, 2, '1')
   ,('2¦1¦40', 2, 1, 'X', 40, 2, '1')
   ,('2¦2¦10', 2, 2, 'X', 10, 1, '1')
   ,('2¦2¦30', 2, 2, 'X', 30, 1, '1')
   ,('2¦2¦40', 2, 2, 'X', 40, 1, '1')
   ,('2¦2¦10', 2, 2, '', 10, 2, '1')
   ,('2¦2¦30', 2, 2, '', 30, 2, '1')
   ,('2¦2¦40', 2, 2, '', 40, 2, '1');

  EXEC ('INSERT INTO edw.vw_fact_ScheduleLineStatus SELECT * FROM #vw_fact_ScheduleLineStatus');  

  -- Act: 
  SELECT
    SalesDocumentID, 
    SalesDocumentItem,
    ScheduleLine,
    CurrencyTypeID
  INTO actual
  FROM [edw].[vw_ScheduleLineShippedNotBilled]
  GROUP BY
    SalesDocumentID, 
    SalesDocumentItem,
    ScheduleLine,
    CurrencyTypeID
  HAVING COUNT(*) > 1


  -- Assert:
  EXEC tSQLt.AssertEmptyTable 'actual';
END;
GO