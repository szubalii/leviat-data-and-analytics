CREATE VIEW [dm_sales].[vw_fact_ScheduleLineStatus]
AS
WITH DeliveryItem AS 
( 
	SELECT 
		SUM([ActualDeliveredQtyInBaseUnit]) AS [ActualDeliveredQtyInBaseUnit],
		SUM([ActualDeliveryQuantity]) AS [ActualDeliveredQtySalesUnit], /*use Qty in SO UoM*/
		[ReferenceSDDocument],
		[ReferenceSDDocumentItem]
	FROM [edw].[fact_OutboundDeliveryItem] 
	--WHERE [HDR_DeliveryDate] <= GETDATE() 
    /*In case delivery issued earlier then scheduled delivery date (for example, SO 20058260/040) */
    WHERE [HDR_ActualGoodsMovementDate] <= GETDATE()
	GROUP BY [ReferenceSDDocument],
		[ReferenceSDDocumentItem]
)	
,SDSL AS ( 
	SELECT
		SDSL.[SalesDocumentID],
		SDSL.[SalesDocumentItem],
		SDSL.[ScheduleLine],
		SDSL.[RequestedDeliveryDate],
		SDSL.[ConfirmedDeliveryDate],
		--SDSL.[ScheduleLineOrderQuantity] AS ConfirmedQty,
		/* for confirmed SL ScheduleLineOrderQuantity usually = 0, should we use ConfdOrderQtyByMatlAvailCheck instead */
		SDSL.[ConfdOrderQtyByMatlAvailCheck] 		AS ConfirmedQty,
		SUM(SDSL.[ScheduleLineOrderQuantity]) 
			OVER (
				PARTITION BY 
					SDSL.[SalesDocumentID],
					SDSL.[SalesDocumentItem] 
			) 										AS TotalOrderQty,
		--switched to SDI.OrderQuantity 
		--COALESCE(DeliveryItem.[ActualDeliveredQtyInBaseUnit], 0) AS TotalDelivered,
		/*use Qty in SO UoM*/
		COALESCE(DeliveryItem.[ActualDeliveredQtySalesUnit], 0) AS TotalDelivered,
		--SUM(SDSL.[ScheduleLineOrderQuantity]) OVER ( PARTITION BY SDSL.[SalesDocumentID] ,SDSL.[SalesDocumentItem] ORDER BY SDSL.[ConfirmedDeliveryDate],
		--SDSL.[ScheduleLine] ) AS SDSLOrderQtyRunningSum
		/* for confirmed SL ScheduleLineOrderQuantity usually = 0, should we use ConfdOrderQtyByMatlAvailCheck instead */
		SUM(SDSL.[ConfdOrderQtyByMatlAvailCheck]) 
			OVER (
				PARTITION BY 
					SDSL.[SalesDocumentID] 
					,SDSL.[SalesDocumentItem] 
				ORDER BY 
					SDSL.[ConfirmedDeliveryDate],
					SDSL.[ScheduleLine] ) AS SDSLOrderQtyRunningSum,
        SDSL.ScheduleLineCategory
	FROM [edw].[dim_SalesDocumentScheduleLine] SDSL 
	LEFT JOIN DeliveryItem 
        ON SDSL.[SalesDocumentID] = DeliveryItem.[ReferenceSDDocument] 
	        AND SDSL.[SalesDocumentItem] = DeliveryItem.[ReferenceSDDocumentItem]
)	
,SDI AS ( 
	SELECT 
        SDILocal.[SalesDocument],
        SDILocal.[SDDocumentRejectionStatusID],
        SDILocal.[SalesDocumentItem],
        SDILocal.[SalesDocumentTypeID],
        SDILocal.CreationDate,
        SDILocal.CurrencyID,
        SDILocal.OrderQuantity,
        SDILocal.[OrderType],
        SDILocal.[ItemOrderStatus],
        SDILocal.[OrderStatus],
        SDILocal.[NetAmount] AS LocalNetAmount,
        SDIEUR.[NetAmount] AS EURNetAmount,
        SDIUSD.[NetAmount] AS USDNetAmount,
        SDILocal.[ShippingConditionID],
        SDILocal.[NetAmount]/SDILocal.[OrderQuantity]   AS PricePerUnit,
        SDIEUR.[NetAmount]/SDIEUR.[OrderQuantity] AS PricePerUnitEUR
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
        AND SDILocal.[OrderQuantity] <> 0
        AND SDIEUR.[OrderQuantity] <> 0
)
,documentItems AS (
    SELECT MAX(BillingQuantityInBaseUnit)           AS [BillingQuantityInBaseUnit] 
        , MAX(BillingQuantity)                      AS [BillingQuantity] 
        , ReferenceSDDocument
        , ReferenceSDDocumentItem
    FROM (
        SELECT SUM(BillingQuantityInBaseUnit)   AS [BillingQuantityInBaseUnit] 
            ,SUM(BillingQuantity)               AS [BillingQuantity] 
            ,[SalesDocumentID]                  AS [ReferenceSDDocument]          
            ,[SalesDocumentItemID]              AS [ReferenceSDDocumentItem]      
        FROM [edw].[vw_BillingDocumentItem_for_SalesDocumentItem]
        WHERE SDDocumentCategoryID not in ('5','6')
        GROUP BY [SalesDocumentID], [SalesDocumentItemID], [CurrencyID], [CurrencyTypeID]
    ) a
    GROUP BY [ReferenceSDDocument], [ReferenceSDDocumentItem]
)
, pre_report AS (
SELECT 
        SDSL.[SalesDocumentID],
        SDI.[SalesDocumentTypeID],
        SDI.[SDDocumentRejectionStatusID],
        SDI.[CreationDate],
        SDSL.[SalesDocumentItem],
        SDSL.[ScheduleLine],
        SDSL.[RequestedDeliveryDate],
        SDSL.[ConfirmedDeliveryDate],
        SDSL.[ConfirmedQty],
        SDI.[OrderQuantity]                     AS [TotalOrderQty],
        SDSL.[TotalDelivered],
        SDSL.[SDSLOrderQtyRunningSum],
        SDI.[OrderType]                         AS [SalesDocumentOrderType],
        SDI.[ItemOrderStatus],
        SDI.[OrderStatus],
        SDSL.[ConfirmedQty] / SDSL.[TotalOrderQty] * SDI.[LocalNetAmount]
                                                AS ValueConfirmedQuantityLocal,
        SDSL.[ConfirmedQty] / SDSL.[TotalOrderQty] * SDI.[EURNetAmount]
                                                AS ValueConfirmedQuantityEUR,
        SDSL.[ConfirmedQty] / SDSL.[TotalOrderQty] * SDI.[USDNetAmount]
                                                AS ValueConfirmedQuantityUSD,
        SDI.CurrencyID,
        documentItems.[BillingQuantity],
        SDI.ShippingConditionID,
        SDSL.ScheduleLineCategory,
        SDI.[LocalNetAmount],
        SDI.[EURNetAmount],
        CASE
            WHEN SDSL.[TotalDelivered] <= SDSL.[SDSLOrderQtyRunningSum] - SDSL.[ConfirmedQty]
                THEN 'A'
            WHEN SDSL.[TotalDelivered] < SDSL.[SDSLOrderQtyRunningSum]
                THEN 'B'
            WHEN SDSL.[TotalDelivered] >= SDSL.[SDSLOrderQtyRunningSum]
                THEN 'C'
        END                                     AS DeliveryStatus,
        CASE
            WHEN COALESCE(documentItems.[BillingQuantity],0) <= SDSL.[SDSLOrderQtyRunningSum] - SDSL.[ConfirmedQty]
                THEN 'N'
            WHEN documentItems.[BillingQuantity] < SDSL.[SDSLOrderQtyRunningSum]
                THEN 'P'
            WHEN documentItems.[BillingQuantity] >= SDSL.[SDSLOrderQtyRunningSum]
                THEN 'F'
        END                                     AS InvoicedStatus,
        SDI.OrderType,
        CASE
            WHEN SDSL.[TotalDelivered] < SDSL.[SDSLOrderQtyRunningSum] - SDSL.[ConfirmedQty]
                THEN SDSL.[ConfirmedQty] * SDI.[PricePerUnit]
            WHEN SDSL.[TotalDelivered] < SDSL.[SDSLOrderQtyRunningSum]
                THEN (SDSL.[SDSLOrderQtyRunningSum] - SDSL.[TotalDelivered]) * SDI.[PricePerUnit]
            WHEN SDSL.[TotalDelivered] >= SDSL.[SDSLOrderQtyRunningSum]
                THEN 0
        END                                     AS OpenDeliveryValue,
        CASE
            WHEN SDSL.[TotalDelivered] < SDSL.[SDSLOrderQtyRunningSum] - SDSL.[ConfirmedQty]
                THEN 0
            WHEN SDSL.[TotalDelivered] < SDSL.[SDSLOrderQtyRunningSum]
                THEN (SDSL.[TotalDelivered] - SDSL.[SDSLOrderQtyRunningSum] + SDSL.[ConfirmedQty]) * SDI.[PricePerUnit]
            WHEN SDSL.[TotalDelivered] >= SDSL.[SDSLOrderQtyRunningSum]
                THEN SDSL.[ConfirmedQty] * SDI.[PricePerUnit]
        END                                     AS ClosedDeliveryValue,
        CASE
            WHEN SDSL.[TotalDelivered] < SDSL.[SDSLOrderQtyRunningSum] - SDSL.[ConfirmedQty]
                THEN SDSL.[ConfirmedQty] * SDI.[PricePerUnitEUR]
            WHEN SDSL.[TotalDelivered] < SDSL.[SDSLOrderQtyRunningSum]
                THEN (SDSL.[SDSLOrderQtyRunningSum] - SDSL.[TotalDelivered]) * SDI.[PricePerUnitEUR]
            WHEN SDSL.[TotalDelivered] >= SDSL.[SDSLOrderQtyRunningSum]
                THEN 0
        END                                     AS OpenDeliveryValueEUR,
        CASE
            WHEN SDSL.[TotalDelivered] < SDSL.[SDSLOrderQtyRunningSum] - SDSL.[ConfirmedQty]
                THEN 0
            WHEN SDSL.[TotalDelivered] < SDSL.[SDSLOrderQtyRunningSum]
                THEN (SDSL.[TotalDelivered] - SDSL.[SDSLOrderQtyRunningSum] + SDSL.[ConfirmedQty]) * SDI.[PricePerUnitEUR]
            WHEN SDSL.[TotalDelivered] >= SDSL.[SDSLOrderQtyRunningSum]
                THEN SDSL.[ConfirmedQty] * SDI.[PricePerUnitEUR]
        END                                     AS ClosedDeliveryValueEUR,
        CASE
            WHEN documentItems.[BillingQuantity] < SDSL.[SDSLOrderQtyRunningSum] - SDSL.[ConfirmedQty]
                OR documentItems.[BillingQuantity] IS NULL
                THEN SDSL.[ConfirmedQty] * SDI.[PricePerUnit]
            WHEN documentItems.[BillingQuantity] < SDSL.[SDSLOrderQtyRunningSum]
                THEN (SDSL.[SDSLOrderQtyRunningSum] - documentItems.[BillingQuantity]) * SDI.[PricePerUnit]
            WHEN documentItems.[BillingQuantity] >= SDSL.[SDSLOrderQtyRunningSum]
                THEN 0
        END                                     AS OpenInvoicedValue,
        CASE
            WHEN documentItems.[BillingQuantity] < SDSL.[SDSLOrderQtyRunningSum] - SDSL.[ConfirmedQty]
                OR documentItems.[BillingQuantity] IS NULL
                THEN 0
            WHEN documentItems.[BillingQuantity] < SDSL.[SDSLOrderQtyRunningSum]
                THEN (documentItems.[BillingQuantity] - SDSL.[SDSLOrderQtyRunningSum] + SDSL.[ConfirmedQty]) * SDI.[PricePerUnit]
            WHEN documentItems.[BillingQuantity] >= SDSL.[SDSLOrderQtyRunningSum]
                THEN SDSL.[ConfirmedQty] * SDI.[PricePerUnit]
        END                                     AS ClosedInvoicedValue,
        CASE
            WHEN documentItems.[BillingQuantity] < SDSL.[SDSLOrderQtyRunningSum] - SDSL.[ConfirmedQty]
                OR documentItems.[BillingQuantity] IS NULL
                THEN SDSL.[ConfirmedQty] * SDI.[PricePerUnitEUR]
            WHEN documentItems.[BillingQuantity] < SDSL.[SDSLOrderQtyRunningSum]
                THEN (SDSL.[SDSLOrderQtyRunningSum] - documentItems.[BillingQuantity]) * SDI.[PricePerUnitEUR]
            WHEN documentItems.[BillingQuantity] >= SDSL.[SDSLOrderQtyRunningSum]
                THEN 0
        END                                     AS OpenInvoicedValueEUR,
        CASE
            WHEN documentItems.[BillingQuantity] < SDSL.[SDSLOrderQtyRunningSum] - SDSL.[ConfirmedQty]
                OR documentItems.[BillingQuantity] IS NULL
                THEN 0
            WHEN documentItems.[BillingQuantity] < SDSL.[SDSLOrderQtyRunningSum]
                THEN (documentItems.[BillingQuantity] - SDSL.[SDSLOrderQtyRunningSum] + SDSL.[ConfirmedQty]) * SDI.[PricePerUnitEUR]
            WHEN documentItems.[BillingQuantity] >= SDSL.[SDSLOrderQtyRunningSum]
                THEN SDSL.[ConfirmedQty] * SDI.[PricePerUnitEUR]
        END                                     AS ClosedInvoicedValueEUR,
        SDI.[PricePerUnit],
        SDI.[PricePerUnitEUR]
	FROM SDSL 
    LEFT JOIN SDI 
        ON SDSL.[SalesDocumentID] = SDI.[SalesDocument] 
        AND SDSL.[SalesDocumentItem] = SDI.[SalesDocumentItem]
    LEFT JOIN documentItems
        ON SDSL.[SalesDocumentID] = documentItems.[ReferenceSDDocument] 
        AND SDSL.[SalesDocumentItem] = documentItems.[ReferenceSDDocumentItem]
)
SELECT
        pre_report.[SalesDocumentTypeID],
        pre_report.[SDDocumentRejectionStatusID], 
        pre_report.[SalesDocumentID],      
        pre_report.[SalesDocumentItem],
        pre_report.[ScheduleLine],
        pre_report.[SalesDocumentOrderType],
        pre_report.[OrderStatus],
        pre_report.[ItemOrderStatus],
        pre_report.[OrderType],
        pre_report.[DeliveryStatus]         AS [SLDeliveryStatus],
        pre_report.[InvoicedStatus]         AS [SLInvoicedStatus],
        statuses.[Status]                   AS [SLStatus],
        pre_report.[CreationDate],
        pre_report.[RequestedDeliveryDate],
        pre_report.[ConfirmedDeliveryDate],
        pre_report.[ConfirmedQty],
        pre_report.[TotalOrderQty],
        pre_report.[TotalDelivered],
        pre_report.[SDSLOrderQtyRunningSum],
        pre_report.[ValueConfirmedQuantityLocal],
        pre_report.[ValueConfirmedQuantityEUR],
        pre_report.[ValueConfirmedQuantityUSD],
        pre_report.[CurrencyID],
        pre_report.[BillingQuantity],
        pre_report.[ShippingConditionID],
        pre_report.[ScheduleLineCategory],
        pre_report.[LocalNetAmount],
        pre_report.[OpenDeliveryValue],
        pre_report.[ClosedDeliveryValue],
        pre_report.[OpenInvoicedValue],
        pre_report.[ClosedInvoicedValue],
        pre_report.[OpenDeliveryValueEUR],
        pre_report.[ClosedDeliveryValueEUR],
        pre_report.[OpenInvoicedValueEUR],
        pre_report.[ClosedInvoicedValueEUR],
        pre_report.[PricePerUnit],
        pre_report.[PricePerUnitEUR],
        CASE
            WHEN pre_report.[SalesDocumentTypeID] LIKE 'ZOR'
                THEN '1'
            ELSE '0'
        END                                 AS InScope
FROM pre_report
LEFT JOIN [base_ff].[SalesDocumentStatuses] statuses
    ON  pre_report.OrderType = statuses.OrderTypeText
        AND pre_report.[DeliveryStatus] = COALESCE (statuses.DeliveryStatus, pre_report.[DeliveryStatus])
        AND pre_report.[InvoicedStatus]= statuses.InvoiceStatus