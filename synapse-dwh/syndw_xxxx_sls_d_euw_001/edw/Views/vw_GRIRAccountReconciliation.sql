CREATE VIEW [edw].[vw_GRIRAccountReconciliation] AS 
SELECT
        GRIPA.[CompanyCode] AS [CompanyCodeID],
        GRIPA.[PurchasingDocument],
        GRIPA.[PurchasingDocumentItem],
        GRIPA.[PurchasingDocumentItemUniqueID],
        GRIPA.[OldestOpenItemPostingDate],
        GRIPA.[LatestOpenItemPostingDate],
        GRIPA.[Supplier] AS [SupplierID],
        GRIPA.[SupplierName],
        GRIPA.[HasNoInvoiceReceiptPosted],
        GRIPA.[BalAmtInCompanyCodeCrcy],
        GRIPA.[BalAmtInCompanyCodeCrcy] * CCR_EUR.ExchangeRate AS BalAmtInEUR,
        GRIPA.[BalAmtInCompanyCodeCrcy] * CCR_USD.ExchangeRate AS BalAmtInUSD,
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
FROM 
    [base_s4h_cax].[C_GRIRAccountReconciliation] GRIPA
LEFT JOIN 
    [edw].[vw_CurrencyConversionRate] CCR_EUR   
      ON 
        GRIPA.CompanyCodeCurrency = CCR_EUR.SourceCurrency COLLATE DATABASE_DEFAULT 
        AND 
        CCR_EUR.CurrencyTypeID = '30'
LEFT JOIN 
    [edw].[vw_CurrencyConversionRate] CCR_USD  
      ON 
        GRIPA.CompanyCodeCurrency = CCR_USD.SourceCurrency COLLATE DATABASE_DEFAULT 
        AND 
        CCR_USD.CurrencyTypeID = '40'