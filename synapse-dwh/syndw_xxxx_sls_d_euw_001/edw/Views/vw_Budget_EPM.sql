CREATE VIEW [edw].[vw_Budget_EPM]
AS
SELECT
      Budget.[CompanyCodeID]        
    , Budget.[ExQLReportingEntity]
    , CR.[CurrencyTypeID]  
    , CR.[CurrencyType] 
    , CASE 
            WHEN CCR.[CurrencyTypeID] = '10'
                THEN Budget.[LocalCurrencyID] COLLATE DATABASE_DEFAULT
            ELSE CCR.[TargetCurrency]  
      END                                                                  AS [CurrencyID]
    , Budget.[Date]               
    , Budget.[InOutID]            
    , CONVERT(decimal(19,6),Budget.[ReportedRevenue] * CCR.[ExchangeRate]) AS [3_ReportedRevenue]
    , '20'                                                                 AS [ValueTypeID]
FROM [base_ff].[Budget_EPM] Budget
LEFT JOIN [edw].[vw_CurrencyConversionRate] CCR
    ON 
    Budget.[LocalCurrencyID] = CCR.[SourceCurrency] COLLATE DATABASE_DEFAULT 
LEFT JOIN [edw].[dim_CurrencyType] CR
    ON 
    CCR.CurrencyTypeID = CR.CurrencyTypeID
WHERE CR.CurrencyTypeID <> '00'