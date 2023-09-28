-- test we have latest HDR_ActualGoodsMovementDate in dm_sales.vw_fact_ScheduleLineStatus
CREATE PROCEDURE [tc.edw.vw_LatestOutboundDeliveryItem].[test latest HDR_ActualGoodsMovementDate]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
  IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;

  -- Assemble: Fake Table
  EXEC tSQLt.FakeTable '[edw]', '[fact_OutboundDeliveryItem]';

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
  , (3, 1, 1, 2, '2020-01-11');

  -- Act
  SELECT
    [ReferenceSDDocument],
    [ReferenceSDDocumentItem],
    [LatestActualGoodsMovementDate]
  INTO actual
  FROM [edw].[vw_LatestOutboundDeliveryItem]
  GROUP BY
    [ReferenceSDDocument],
    [ReferenceSDDocumentItem],
    [LatestActualGoodsMovementDate]

  -- Assert:
  CREATE TABLE expected (
    ReferenceSDDocument INT,
    ReferenceSDDocumentItem INT,
    LatestActualGoodsMovementDate DATE
  );

  INSERT INTO expected(
    ReferenceSDDocument,
    ReferenceSDDocumentItem,
    LatestActualGoodsMovementDate
  )
  VALUES
    (1, 1, '2020-01-10'),
    (1, 2, '2020-01-11');

  EXEC tSQLt.AssertEqualsTable 'expected', 'actual';
END
