
CREATE PROCEDURE [tc.edw.vw_ScheduleLineShippedNotBilled].[test uniqueness]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
  IF OBJECT_ID('tempdb..#vw_entity_file') IS NOT NULL DROP TABLE #vw_entity_file;
  -- IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;

  -- Assemble: Fake Table
  EXEC tSQLt.FakeTable '[edw]', '[fact_OutboundDeliveryItem]';
  EXEC tSQLt.FakeTable '[edw]', '[vw_fact_ScheduleLineStatus]';

  
   INSERT INTO edw.fact_OutboundDeliveryItem (
    OutboundDelivery,
    OutboundDeliveryItem,
    ReferenceSDDocument,
    ReferenceSDDocumentItem,
    HDR_ActualGoodsMovementDate
  )
  VALUES
    (1, 1, 1, 1, '2020-01-01')
  , (1, 2, 1, 2, '2020-01-01')
  , (1, 3, 1, 2, '2020-01-01')
  , (2, 1, 1, 1, '2020-01-10')
  , (2, 2, 1, 2, '2020-01-10');

  
  INSERT INTO edw.vw_fact_ScheduleLineStatus (
    SalesDocumentID, 
    SalesDocumentItem,
    ScheduleLine,
    CurrencyTypeID
  )
  VALUES 
   (1, 1, 1, 1), 
   (1, 1, 2, 1),
   (1, 2, 1, 1),
   (1, 2, 2, 1);

 
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