
CREATE VIEW [dm_sales].[vw_fact_PurchasingDocumentItem]
AS
SELECT 
  [sk_fact_PurchasingDocumentItem],
  [PurchasingDocument],
  [PurchasingDocumentItem],
  [MaterialID],
  [DocumentCurrencyID],
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
  [t_applicationId],
  [t_extractionDtm]
FROM 
   [edw].[fact_PurchasingDocumentItem]