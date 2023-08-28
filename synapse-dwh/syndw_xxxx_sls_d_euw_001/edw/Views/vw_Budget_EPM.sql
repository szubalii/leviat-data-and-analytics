CREATE VIEW [edw].[vw_Budget_EPM]
AS
SELECT
      [CompanyCode]        
    , [ExQLReportingEntity]
    , CONCAT(CompanyCode,'-',ExQLReportingEntity)                     AS [ReportingEntityID]
    , CR.[CurrencyTypeID]  
    , CR.[CurrencyType] 
    , [LocalCurrency]      
    , [Date]               
    , [InOutID]            
    , CONVERT(decimal(19,6),[ReportedRevenue] * CCR.[ExchangeRate]) AS [3_ReportedRevenue]
    , '20'                                        AS [ValueTypeID]
FROM [base_ff].[Budget_EPM] Budget
LEFT JOIN [edw].[vw_CurrencyConversionRate] CCR
    ON 
    Budget.[LocalCurrency] = CCR.[SourceCurrency] COLLATE DATABASE_DEFAULT 
LEFT JOIN [edw].[dim_CurrencyType] CR
    ON 
    CCR.CurrencyTypeID = CR.CurrencyTypeID
WHERE CR.CurrencyTypeID <> '00'