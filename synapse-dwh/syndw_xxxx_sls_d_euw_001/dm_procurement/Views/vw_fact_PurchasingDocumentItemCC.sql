CREATE VIEW [dm_procurement].[vw_fact_PurchasingDocumentItemCC]
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
    PDI.[NetAmount],
    PDI.[NetAmountTargetCurrency],
    PDI.[CostCenterID],
    PDI.[GLAccountID],
    PDI.[CreationDate],
    PDI.[TargetCurrency],
    PDI.[CurrencyType],
    PDI.[PurchaseRequisition],     
    PDI.[PurchasingOrganization],
    PDI.[IsReturnsItem],
    PDI.[IsMercateo], 
    PDI.[t_applicationId],
    PDI.[t_extractionDtm]
FROM
    [edw].[vw_PurchasingDocumentItemCC]   AS PDI