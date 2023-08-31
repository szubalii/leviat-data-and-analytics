CREATE VIEW [edw].[vw_StockPricePerUnit]
AS
/*
    this view calculates Price in EUR, USD and local currency,
    data is prepared for further calculations in [edw].[vw_ProductValuationPUP]
*/
WITH ProductValuationPUP AS (
    SELECT 
        [MATNR]                                                 AS [ProductID],
        [BWKEY]                                                 AS [ValuationAreaID],
        dim_org.[SalesOrganization]                             AS [ValuationArea],        
        [BKLAS]                                                 AS [ValuationClassID],
        [BWTAR]                                                 AS [ValuationTypeID],
        [LFGJA]                                                 AS [FiscalYearPeriod],
        [LFMON]                                                 AS [FiscalMonthPeriod],
        CAST([LFGJA] + '.' + [LFMON] + '.01' AS DATE)           AS [FiscalPeriodDate],  
        CAST([LFGJA] + '.01.01' AS DATE)                        AS [FiscalStartYearPeriodDate],        
        [LBKUM] AS [TotalValuatedStock],
        [SALK3] AS [TotalValuatedStockValue], 
        CASE WHEN [VPRSV] IN ('S', 'V')
            THEN [VPRSV]
            ELSE NULL 
        END                                                     AS [PriceControlIndicatorID],
        CASE 
            WHEN [VPRSV] = 'S' 
            THEN 'Standard Price'
            WHEN [VPRSV] = 'V'  
            THEN 'Periodic Unit Price (PUP)'
            ELSE NULL           
        END                                                     AS [PriceControlIndicator],
        [VERPR]                                                 AS [PeriodicUnitPrice],
        [STPRS]                                                 AS [StandardPrice],
        [PEINH]                                                 AS [PriceUnit], 
        [SALKV]                                                 AS [SAPTotalStockValuePUP],
        [VKSAL]                                                 AS [SAPTotalStockValueAtSalesPrice], 
        dim_comCode.[Currency]                                  AS [CurrencyID],         
        CASE 
            WHEN [VPRSV] = 'S' and ISNULL([PEINH], 0) != 0
            THEN  --StandardPrice / Price Unit
                [STPRS] / [PEINH]
            WHEN [VPRSV] = 'V' and ISNULL([PEINH], 0) != 0  
            THEN --PeriodicUnitPrice / Price Unit
                [VERPR] / [PEINH] 
            ELSE 
                0
        END                                                     AS [StockPricePerUnit],
        [MBEWH].[t_applicationId],
        [MBEWH].[t_extractionDtm]
    FROM 
        [base_s4h_cax].[MBEWH]
    LEFT JOIN  
        [edw].[dim_SalesOrganization] dim_org   
        ON    
            dim_org.[SalesOrganizationID] = [BWKEY] COLLATE Latin1_General_100_BIN2
    LEFT JOIN 
        [base_s4h_cax].[I_Purreqvaluationarea] purArea  
        ON 
            purArea.[ValuationArea] = [BWKEY]  
    LEFT JOIN 
        [edw].[dim_CompanyCode] dim_comCode   
        ON 
            dim_comCode.[CompanyCodeID] = purArea.[CompanyCode] COLLATE Latin1_General_100_BIN2  
)

SELECT 
    edw.svf_get5PartNaturalKey (PV.[ProductID],PV.[ValuationAreaID],PV.[ValuationTypeID],PV.[FiscalYearPeriod],PV.[FiscalMonthPeriod]
                             ) COLLATE SQL_Latin1_General_CP1_CS_AS AS [nk_dim_ProductValuationPUP],
    PV.[ProductID],
    PV.[ValuationAreaID],
    PV.[ValuationArea],        
    PV.[ValuationTypeID],
    PV.[ValuationClassID],  
    PV.[FiscalStartYearPeriodDate],
    PV.[FiscalYearPeriod],
    PV.[FiscalMonthPeriod],
    PV.[FiscalPeriodDate],
    PV.[TotalValuatedStock],
    PV.[TotalValuatedStockValue], 
    PV.[PriceControlIndicatorID],
    PV.[PriceControlIndicator],
    PV.[PeriodicUnitPrice],
    PV.[StandardPrice],
    PV.[PriceUnit], 
    PV.[SAPTotalStockValuePUP],
    PV.[SAPTotalStockValueAtSalesPrice],
    PV.[CurrencyID],        
    CCR30.ExchangeRate AS [ExchangeRate_EUR],
    CCR40.ExchangeRate AS [ExchangeRate_USD],
    PV.[StockPricePerUnit],
    CONVERT(decimal(19,6), PV.[StockPricePerUnit] * CCR30.ExchangeRate) AS [StockPricePerUnit_EUR],
    CONVERT(decimal(19,6), PV.[StockPricePerUnit] * CCR40.ExchangeRate) AS [StockPricePerUnit_USD],
    PV.[t_applicationId],
    PV.[t_extractionDtm]
FROM 
    ProductValuationPUP AS PV
LEFT JOIN 
    [edw].[vw_CurrencyConversionRate] CCR30
    ON 
    PV.CurrencyID = CCR30.SourceCurrency AND CCR30.CurrencyTypeID = '30' 
LEFT JOIN 
    [edw].[vw_CurrencyConversionRate] CCR40
    ON 
    PV.CurrencyID = CCR40.SourceCurrency AND CCR40.CurrencyTypeID = '40'