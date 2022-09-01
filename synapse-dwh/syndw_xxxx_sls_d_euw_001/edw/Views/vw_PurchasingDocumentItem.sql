CREATE VIEW [edw].[vw_PurchasingDocumentItem]
AS 
WITH CTE_SupplierInvoiceWithoutReverseDoc AS (
    SELECT
        siipor.SupplierInvoice,
        siipor.PurchaseOrder,
        siipor.PurchaseOrderItem
    FROM
        base_s4h_cax.I_SupplierInvoiceItemPurOrdRef siipor
    JOIN
        base_s4h_cax.I_SupplierInvoice si
        ON
            si.SupplierInvoice = siipor.SupplierInvoice
            AND
            ISNULL(si.ReverseDocument, '') = ''
    GROUP BY        
        siipor.SupplierInvoice,
        siipor.PurchaseOrder,
        siipor.PurchaseOrderItem
),
CTE_PurgDocScheduleLineHasNextDelivery as (
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
    PDI.[PurchasingDocument]                                      AS [PurchasingDocumentID],
    PDI.[PurchasingDocumentItem]                                  AS [PurchasingDocumentItemID],
    SIWRD.[SupplierInvoice]                                       AS [SupplierInvoiceID],
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
      CTE_SupplierInvoiceWithoutReverseDoc SIWRD
      ON
          SIWRD.PurchaseOrder = PDI.PurchasingDocument
          AND
          SIWRD.PurchaseOrderItem = PDI.PurchasingDocumentItem
  LEFT JOIN 
      CTE_PurgDocScheduleLineHasNextDelivery PDSLHND
      ON
          PDSLHND.[PurchasingDocumentID] = PDI.[PurchasingDocument]
          AND 
          PDSLHND.[PurchasingDocumentItemID] = PDI.[PurchasingDocumentItem]