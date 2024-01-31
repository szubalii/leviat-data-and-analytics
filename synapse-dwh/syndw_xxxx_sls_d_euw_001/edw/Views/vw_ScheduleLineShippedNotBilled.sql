CREATE VIEW [edw].[vw_ScheduleLineShippedNotBilled] AS
SELECT
  SLS.[sk_fact_SalesDocumentItem],
  SLS.[SalesDocumentID],
  SLS.[SalesDocumentItem],
  SLS.[CompanyCode] AS CompanyCodeID,
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
  SLS.[t_applicationId],
  SLS.[t_extractionDtm]
FROM
  [edw].[vw_fact_ScheduleLineStatus] SLS
WHERE
  SLS.SLDeliveryStatus IN ('P', 'C')
  AND
  SLS.SLInvoicedStatus IN ('P', 'N')
