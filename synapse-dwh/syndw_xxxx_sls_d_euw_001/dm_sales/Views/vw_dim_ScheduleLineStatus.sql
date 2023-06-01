CREATE VIEW [dm_sales].[vw_dim_ScheduleLineStatus]
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
        SDIUSD.[NetAmount] AS USDNetAmount 
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
,documentItems AS (
    SELECT MAX(BillingQuantityInBaseUnit)           AS [BillingQuantityInBaseUnit] 
        , ReferenceSDDocument
        , ReferenceSDDocumentItem
    FROM (
        SELECT SUM(BillingQuantityInBaseUnit) AS [BillingQuantityInBaseUnit] 
            ,[SalesDocumentID]                  AS [ReferenceSDDocument]          
            ,[SalesDocumentItemID]              AS [ReferenceSDDocumentItem]      
        FROM [edw].[vw_BillingDocumentItem_for_SalesDocumentItem]
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
        documentItems.[BillingQuantityInBaseUnit],
        SDI.ShippingConditionID,
        SDSL.ScheduleLineCategory,
        SDI.[LocalNetAmount],
        CASE
            WHEN SDSL.[TotalDelivered] < SDSL.[SDSLOrderQtyRunningSum] - SDSL.[ConfirmedQty]
                THEN 'A'
            WHEN SDSL.[TotalDelivered] < SDSL.[SDSLOrderQtyRunningSum]
                THEN 'B'
            WHEN SDSL.[TotalDelivered] >= SDSL.[SDSLOrderQtyRunningSum]
                THEN 'C'
        END                                     AS DeliveryStatus,
        CASE
            WHEN documentItems.[BillingQuantityInBaseUnit] < SDSL.[SDSLOrderQtyRunningSum] - SDSL.[ConfirmedQty]
                THEN 'N'
            WHEN documentItems.[BillingQuantityInBaseUnit] < SDSL.[SDSLOrderQtyRunningSum]
                THEN 'P'
            WHEN documentItems.[BillingQuantityInBaseUnit] >= SDSL.[SDSLOrderQtyRunningSum]
                THEN 'F'
        END                                     AS InvoicedStatus,
        CASE
            WHEN SDSL.ScheduleLineCategory = 'ZS'
                THEN 'Drop Shipment'
            WHEN SDI.ShippingConditionID = 70
                THEN 'Collection'
            WHEN SDI.ShippingConditionID <> 70
                THEN 'Delivery'
            ELSE      'Unknown'
        END                                     AS OrderType,
        CASE
            WHEN SDSL.ScheduleLineCategory = 'ZS'
                THEN 2
            WHEN SDI.ShippingConditionID = 70
                THEN 1
            WHEN SDI.ShippingConditionID <> 70
                THEN 0
            ELSE      10
        END                                     AS OrderTypeForJoin,
        CASE
            WHEN SDSL.[TotalDelivered] < SDSL.[SDSLOrderQtyRunningSum] - SDSL.[ConfirmedQty]
                THEN SDSL.[ConfirmedQty] * SDI.[LocalNetAmount]
            WHEN SDSL.[TotalDelivered] < SDSL.[SDSLOrderQtyRunningSum]
                THEN (SDSL.[SDSLOrderQtyRunningSum] - SDSL.[TotalDelivered]) * SDI.[LocalNetAmount]
            WHEN SDSL.[TotalDelivered] >= SDSL.[SDSLOrderQtyRunningSum]
                THEN 0
        END                                     AS OpenDeliveryValue,
        CASE
            WHEN SDSL.[TotalDelivered] < SDSL.[SDSLOrderQtyRunningSum] - SDSL.[ConfirmedQty]
                THEN 0
            WHEN SDSL.[TotalDelivered] < SDSL.[SDSLOrderQtyRunningSum]
                THEN (SDSL.[TotalDelivered] - SDSL.[SDSLOrderQtyRunningSum] + SDSL.[ConfirmedQty]) * SDI.[LocalNetAmount]
            WHEN SDSL.[TotalDelivered] >= SDSL.[SDSLOrderQtyRunningSum]
                THEN SDSL.[ConfirmedQty] * SDI.[LocalNetAmount]
        END                                     AS ClosedDeliveryValue
	FROM SDSL 
    LEFT JOIN SDI 
        ON SDSL.[SalesDocumentID] = SDI.[SalesDocument] 
        AND SDSL.[SalesDocumentItem] = SDI.[SalesDocumentItem]
    LEFT JOIN documentItems
        ON SDSL.[SalesDocumentID] = documentItems.[SalesDocument] 
        AND SDSL.[SalesDocumentItem] = documentItems.[SalesDocumentItem]
)
SELECT  pre_report.[SalesDocumentID],
        pre_report.[SalesDocumentTypeID],
        pre_report.[SDDocumentRejectionStatusID],
        pre_report.[CreationDate],
        pre_report.[SalesDocumentItem],
        pre_report.[ScheduleLine],
        pre_report.[RequestedDeliveryDate],
        pre_report.[ConfirmedDeliveryDate],
        pre_report.[ConfirmedQty],
        pre_report.[TotalOrderQty],
        pre_report.[TotalDelivered],
        pre_report.[SDSLOrderQtyRunningSum],
        pre_report.[SalesDocumentOrderType],
        pre_report.[ItemOrderStatus],
        pre_report.[OrderStatus],
        pre_report.[ValueConfirmedQuantityLocal],
        pre_report.[ValueConfirmedQuantityEUR],
        pre_report.[ValueConfirmedQuantityUSD],
        pre_report.[CurrencyID],
        pre_report.[BillingQuantityInBaseUnit],
        pre_report.[ShippingConditionID],
        pre_report.[ScheduleLineCategory],
        pre_report.[LocalNetAmount],
        pre_report.[DeliveryStatus],
        pre_report.[InvoicedStatus],
        pre_report.[OrderType],
        pre_report.[OpenDeliveryValue],
        pre_report.[ClosedDeliveryValue],
        statuses.[Status]
FROM pre_report
LEFT JOIN [edw].[vw_SalesDocumentStatuses] statuses
    ON  pre_report.OrderTypeForJoin = statuses.OrderType
        AND pre_report.[DeliveryStatus] = COALESCE (statuses.DeliveryStatus, pre_report.[DeliveryStatus])
        AND pre_report.[InvoicedStatus]= statuses.InvoiceStatus