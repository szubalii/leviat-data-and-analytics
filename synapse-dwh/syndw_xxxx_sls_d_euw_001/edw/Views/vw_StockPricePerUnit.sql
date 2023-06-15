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
), 

/*
   FB 15/09/2022:
   
   The conversion rate to USD is not available for AXBI Budgeted Rates. 
   First, calculate the value in EUR. Then, multiply with the inverted exchange rate (1 / ExchangeRate EUR to USD) for USD to EUR. 
*/

EuroBudgetExchangeRate AS (
    SELECT
            SourceCurrency
        ,   ExchangeRateEffectiveDate
        ,   ExchangeRate
    FROM
        edw.dim_ExchangeRates
    WHERE
        ExchangeRateType = 'P'
        AND
        TargetCurrency = 'EUR'
), 

USDBudgetExchangeRate as (
       select
            TargetCurrency
           ,ExchangeRateEffectiveDate
           ,ExchangeRate
       from
           edw.dim_ExchangeRates
       where
           ExchangeRateType = 'P'
           AND
           SourceCurrency = 'USD'
),


ProductValuationExchangeRate AS (
    SELECT
            [ProductID]
        ,   [ValuationAreaID]
        ,   [ValuationTypeID]
        ,   [CurrencyID]
        ,   [FiscalYearPeriod]
        ,   [FiscalMonthPeriod]
        ,   EuroBudgetExchangeRate.[ExchangeRate] AS [ExchangeRate_EUR]
        ,   USDBudgetExchangeRate.[ExchangeRate] AS [ExchangeRate_USD]
    FROM
    (    
        SELECT
                PV.[ProductID]
            ,   PV.[ValuationAreaID]
            ,   PV.[ValuationTypeID]
            ,   PV.[CurrencyID]
            ,   PV.[FiscalYearPeriod]
            ,   PV.[FiscalMonthPeriod]
            ,   MAX(EuroBudgetExchangeRate.[ExchangeRateEffectiveDate]) AS [ExchangeRateEffectiveDate_EUR]
            ,   MAX(USDBudgetExchangeRate.[ExchangeRateEffectiveDate]) AS [ExchangeRateEffectiveDate_USD]
        FROM 
            ProductValuationPUP AS PV
        CROSS JOIN [edw].[fact_CurrentDate]
        LEFT JOIN 
            EuroBudgetExchangeRate
            ON 
                PV.[CurrencyID] = EuroBudgetExchangeRate.SourceCurrency
        LEFT JOIN 
            USDBudgetExchangeRate
            ON 
                USDBudgetExchangeRate.TargetCurrency = 'EUR'
        WHERE 
                EuroBudgetExchangeRate.[ExchangeRateEffectiveDate] <= today
                AND 
                USDBudgetExchangeRate.[ExchangeRateEffectiveDate] <= today
                /*
                EuroBudgetExchangeRate.[ExchangeRateEffectiveDate] <=  PV.[FiscalStartYearPeriodDate]
                AND 
                USDBudgetExchangeRate.[ExchangeRateEffectiveDate] <= PV.[FiscalStartYearPeriodDate]
                */
        GROUP BY
                PV.[ProductID]
            ,   PV.[ValuationAreaID]
            ,   PV.[ValuationTypeID]
            ,   PV.[CurrencyID]
            ,   PV.[FiscalYearPeriod]
            ,   PV.[FiscalMonthPeriod]
    ) date_EURUSD
    LEFT JOIN 
        EuroBudgetExchangeRate
        ON
            date_EURUSD.[CurrencyID] = EuroBudgetExchangeRate.[SourceCurrency]
            AND
            date_EURUSD.[ExchangeRateEffectiveDate_EUR] = EuroBudgetExchangeRate.[ExchangeRateEffectiveDate]

    LEFT JOIN 
        USDBudgetExchangeRate 
        ON USDBudgetExchangeRate.[TargetCurrency] = 'EUR'
        AND 
        USDBudgetExchangeRate.[ExchangeRateEffectiveDate] = date_EURUSD.[ExchangeRateEffectiveDate_USD]
            
)

SELECT 
    CONCAT_WS(
        '¦' COLLATE Latin1_General_100_BIN2,
        PV.[ProductID],
        PV.[ValuationAreaID],
        PV.[ValuationTypeID],
        PV.[FiscalYearPeriod],
        PV.[FiscalMonthPeriod]

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
    PVEER.[ExchangeRate_EUR],
    PVEER.[ExchangeRate_USD],
    PV.[StockPricePerUnit],
    CONVERT(decimal(19,6), PV.[StockPricePerUnit] * PVEER.[ExchangeRate_EUR]) AS [StockPricePerUnit_EUR],
    CONVERT(decimal(19,6), PV.[StockPricePerUnit] * PVEER.[ExchangeRate_EUR] * (1/PVEER.[ExchangeRate_USD])) AS [StockPricePerUnit_USD],
    PV.[t_applicationId],
    PV.[t_extractionDtm]
FROM 
    ProductValuationPUP AS PV
LEFT JOIN
    ProductValuationExchangeRate PVEER 
        ON 
            PVEER.[ProductID] = PV.[ProductID]
            AND
            PVEER.[ValuationAreaID] = PV.[ValuationAreaID]
            AND
            PVEER.[ValuationTypeID] = PV.[ValuationTypeID]
            AND 
            PVEER.[FiscalYearPeriod] = PV.[FiscalYearPeriod]
            AND 
            PVEER.[FiscalMonthPeriod] = PV.[FiscalMonthPeriod]

