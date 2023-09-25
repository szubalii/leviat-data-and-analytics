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
            )                                       AS rn
    FROM [edw].[fact_OutboundDeliveryItem]
)
SELECT
    [ReferenceSDDocument]
    , [ReferenceSDDocumentItem]
    , [OutboundDelivery]
    , [OutboundDeliveryItem]
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