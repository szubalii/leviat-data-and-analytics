
CREATE VIEW [dm_sales].[vw_fact_PurchasingDocumentItem]
AS
WITH PurgDocScheduleLineHasNextDelivery as (
  SELECT 
  [PurchasingDocument]              AS [PurchasingDocumentID],
  [PurchasingDocumentItem]          AS [PurchasingDocumentItemID],
  sum([ScheduleLineOpenQuantity])   AS [ScheduleLineOpenQuantity],
  max([ScheduleLineDeliveryDate])   AS [ScheduleLineDeliveryDate]         
  FROM 
    [base_s4h_cax].[I_PurgDocScheduleLineEnhanced]
  WHERE 
    [PurgDocSchdLnHasNextDelivery] = 'X'
  GROUP BY 
    [PurchasingDocument],
    [PurchasingDocumentItem]
) 
SELECT 
    dim_PD.[PurchasingDocumentID],
    dim_PD.[PurchasingDocumentItemID],
    dim_PD.[Material],
    dim_PD.[PurchaseOrderCurrencyID],
    dim_PD.[PlantID],
    dim_PD.[CompanyCode],
    dim_PD.[MaterialGroupID],
    dim_PD.[PurchaseContract],
    dim_PD.[PurchaseContractItem],
    dim_PD.[PurchaseOrderNetAmount],
    dim_PD.[PurchaseOrderQuantity],
    dim_PD.[StorageLocationID],
    dim_PD.[OrderPriceUnit],
    dim_PD.[NetPriceAmount],
    dim_PD.[NetPriceQuantity],
    dim_PD.[PurchasingDocumentItemCategoryID],
    PDSLHND.[ScheduleLineOpenQuantity],
    PDSLHND.[ScheduleLineDeliveryDate], 
    dim_PD.[t_applicationId],
    dim_PD.[t_extractionDtm]
FROM 
   [edw].[dim_PurchasingDocumentItem] AS dim_PD
LEFT JOIN 
  PurgDocScheduleLineHasNextDelivery PDSLHND
    ON
      PDSLHND.[PurchasingDocumentID] = dim_PD.[PurchasingDocumentID]
      AND 
      PDSLHND.[PurchasingDocumentItemID] = dim_PD.[PurchasingDocumentItemID]
