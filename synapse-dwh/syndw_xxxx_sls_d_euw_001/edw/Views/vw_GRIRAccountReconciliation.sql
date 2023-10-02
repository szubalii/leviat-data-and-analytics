CREATE VIEW [edw].[vw_GRIRAccountReconciliation]
AS 
SELECT
        GRIPA.[CompanyCode] AS [CompanyCodeID],
        GRIPA.[PurchasingDocument],
        GRIPA.[PurchasingDocumentItem],
        GETDATE() AS [ReportDate],
        GRIPA.[PurchasingDocumentItemUniqueID],
        GRIPA.[OldestOpenItemPostingDate],
        GRIPA.[LatestOpenItemPostingDate],
        GRIPA.[Supplier],
        GRIPA.[SupplierName],
        GRIPA.[HasNoInvoiceReceiptPosted],
        GRIPA.[BalAmtInCompanyCodeCrcy] * ExchangeRate.ExchangeRate AS BalAmtInCompanyCodeCrcy,
        GRIPA.[BalAmtInCompanyCodeCrcy] * ExchangeRate_30.ExchangeRate AS BalAmtInEUR,
        GRIPA.[BalAmtInCompanyCodeCrcy] * ExchangeRate_40.ExchangeRate AS BalAmtInUSD,
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
LEFT JOIN [edw].[vw_CurrencyConversionRate] ExchangeRate   
    ON GRIPA.CompanyCodeCurrency = ExchangeRate.SourceCurrency COLLATE DATABASE_DEFAULT AND ExchangeRate.CurrencyTypeID = '10'
LEFT JOIN [edw].[vw_CurrencyConversionRate] ExchangeRate_30   
    ON GRIPA.CompanyCodeCurrency = ExchangeRate_30.SourceCurrency COLLATE DATABASE_DEFAULT AND ExchangeRate_30.CurrencyTypeID = '30'
LEFT JOIN [edw].[vw_CurrencyConversionRate] ExchangeRate_40  
    ON GRIPA.CompanyCodeCurrency = ExchangeRate_40.SourceCurrency COLLATE DATABASE_DEFAULT AND ExchangeRate_40.CurrencyTypeID = '40'
WHERE ExchangeRate.CurrencyTypeID <> '00'