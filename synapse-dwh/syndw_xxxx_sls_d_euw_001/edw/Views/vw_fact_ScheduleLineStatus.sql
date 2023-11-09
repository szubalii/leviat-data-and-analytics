CREATE VIEW [edw].[vw_fact_ScheduleLineStatus]
AS
WITH DeliveryItem AS 
( 
	SELECT 
		SUM([ActualDeliveredQtyInBaseUnit])     AS [ActualDeliveredQtyInBaseUnit],
		SUM([ActualDeliveryQuantity])           AS [ActualDeliveredQtySalesUnit], /*use Qty in SO UoM*/
        MAX([HDR_ActualGoodsMovementDate])      AS [SDI_ODB_LatestActualGoodsMovmtDate],
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
        SDSL.ScheduleLineCategory,
        CASE
            WHEN 
                COUNT(*)
                    OVER (
                        PARTITION BY 
                            SDSL.[SalesDocumentID],
                            SDSL.[SalesDocumentItem] 
                    )
                = 1
                AND SDSL.ConfirmedDeliveryDate = '0001-01-01'
            THEN 'X'
            ELSE ''
        END                                         AS IsUnconfirmedDelivery,
        DeliveryItem.[SDI_ODB_LatestActualGoodsMovmtDate],
        SDSL.DelivBlockReasonForSchedLine,
        SDSL.LoadingDate
	FROM [edw].[dim_SalesDocumentScheduleLine] SDSL 
	LEFT JOIN DeliveryItem 
        ON SDSL.[SalesDocumentID] = DeliveryItem.[ReferenceSDDocument] 
	        AND SDSL.[SalesDocumentItem] = DeliveryItem.[ReferenceSDDocumentItem]
)
,documentItems AS (
    SELECT MAX(BillingQuantityInBaseUnit)           AS [BillingQuantityInBaseUnit] 
        , MAX(BillingQuantity)                      AS [BillingQuantity] 
        --, MAX(CompanyCode)                          AS [CompanyCode]
        , ReferenceSDDocument
        , ReferenceSDDocumentItem
    FROM (
        SELECT SUM(BillingQuantityInBaseUnit)   AS [BillingQuantityInBaseUnit] 
            ,SUM(BillingQuantity)               AS [BillingQuantity] 
            --,MAX(CompanyCode)                   AS [CompanyCode]
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
        SDI.[sk_fact_SalesDocumentItem],
        SDSL.[SalesDocumentID],
        SDI.[SalesDocumentTypeID],
        SDI.[SDDocumentRejectionStatusID],
        SDSL.[IsUnconfirmedDelivery],
        SDI.[CreationDate],
        SDI.[CurrencyTypeID],
        SDSL.[SalesDocumentItem],
        SDSL.[ScheduleLine],
        SDSL.[RequestedDeliveryDate],
        SDSL.[ConfirmedDeliveryDate],
        SDSL.[SDI_ODB_LatestActualGoodsMovmtDate],
        SDSL.[DelivBlockReasonForSchedLine],
        SDSL.[LoadingDate],
        SDSL.[ConfirmedQty],
        SDI.[OrderQuantity]                     AS [TotalOrderQty],
        SDSL.[TotalDelivered],
        SDSL.[SDSLOrderQtyRunningSum],
        SDI.[OrderType]                         AS [SalesDocumentOrderType],
        SDI.[ItemOrderStatus],
        SDI.[OrderStatus],
        SDSL.[ConfirmedQty] / SDSL.[TotalOrderQty] * SDI.[NetAmount]
                                                AS ValueConfirmedQuantity,
        SDI.CurrencyID,
        documentItems.[BillingQuantity],
        SDI.ShippingConditionID,
        SDSL.ScheduleLineCategory,
        SDI.[NetAmount],
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
        CASE
            WHEN SDSL.[TotalDelivered] < SDSL.[SDSLOrderQtyRunningSum] - SDSL.[ConfirmedQty]
                THEN SDSL.[ConfirmedQty] * SDI.[NetAmount] / SDI.[OrderQuantity]
            WHEN SDSL.[TotalDelivered] < SDSL.[SDSLOrderQtyRunningSum]
                THEN (SDSL.[SDSLOrderQtyRunningSum] - SDSL.[TotalDelivered]) * SDI.[NetAmount] / SDI.[OrderQuantity]
            WHEN SDSL.[TotalDelivered] >= SDSL.[SDSLOrderQtyRunningSum]
                THEN 0
        END                                     AS OpenDeliveryValue,
        CASE
            WHEN SDSL.[TotalDelivered] < SDSL.[SDSLOrderQtyRunningSum] - SDSL.[ConfirmedQty]
                THEN 0
            WHEN SDSL.[TotalDelivered] < SDSL.[SDSLOrderQtyRunningSum]
                THEN (SDSL.[TotalDelivered] - SDSL.[SDSLOrderQtyRunningSum] + SDSL.[ConfirmedQty]) * SDI.[NetAmount] / SDI.[OrderQuantity]
            WHEN SDSL.[TotalDelivered] >= SDSL.[SDSLOrderQtyRunningSum]
                THEN SDSL.[ConfirmedQty] * SDI.[NetAmount] / SDI.[OrderQuantity]
        END                                     AS ClosedDeliveryValue,
        CASE
            WHEN documentItems.[BillingQuantity] < SDSL.[SDSLOrderQtyRunningSum] - SDSL.[ConfirmedQty]
                OR documentItems.[BillingQuantity] IS NULL
                THEN SDSL.[ConfirmedQty] * SDI.[NetAmount] / SDI.[OrderQuantity]
            WHEN documentItems.[BillingQuantity] < SDSL.[SDSLOrderQtyRunningSum]
                THEN (SDSL.[SDSLOrderQtyRunningSum] - documentItems.[BillingQuantity]) * SDI.[NetAmount] / SDI.[OrderQuantity]
            WHEN documentItems.[BillingQuantity] >= SDSL.[SDSLOrderQtyRunningSum]
                THEN 0
        END                                     AS OpenInvoicedValue,
        CASE
            WHEN documentItems.[BillingQuantity] < SDSL.[SDSLOrderQtyRunningSum] - SDSL.[ConfirmedQty]
                OR documentItems.[BillingQuantity] IS NULL
                THEN 0
            WHEN documentItems.[BillingQuantity] < SDSL.[SDSLOrderQtyRunningSum]
                THEN (documentItems.[BillingQuantity] - SDSL.[SDSLOrderQtyRunningSum] + SDSL.[ConfirmedQty]) * SDI.[NetAmount] / SDI.[OrderQuantity]
            WHEN documentItems.[BillingQuantity] >= SDSL.[SDSLOrderQtyRunningSum]
                THEN SDSL.[ConfirmedQty] * SDI.[NetAmount] / SDI.[OrderQuantity]
        END                                     AS ClosedInvoicedValue,
        SDI.[NetAmount] / SDI.[OrderQuantity]   AS [PricePerUnit],
        SO.[CompanyCode],
        SDI.t_applicationId,
        SDI.t_extractionDtm
	FROM SDSL 
    LEFT JOIN [edw].[fact_SalesDocumentItem] SDI 
        ON SDSL.[SalesDocumentID] = SDI.[SalesDocument] 
        AND SDSL.[SalesDocumentItem] = SDI.[SalesDocumentItem]
    LEFT JOIN [edw].[dim_SalesOrganization] SO
        ON SDI.[SalesOrganizationID] = SO.[SalesOrganizationID]
    LEFT JOIN documentItems
        ON SDSL.[SalesDocumentID] = documentItems.[ReferenceSDDocument] 
        AND SDSL.[SalesDocumentItem] = documentItems.[ReferenceSDDocumentItem]
    WHERE SDI.CurrencyTypeID IN ('10','30','40')
        AND SDI.[OrderQuantity] <> 0
        AND SDI.[SDDocumentCategoryID] <> 'B'
)
SELECT
        pre_report.[sk_fact_SalesDocumentItem],
        pre_report.[SalesDocumentTypeID],
        pre_report.[SDDocumentRejectionStatusID], 
        pre_report.[SalesDocumentID],      
        pre_report.[SalesDocumentItem],
        pre_report.[IsUnconfirmedDelivery],
        pre_report.[CurrencyTypeID],
        pre_report.[ScheduleLine],
        pre_report.[SalesDocumentOrderType],
        pre_report.[OrderStatus],
        pre_report.[ItemOrderStatus],
        pre_report.[DeliveryStatus]         AS [SLDeliveryStatus],
        pre_report.[InvoicedStatus]         AS [SLInvoicedStatus],
        statuses.[Status]                   AS [SLStatus],
        pre_report.[CreationDate],
        pre_report.[RequestedDeliveryDate],
        pre_report.[ConfirmedDeliveryDate],
        pre_report.[SDI_ODB_LatestActualGoodsMovmtDate],
        pre_report.[DelivBlockReasonForSchedLine],
        pre_report.[LoadingDate],
        pre_report.[ConfirmedQty],
        pre_report.[TotalOrderQty],
        pre_report.[TotalDelivered],
        pre_report.[SDSLOrderQtyRunningSum],
        pre_report.[ValueConfirmedQuantity],
        pre_report.[CurrencyID],
        pre_report.[BillingQuantity],
        pre_report.[ShippingConditionID],
        pre_report.[ScheduleLineCategory],
        pre_report.[NetAmount],
        pre_report.[OpenDeliveryValue],
        pre_report.[ClosedDeliveryValue],
        pre_report.[OpenInvoicedValue],
        pre_report.[ClosedInvoicedValue],
        pre_report.[PricePerUnit],
        CASE
            WHEN pre_report.[SalesDocumentTypeID] LIKE 'ZOR'
                THEN '1'
            ELSE '0'
        END                                 AS InScope,
        pre_report.[CompanyCode],
        pre_report.t_applicationId,
        pre_report.t_extractionDtm
FROM pre_report
LEFT JOIN [base_ff].[SalesDocumentStatuses] statuses
    ON  pre_report.SalesDocumentOrderType = statuses.OrderTypeText
        AND pre_report.[DeliveryStatus] = COALESCE (statuses.DeliveryStatus, pre_report.[DeliveryStatus])
        AND pre_report.[InvoicedStatus]= statuses.InvoiceStatus
