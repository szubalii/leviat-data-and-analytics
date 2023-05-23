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
            )                                           AS TotalOrderQty
        ,COALESCE(DeliveryItem.[ActualDeliveredQtyInBaseUnit], 0)
                                                        AS TotalDelivered
        ,SUM(SDSL.[ScheduleLineOrderQuantity])
            OVER (
                PARTITION BY SDSL.[SalesDocumentID]     
                    ,SDSL.[SalesDocumentItem]
                ORDER BY SDSL.[ConfirmedDeliveryDate]
                    ,SDSL.[ScheduleLine]
            )                                           AS RunningSumDelivered
    FROM [edw].[dim_SalesDocumentScheduleLine]         SDSL
    LEFT JOIN DeliveryItem
        ON SDSL.[SalesDocumentID] = DeliveryItem.[ReferenceSDDocument]
        AND SDSL.[SalesDocumentItem] = DeliveryItem.[ReferenceSDDocumentItem]
)
, SDI AS (
    SELECT
        SDI.[SalesDocument]
        ,SDI.[SalesDocumentItem]
        ,SDI.CurrencyID
        ,SDI.[CostAmount]                       AS LocalCostAmount
        ,SDI.[CostAmount]*rate_eur.ExchangeRate AS EURCostAmount
        ,SDI.[CostAmount]*rate_usd.ExchangeRate AS USDCostAmount
    FROM [edw].[fact_SalesDocumentItem] SDI
    JOIN [edw].[vw_CurrencyConversionRate] rate_eur
        ON SDI.CurrencyID = rate_eur.SourceCurrency COLLATE DATABASE_DEFAULT
        AND SDI.CreationDate BETWEEN rate_eur.ExchangeRateEffectiveDate and rate_eur.LastDay
        AND rate_eur.TargetCurrency = 'EUR'
        AND rate_eur.CurrencyTypeID=30
    JOIN [edw].[vw_CurrencyConversionRate] rate_usd
        ON SDI.CurrencyID = rate_usd.SourceCurrency COLLATE DATABASE_DEFAULT
        AND SDI.CreationDate BETWEEN rate_usd.ExchangeRateEffectiveDate and rate_usd.LastDay
        AND rate_usd.TargetCurrency = 'USD'
    WHERE SDI.CurrencyTypeID='00'
)
SELECT
    SDSL.[SalesDocumentID]     
    ,SDSL.[SalesDocumentItem]
    ,SDSL.[ScheduleLine]
    ,SDSL.[RequestedDeliveryDate]
    ,SDSL.[ConfirmedDeliveryDate]
    ,SDSL.[ConfirmedQty]
    ,SDSL.[TotalOrderQty]
    ,SDSL.[TotalDelivered]
    ,SDSL.[RunningSumDelivered]
    ,CASE
        WHEN SDSL.RunningSumDelivered <= SDSL.TotalDelivered
        THEN 'Closed'
        ELSE 'Open'
    END                             AS SchLineStatus
    ,SDSL.[ConfirmedQty] / SDSL.[TotalOrderQty] * SDI.[LocalCostAmount]
                                    AS ValueConfirmedQuantityLocal
    ,SDSL.[ConfirmedQty] / SDSL.[TotalOrderQty] * SDI.[EURCostAmount]
                                    AS ValueConfirmedQuantityEUR
    ,SDSL.[ConfirmedQty] / SDSL.[TotalOrderQty] * SDI.[USDCostAmount]
                                    AS ValueConfirmedQuantityUSD   
    ,SDI.CurrencyID
FROM SDSL
LEFT JOIN SDI
    ON SDSL.[SalesDocumentID] = SDI.[SalesDocument]
    AND SDSL.[SalesDocumentItem] = SDI.[SalesDocumentItem]
