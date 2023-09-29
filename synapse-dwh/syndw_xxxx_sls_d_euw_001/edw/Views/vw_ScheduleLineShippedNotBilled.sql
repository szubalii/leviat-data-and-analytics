CREATE VIEW [edw].[vw_ScheduleLineShippedNotBilled]
AS
SELECT 
        SLS.[nk_fact_SalesDocumentItem],
        SLS.[SalesDocumentID],      
        SLS.[SalesDocumentItem],
        SLS.[SalesDocumentTypeID],
        SLS.[SDDocumentRejectionStatusID], 
        SLS.[IsUnconfirmedDelivery],
        SLS.[CurrencyTypeID],
        SLS.[ScheduleLine],
        SLS.[SalesDocumentOrderType],
        SLS.[OrderStatus],
        SLS.[ItemOrderStatus],
        SLS.[SLDeliveryStatus],
        SLS.[SLInvoicedStatus],
        SLS.[SLStatus],
        SLS.[CreationDate],
        SLS.[RequestedDeliveryDate],
        SLS.[ConfirmedDeliveryDate],
        SLS.[SDI_ODB_LatestActualGoodsMovmtDate],
        SLS.[DelivBlockReasonForSchedLine],
        SLS.[LoadingDate],
        SLS.[ConfirmedQty],
        SLS.[TotalOrderQty],
        SLS.[TotalDelivered],
        SLS.[SDSLOrderQtyRunningSum],
        SLS.[ValueConfirmedQuantity],
        SLS.[CurrencyID],
        SLS.[BillingQuantity],
        SLS.[ShippingConditionID],
        SLS.[ScheduleLineCategory],
        SLS.[NetAmount],
        SLS.[OpenDeliveryValue],
        SLS.[ClosedDeliveryValue],
        SLS.[OpenInvoicedValue],
        SLS.[ClosedInvoicedValue],
        SLS.[PricePerUnit],
        SLS.[InScope],
        ODI.[HDR_ActualGoodsMovementDate]
FROM [dm_sales].[vw_fact_ScheduleLineStatus] SLS
LEFT JOIN [edw].[fact_OutboundDeliveryItem] ODI
       ON SLS.SalesDocumentID = ODI.ReferenceSDDocument
       AND SLS.SalesDocumentItem = ODI.ReferenceSDDocumentItem
WHERE SLS.SLDeliveryStatus IN ('P', 'C') AND SLS.SLInvoicedStatus IN ('P', 'N')