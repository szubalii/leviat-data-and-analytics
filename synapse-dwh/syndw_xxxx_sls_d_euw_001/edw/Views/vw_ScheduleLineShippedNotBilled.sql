CREATE VIEW [edw].[vw_ScheduleLineShippedNotBilled] AS
SELECT
  SLS.[nk_fact_SalesDocumentItem],
  SLS.[SalesDocumentID],
  SLS.[SalesDocumentItem],
  CONVERT (date, GETDATE()) AS [ReportDate],
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
  LODI.[LatestActualGoodsMovementDate]
FROM
  [edw].[vw_fact_ScheduleLineStatus] SLS
LEFT JOIN
  [edw].[vw_LatestOutboundDeliveryItem] LODI
  ON
    SLS.SalesDocumentID = LODI.ReferenceSDDocument
    AND
    SLS.SalesDocumentItem = LODI.ReferenceSDDocumentItem
WHERE
  SLS.SLDeliveryStatus IN ('P', 'C')
  AND
  SLS.SLInvoicedStatus IN ('P', 'N')
