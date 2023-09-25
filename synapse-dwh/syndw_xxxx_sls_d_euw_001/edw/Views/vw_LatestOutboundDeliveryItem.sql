CREATE VIEW [edw].[vw_LatestOutboundDeliveryItem]
AS
WITH
DeliveryItem_ordered AS (
    SELECT
        [ReferenceSDDocument]
        , [ReferenceSDDocumentItem]
        , [OutboundDelivery]                                    -- to improve
        , [OutboundDeliveryItem]                                -- trackability
        , [HDR_PlannedGoodsIssueDate]
        , [HDR_ActualGoodsMovementDate]
        , [HDR_ShippingPointID]
        , [HDR_HeaderBillingBlockReason]
        , [HDR_TotalBlockStatusID]
        , [HDR_ShipmentBlockReason]
        , [HDR_DeliveryBlockReason]
        , [CreatedByUserID]
        , ROW_NUMBER() OVER (
                PARTITION BY
                    [ReferenceSDDocument]
                    , [ReferenceSDDocumentItem]
                ORDER BY 
                    [HDR_ActualGoodsMovementDate]   DESC
                    ,[OutboundDelivery]             DESC        -- to stabilize the result
            )                                       AS rn       -- originally it was only MovementDate, so if we have two records in the same Date it's possible to get the different order each time
                                                                -- adding the part of NK helps get the stable result
    FROM [edw].[fact_OutboundDeliveryItem]
)
SELECT
    [ReferenceSDDocument]
    , [ReferenceSDDocumentItem]
    , [OutboundDelivery]
    , [OutboundDeliveryItem]
    , [LatestActualGoodsMovementDate]
    , [HDR_PlannedGoodsIssueDate]
    , [HDR_ShippingPointID]
    , [HDR_HeaderBillingBlockReason]
    , [HDR_TotalBlockStatusID]
    , [HDR_ShipmentBlockReason]
    , [HDR_DeliveryBlockReason]
    , [CreatedByUserID]
FROM
    DeliveryItem_ordered
WHERE
    rn = 1