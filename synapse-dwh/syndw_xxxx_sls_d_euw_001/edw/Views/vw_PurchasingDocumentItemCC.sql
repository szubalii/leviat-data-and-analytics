CREATE VIEW [edw].[vw_PurchasingDocumentItemCC]
AS
SELECT
    PDI.[PurchasingDocument],
    PDI.[PurchasingDocumentItem],
    PDI.[MaterialID],
    PDI.[PurchasingDocumentItemText],
    PDI.[DocumentCurrencyID],
    PDI.[PlantID],
    PDI.[CompanyCodeID],
    PDI.[MaterialGroupID],
    PDI.[PurchaseContract],
    PDI.[PurchaseContractItem],
    PDI.[NetAmount],
    PDI.[NetAmount] * CCR.[ExchangeRate]    AS [NetAmountTargetCurrency],
    PDI.[PurchaseOrderQuantity],
    PDI.[StorageLocationID],
    PDI.[OrderPriceUnit],
    PDI.[NetPriceAmount],
    PDI.[NetPriceQuantity],
    PDI.[PurchasingDocumentItemCategoryID],
    PDI.[NextDeliveryOpenQuantity],
    PDI.[NextDeliveryDate],
    PDI.[IsCompletelyDelivered],
    PDI.[OrderQuantityUnit],
    PDI.[CostCenterID],
    PDI.[GLAccountID],
    PDI.[GoodsReceiptQuantity],
    PD.[CreationDate],
    CCR.[TargetCurrency],
    CurrencyType.[CurrencyType],
    PDI.[t_applicationId],
    PDI.[t_extractionDtm]
FROM
    [edw].[vw_PurchasingDocumentItem]   AS PDI
INNER JOIN
    [edw].[vw_PurchasingDocument]       AS PD
        ON PDI.PurchasingDocument = PD.PurchasingDocument
INNER JOIN
    [edw].[vw_CurrencyConversionRate]   AS CCR
        ON PDI.DocumentCurrencyID = CCR.SourceCurrency
            AND PD.CreationDate BETWEEN CCR.ExchangeRateEffectiveDate AND CCR.LastDay
INNER JOIN
    [dm_sales].[vw_dim_CurrencyType]     CurrType
        ON CCR.CurrencyTypeID = CurrencyType.CurrencyTypeID
