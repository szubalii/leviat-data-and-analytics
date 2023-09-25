
CREATE PROCEDURE [OutboundDelivery].[test edw.vw_LatestOutboundDeliveryItem uniqueness]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
  -- IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;

  -- Collect non-unique records
  SELECT
    [ReferenceSDDocument]
    , [ReferenceSDDocumentItem]
  INTO actual
  FROM [edw].[vw_LatestOutboundDeliveryItem]
  GROUP BY
    [ReferenceSDDocument]
    , [ReferenceSDDocumentItem]
  HAVING COUNT(*) > 1

  -- Assert:
  EXEC tSQLt.AssertEmptyTable 'actual';
END;
GO

-- test we have latest HDR_ActualGoodsMovementDate in dm_sales.vw_fact_ScheduleLineStatus
CREATE PROCEDURE [OutboundDelivery].[test latest HDR_ActualGoodsMovementDate in vw_fact_ScheduleLineStatus]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
  -- IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;

  -- Collect non-unique records
  SELECT
    [nk_fact_SalesDocumentItem]
  INTO actual
  FROM 
    [dm_sales].[vw_fact_ScheduleLineStatus] SLS
  LEFT JOIN 
    [edw].[fact_OutboundDeliveryItem]       ODI
    ON SLS.SalesDocumentID = ODI.ReferenceSDDocument
        AND SLS.SalesDocumentItem = ODI.ReferenceSDDocumentItem
  WHERE
    ODI.[HDR_ActualGoodsMovementDate] <= GETDATE()
    AND SLS.[SDI_ODB_LatestActualGoodsMovmtDate] < ODI.[HDR_ActualGoodsMovementDate];

  -- Assert:
  EXEC tSQLt.AssertEmptyTable 'actual';
END;
GO