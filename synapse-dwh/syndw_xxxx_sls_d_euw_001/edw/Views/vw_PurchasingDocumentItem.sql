CREATE VIEW [edw].[vw_PurchasingDocumentItem]
AS 
WITH CTE_PurgDocScheduleLineHasNextDelivery as (
    SELECT 
        [PurchasingDocument],
        [PurchasingDocumentItem],
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
    PDI.[PurchasingDocument],
    PDI.[PurchasingDocumentItem],
    PDI.[Material]                                                AS [MaterialID],
    PDI.[DocumentCurrency]                                        AS [DocumentCurrencyID],
    PDI.[Plant]                                                   AS [PlantID],
    PDI.[CompanyCode]                                             AS [CompanyCodeID],
    PDI.[MaterialGroup]                                           AS [MaterialGroupID],
    PDI.[PurchaseContract],
    PDI.[PurchaseContractItem],
    PDI.[NetAmount],
    PDI.[OrderQuantity]                                           AS [PurchaseOrderQuantity],
    PDI.[StorageLocation]                                         AS [StorageLocationID],
    PDI.[OrderPriceUnit],
    PDI.[NetPriceAmount],
    PDI.[NetPriceQuantity],
    PDI.[PurchasingDocumentItemCategory]                          AS [PurchasingDocumentItemCategoryID],
    PDSLHND.[ScheduleLineOpenQuantity],
    PDSLHND.[ScheduleLineDeliveryDate], 
    PDI.[t_applicationId],
    PDI.[t_extractionDtm]       
FROM 
  [base_s4h_cax].[I_PurchasingDocumentItem] AS PDI
  LEFT JOIN 
      CTE_PurgDocScheduleLineHasNextDelivery PDSLHND
      ON
          PDSLHND.[PurchasingDocument] = PDI.[PurchasingDocument]
          AND 
          PDSLHND.[PurchasingDocumentItem] = PDI.[PurchasingDocumentItem]