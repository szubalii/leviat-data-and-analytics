CREATE PROCEDURE [tc.edw.vw_LatestOutboundDeliveryItem].[test uniqueness]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;

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
  , (2, 2, 1, 2, '2020-01-10')

  -- Collect non-unique records
  SELECT
    [ReferenceSDDocument],
    [ReferenceSDDocumentItem]
  INTO actual
  FROM [edw].[vw_LatestOutboundDeliveryItem]
  GROUP BY
    [ReferenceSDDocument],
    [ReferenceSDDocumentItem]
  HAVING COUNT(*) > 1

  -- Assert:
  EXEC tSQLt.AssertEmptyTable 'actual';
END
