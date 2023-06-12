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
    CurrType.[CurrencyType],
    PDI.[PurchaseRequisition],     
    PDI.[PurchaseRequisitionItem],
    CASE
        WHEN PRI.[PurchaseRequisitionType] = 'ZCAT'
            THEN 'X'
        ELSE NULL
    END                                 [IsMercateo],
    PDI.[IsReturnsItem],
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
            AND CAST(GETDATE() as DATE) BETWEEN CCR.ExchangeRateEffectiveDate AND CCR.LastDay
          --AND PD.CreationDate BETWEEN CCR.ExchangeRateEffectiveDate AND CCR.LastDay
INNER JOIN
    [edw].[dim_CurrencyType]    CurrType
        ON CCR.CurrencyTypeID = CurrType.CurrencyTypeID
LEFT JOIN
    [base_s4h_cax].[I_Purchaserequisitionitem]  PRI
        ON PDI.PurchaseRequisition = PRI.PurchaseRequisition                COLLATE DATABASE_DEFAULT
            AND PDI.PurchaseRequisitionItem = PRI.PurchaseRequisitionItem    COLLATE DATABASE_DEFAULT
WHERE CurrType.[CurrencyTypeID] <> '00'