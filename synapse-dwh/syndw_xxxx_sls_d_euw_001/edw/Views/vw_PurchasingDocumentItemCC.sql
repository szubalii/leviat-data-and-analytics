CREATE VIEW [edw].[vw_PurchasingDocumentItemCC]
AS
SELECT
  PDI.[sk_fact_PurchasingDocumentItem],
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
  PDI.[NetAmount] * CCR.[ExchangeRate] AS [NetAmountTargetCurrency],
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
    THEN 'Yes'
    ELSE 'No'
  END AS [IsMercateo],
  edw.svf_getBooleanIndicator(PDI.[IsReturnsItem]) AS IsReturnsItem,
  PDI.[t_applicationId],
  PDI.[t_extractionDtm]
FROM
  [edw].[fact_PurchasingDocumentItem] AS PDI
INNER JOIN
  [edw].[fact_PurchasingDocument] AS PD
  ON
    PDI.PurchasingDocument = PD.PurchasingDocument
INNER JOIN
  [edw].[vw_CurrencyConversionRate] AS CCR
  ON
    PDI.DocumentCurrencyID = CCR.SourceCurrency
INNER JOIN
  [edw].[dim_CurrencyType] AS CurrType
  ON
    CCR.CurrencyTypeID = CurrType.CurrencyTypeID
LEFT JOIN
  [base_s4h_cax].[I_Purchaserequisitionitem] AS PRI
  ON
    PDI.PurchaseRequisition = PRI.PurchaseRequisition COLLATE DATABASE_DEFAULT
    AND
    PDI.PurchaseRequisitionItem = PRI.PurchaseRequisitionItem COLLATE DATABASE_DEFAULT
WHERE CurrType.[CurrencyTypeID] <> '00'
