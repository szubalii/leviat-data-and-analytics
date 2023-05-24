CREATE VIEW [dm_sales].[vw_dim_ScheduleLineStatus]
AS
WITH DeliveryItem AS (
    SELECT
        SUM([ActualDeliveredQtyInBaseUnit])     AS [ActualDeliveredQtyInBaseUnit]
        ,[ReferenceSDDocument]
        ,[ReferenceSDDocumentItem] 
    FROM [edw].[fact_OutboundDeliveryItem]
    WHERE [HDR_DeliveryDate] <= GETDATE()
    GROUP BY [ReferenceSDDocument]
        ,[ReferenceSDDocumentItem]
)
,   SDSL AS (
    SELECT
        SDSL.[SalesDocumentID]     
        ,SDSL.[SalesDocumentItem]
        ,SDSL.[ScheduleLine]
        ,SDSL.[RequestedDeliveryDate]
        ,SDSL.[ConfirmedDeliveryDate]
        ,SDSL.[ScheduleLineOrderQuantity]               AS ConfirmedQty
        ,SUM(SDSL.[ScheduleLineOrderQuantity])
            OVER (
                PARTITION BY SDSL.[SalesDocumentID]     
                    ,SDSL.[SalesDocumentItem]
            )                                           AS TotalOrderQty    --switched to SDI.OrderQuantity
        ,COALESCE(DeliveryItem.[ActualDeliveredQtyInBaseUnit], 0)
                                                        AS TotalDelivered
        ,SUM(SDSL.[ScheduleLineOrderQuantity])
            OVER (
                PARTITION BY SDSL.[SalesDocumentID]     
                    ,SDSL.[SalesDocumentItem]
                ORDER BY SDSL.[ConfirmedDeliveryDate]
                    ,SDSL.[ScheduleLine]
            )                                           AS SDSLOrderQtyRunningSum
    FROM [edw].[dim_SalesDocumentScheduleLine]         SDSL
    LEFT JOIN DeliveryItem
        ON SDSL.[SalesDocumentID] = DeliveryItem.[ReferenceSDDocument]
        AND SDSL.[SalesDocumentItem] = DeliveryItem.[ReferenceSDDocumentItem]
)
, SDI AS (
    SELECT
        SDILocal.[SalesDocument]
        ,SDILocal.[SalesDocumentItem]
        ,SDILocal.CurrencyID
        ,SDILocal.OrderQuantity
        ,SDILocal.[OrderType]
        ,SDILocal.[ItemOrderStatus]
        ,SDILocal.[OrderStatus]
        ,SDILocal.[NetAmount]                       AS LocalNetAmount
        ,SDIEUR.[NetAmount]                         AS EURNetAmount
        ,SDIUSD.[NetAmount]                         AS USDNetAmount
    FROM [edw].[fact_SalesDocumentItem] SDILocal
    JOIN [edw].[fact_SalesDocumentItem] SDIEUR
        ON SDILocal.SalesDocument = SDIEUR.SalesDocument
        AND SDILocal.SalesDocumentItem = SDIEUR.SalesDocumentItem
        AND SDIEUR.CurrencyTypeID = '30'
    JOIN [edw].[fact_SalesDocumentItem] SDIUSD
        ON SDILocal.SalesDocument = SDIUSD.SalesDocument
        AND SDILocal.SalesDocumentItem = SDIUSD.SalesDocumentItem
        AND SDIUSD.CurrencyTypeID = '40'
    WHERE SDILocal.CurrencyTypeID='10'
)
SELECT
    SDSL.[SalesDocumentID]     
    ,SDSL.[SalesDocumentItem]
    ,SDSL.[ScheduleLine]
    ,SDSL.[RequestedDeliveryDate]
    ,SDSL.[ConfirmedDeliveryDate]
    ,SDSL.[ConfirmedQty]
    ,SDI.[OrderQuantity]            AS [TotalOrderQty]
    ,SDSL.[TotalDelivered]
    ,SDSL.[SDSLOrderQtyRunningSum]
    ,CASE
        WHEN SDSL.SDSLOrderQtyRunningSum <= SDSL.TotalDelivered
        THEN 'Closed'
        ELSE 'Open'
    END                             AS SchLineStatus
    ,SDI.[OrderType]
    ,SDI.[ItemOrderStatus]
    ,SDI.[OrderStatus]
    ,SDSL.[ConfirmedQty] / SDSL.[TotalOrderQty] * SDI.[LocalNetAmount]
                                    AS ValueConfirmedQuantityLocal
    ,SDSL.[ConfirmedQty] / SDSL.[TotalOrderQty] * SDI.[EURNetAmount]
                                    AS ValueConfirmedQuantityEUR
    ,SDSL.[ConfirmedQty] / SDSL.[TotalOrderQty] * SDI.[USDNetAmount]
                                    AS ValueConfirmedQuantityUSD   
    ,SDI.CurrencyID
FROM SDSL
LEFT JOIN SDI
    ON SDSL.[SalesDocumentID] = SDI.[SalesDocument]
    AND SDSL.[SalesDocumentItem] = SDI.[SalesDocumentItem]