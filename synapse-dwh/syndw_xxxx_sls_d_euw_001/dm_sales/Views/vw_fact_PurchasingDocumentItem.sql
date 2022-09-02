
CREATE VIEW [dm_sales].[vw_fact_PurchasingDocumentItem]
AS
SELECT 
  [PurchasingDocumentID],
  [PurchasingDocumentItemID],
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