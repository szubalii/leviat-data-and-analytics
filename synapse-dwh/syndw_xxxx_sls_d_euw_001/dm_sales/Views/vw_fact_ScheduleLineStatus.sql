CREATE VIEW [dm_sales].[vw_fact_ScheduleLineStatus] AS
SELECT
  [nk_fact_SalesDocumentItem],
  [SalesDocumentTypeID],
  [SDDocumentRejectionStatusID],
  [SalesDocumentID],
  [SalesDocumentItem],
  [IsUnconfirmedDelivery],
  [CurrencyTypeID],
  [ScheduleLine],
  [SalesDocumentOrderType],
  [OrderStatus],
  [ItemOrderStatus],
  [SLDeliveryStatus],
  [SLInvoicedStatus],
  [SLStatus],
  [CreationDate],
  [RequestedDeliveryDate],
  [ConfirmedDeliveryDate],
  [SDI_ODB_LatestActualGoodsMovmtDate],
  [DelivBlockReasonForSchedLine],
  [LoadingDate],
  [ConfirmedQty],
  [TotalOrderQty],
  [TotalDelivered],
  [SDSLOrderQtyRunningSum],
  [ValueConfirmedQuantity],
  [CurrencyID],
  [BillingQuantity],
  [ShippingConditionID],
  [ScheduleLineCategory],
  [NetAmount],
  [OpenDeliveryValue],
  [ClosedDeliveryValue],
  [OpenInvoicedValue],
  [ClosedInvoicedValue],
  [PricePerUnit],
  [InScope]
FROM
  [edw].[vw_fact_ScheduleLineStatus]
