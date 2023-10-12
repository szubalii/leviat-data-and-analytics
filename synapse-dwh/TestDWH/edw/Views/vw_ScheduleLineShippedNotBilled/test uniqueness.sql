
CREATE PROCEDURE [tc.edw.vw_ScheduleLineShippedNotBilled].[test uniqueness]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
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
    (1, 1, 1, 10),
    (1, 1, 1, 20),
    (1, 1, 1, 30),
    (1, 1, 2, 10),
    (1, 1, 2, 20),
    (1, 1, 2, 30),
    (1, 2, 1, 10),
    (1, 2, 1, 20),
    (1, 2, 1, 30),
    (1, 2, 2, 10),
    (1, 2, 2, 20),
    (1, 2, 2, 30),
    (2, 1, 1, 10),
    (2, 1, 1, 20),
    (2, 1, 1, 30),
    (2, 1, 2, 10),
    (2, 1, 2, 20),
    (2, 1, 2, 30),
    (2, 2, 1, 10),
    (2, 2, 1, 20),
    (2, 2, 1, 30),
    (2, 2, 2, 10),
    (2, 2, 2, 20),
    (2, 2, 2, 30);

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