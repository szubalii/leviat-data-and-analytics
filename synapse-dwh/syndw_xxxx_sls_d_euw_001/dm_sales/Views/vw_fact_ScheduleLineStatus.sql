CREATE VIEW [dm_sales].[vw_fact_ScheduleLineStatus] AS
SELECT
  [sk_fact_SalesDocumentItem] AS [sk_fact_ScheduleLineStatus],
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
  [InScope],
  [IsScheduleLineBlockedFlag],
  [IsOrderItemBlockedFlag],
  CASE 
      WHEN IsScheduleLineBlockedFlag = 1 OR IsOrderItemBlockedFlag = 1
      THEN 1
      ELSE 0
  END AS [IsBlockedFlag] 
FROM
  [edw].[vw_fact_ScheduleLineStatus]
