CREATE VIEW [dm_sales].[vw_fact_PurchasingDocumentItem]
AS
SELECT
  [sk_fact_PurchasingDocumentItem],
  [PurchasingDocument],
  [PurchasingDocumentItem],
  [MaterialID],
  [DocumentCurrencyID],
  dim_C.[Currency],
  [PlantID],
  [CompanyCodeID],
  [MaterialGroupID],
  [PurchaseContract],
  [PurchaseContractItem],
  [NetAmount],
  [PurchaseOrderQuantity],
  [StorageLocationID],
  [OrderPriceUnit],
  [NetPriceAmount],
  [NetPriceQuantity],
  [PurchasingDocumentItemCategoryID],
  [ScheduleLineOpenQuantity],
  [ScheduleLineDeliveryDate],
  [IsCompletelyDelivered],
  [OrderQuantityUnit],
  [CostCenterID],
  [GLAccount],
  [GoodsReceiptQuantity],
  [OrderQuantityUnit],
  fact_PDI.[t_applicationId],
  fact_PDI.[t_extractionDtm]
FROM
  [edw].[fact_PurchasingDocumentItem] fact_PDI
LEFT JOIN
    [edw].[dim_Currency] dim_C
    ON
      fact_PDI.[DocumentCurrencyID] = dim_C.[CurrencyID]
