CREATE VIEW [edw].[vw_PurchasingDocumentItem]
AS
WITH CTE_PurgDocScheduleLineHasNextDelivery AS (
    SELECT
        [PurchasingDocument],
        [PurchasingDocumentItem],
        SUM([ScheduleLineOpenQuantity])   AS [ScheduleLineOpenQuantity],
        MAX([ScheduleLineDeliveryDate])   AS [ScheduleLineDeliveryDate]
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
    PDSLHND.[ScheduleLineOpenQuantity],
    PDSLHND.[ScheduleLineDeliveryDate],
    PDI.[IsCompletelyDelivered],
    PDI.[OrderQuantityUnit],
    PDI.[CostCenter]                        AS [CostCenterID],
    PDI.[GLAccount],
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
        