CREATE VIEW [edw].[vw_PurchasingDocumentItem]
AS
WITH CTE_PurgDocScheduleLineHasNextDelivery AS (
    SELECT
        [PurchasingDocument],
        [PurchasingDocumentItem],
        SUM([ScheduleLineOpenQuantity])   AS [NextDeliveryOpenQuantity], --TODO correct field?
        MAX([ScheduleLineDeliveryDate])   AS [NextDeliveryDate]
    FROM
        [base_s4h_cax].[I_PurgDocScheduleLineEnhanced]
    WHERE
        [PurgDocSchdLnHasNextDelivery] = 'X'
    GROUP BY
        [PurchasingDocument],
        [PurchasingDocumentItem]
),
CTE_PurgDocScheduleLineSums AS (
    SELECT
        [PurchasingDocument],
        [PurchasingDocumentItem],
        SUM([GoodsReceiptQuantity])         AS [GoodsReceiptQuantity]
    FROM
        [base_s4h_cax].[I_PurgDocScheduleLineEnhanced]
    GROUP BY
        [PurchasingDocument],
        [PurchasingDocumentItem]
)

SELECT
    PDI.[PurchasingDocument],
    PDI.[PurchasingDocumentItem],
    PDI.[Material]                          AS [MaterialID],
    PDI.[DocumentCurrency]                  AS [DocumentCurrencyID],
    PDI.[Plant]                             AS [PlantID],
    PDI.[CompanyCode]                       AS [CompanyCodeID],
    PDI.[MaterialGroup]                     AS [MaterialGroupID],
    PDI.[PurchaseContract],
    PDI.[PurchaseContractItem],
    PDI.[NetAmount],
    PDI.[OrderQuantity]                     AS [PurchaseOrderQuantity],
    PDI.[StorageLocation]                   AS [StorageLocationID],
    PDI.[OrderPriceUnit],
    PDI.[NetPriceAmount],
    PDI.[NetPriceQuantity],
    PDI.[PurchasingDocumentItemCategory]    AS [PurchasingDocumentItemCategoryID],
    PDSLHND.[NextDeliveryOpenQuantity],
    PDSLHND.[NextDeliveryDate],
    PDI.[IsCompletelyDelivered],
    PDI.[OrderQuantityUnit],
    PAA.[KOSTL]                             AS [CostCenterID],
    PAA.[SAKTO]                             AS [GLAccount],
    PDSLSum.[GoodsReceiptQuantity],
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
LEFT JOIN
    CTE_PurgDocScheduleLineSums PDSLSum
        ON
            PDSLSum.[PurchasingDocument] = PDI.[PurchasingDocument]
            AND
            PDSLSum.[PurchasingDocumentItem] = PDI.[PurchasingDocumentItem]
LEFT JOIN
    [base_s4h_cax].[PurgAccAssignment] PAA
        ON
            PDI.[PurchasingDocument] = PAA.[EBELN]
            AND            
            PDI.[PurchasingDocumentItem] = PAA.[EBELP]