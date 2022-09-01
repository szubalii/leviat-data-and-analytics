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
  )
  
SELECT PDI.[PurchasingDocument]                                      AS [PurchasingDocument],
       PDI.[PurchasingDocumentItem]                                  AS [PurchasingDocumentItem],
       SIWRD.[SupplierInvoice]                                       AS [SupplierInvoiceID],
       PDI.[Material]                                                AS [Material],
       PDI.[DocumentCurrency]                                        AS [PurchaseOrderCurrencyID],
       PDI.[Plant]                                                   AS [PlantID],
       PDI.[CompanyCode]                                             AS [CompanyCode],
       PDI.[MaterialGroup]                                           AS [MaterialGroupID],
       PDI.[PurchaseContract]                                        AS [PurchaseContract],
       PDI.[PurchaseContractItem]                                    AS [PurchaseContractItem],
       PDI.[NetAmount]                                               AS [PurchaseOrderNetAmount],
       PDI.[OrderQuantity]                                           AS [PurchaseOrderQuantity],
       PDI.[StorageLocation]                                         AS [StorageLocationID],
       PDI.[OrderPriceUnit]                                          AS [OrderPriceUnit],
       PDI.[NetPriceAmount]                                          AS [NetPriceAmount],
       PDI.[NetPriceQuantity]                                        AS [NetPriceQuantity],
       PDI.[PurchasingDocumentItemCategory]                          AS [PurchasingDocumentItemCategoryID],
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