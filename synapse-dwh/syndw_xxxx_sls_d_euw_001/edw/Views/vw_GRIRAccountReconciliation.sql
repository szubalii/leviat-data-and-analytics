CREATE VIEW [edw].[vw_GRIRAccountReconciliation]
AS 
SELECT
        GRIPA.[CompanyCode] AS [CompanyCodeID],
        GRIPA.[PurchasingDocument],
        GRIPA.[PurchasingDocumentItem],
        GRIPA.[PurchasingDocumentItemUniqueID],
        GRIPA.[OldestOpenItemPostingDate],
        GRIPA.[LatestOpenItemPostingDate],
        GRIPA.[Supplier],
        GRIPA.[SupplierName],
        GRIPA.[HasNoInvoiceReceiptPosted],
        GRIPA.[BalAmtInCompanyCodeCrcy],
        GRIPA.[CompanyCodeCurrency],
        GRIPA.[BalanceQuantityInRefQtyUnit],
        GRIPA.[ReferenceQuantityUnit],
        GRIPA.[NumberOfGoodsReceipts],
        GRIPA.[NumberOfInvoiceReceipts],
        GRIPA.[ResponsibleDepartment],
        GRIPA.[ResponsiblePerson],
        GRIPA.[GRIRClearingProcessStatus],
        GRIPA.[GRIRClearingProcessPriority],
        GRIPA.[HasNote],
        GRIPA.[AccountAssignmentCategory],
        GRIPA.[ValuationType],
        GRIPA.[IsGoodsRcptGoodsAmtSurplus],
        GRIPA.[IsGdsRcptDelivCostAmtSurplus],
        GRIPA.[SystemMessageType],
        GRIPA.[SystemMessageNumber],
        GRIPA.[t_applicationId],
        GRIPA.[t_extractionDtm]
FROM [base_s4h_cax].[C_GRIRAccountReconciliation] GRIPA
LEFT JOIN [edw].[vw_CurrencyConversionRate] CCR   
    ON GRIPA.CompanyCodeCurrency = CCR.SourceCurrency  COLLATE DATABASE_DEFAULT
LEFT JOIN [edw].[dim_CurrencyType] CT
    ON CCR.CurrencyTypeID = CT.CurrencyTypeID
