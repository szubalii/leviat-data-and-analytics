CREATE VIEW [edw].[vw_StockPricePerUnit]
AS
/*
    this view calculates Price and Price in Euro,
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

EuroBudgetExchangeRate AS (
    SELECT
            SourceCurrency
        ,   ExchangeRateEffectiveDate
        ,   ExchangeRate
    FROM
        edw.dim_ExchangeRates
    WHERE
        ExchangeRateType = 'ZAXBIBUD'
        AND
        TargetCurrency = 'EUR'
), 

ProductValuationEuroExchangeRate AS (
    SELECT
            [ProductID]
        ,   [ValuationAreaID]
        ,   [ValuationTypeID]
        ,   [CurrencyID]
        ,   [FiscalYearPeriod]
        ,   [FiscalMonthPeriod]
        ,   EuroBudgetExchangeRate.[ExchangeRate] AS [ExchangeRate]
    FROM
    (    
        SELECT
                PV.[ProductID]
            ,   PV.[ValuationAreaID]
            ,   PV.[ValuationTypeID]
            ,   PV.[CurrencyID]
            ,   PV.[FiscalYearPeriod]
            ,   PV.[FiscalMonthPeriod]
            ,   MAX([ExchangeRateEffectiveDate]) AS [ExchangeRateEffectiveDate]
        FROM 
            ProductValuationPUP AS PV
        LEFT JOIN 
            EuroBudgetExchangeRate
            ON 
                PV.[CurrencyID] = EuroBudgetExchangeRate.SourceCurrency
        WHERE 
                [ExchangeRateEffectiveDate] <=  PV.[FiscalStartYearPeriodDate]
        GROUP BY
                PV.[ProductID]
            ,   PV.[ValuationAreaID]
            ,   PV.[ValuationTypeID]
            ,   PV.[CurrencyID]
            ,   PV.[FiscalYearPeriod]
            ,   PV.[FiscalMonthPeriod]
    ) date_eur
    LEFT JOIN 
        EuroBudgetExchangeRate
        ON
            date_eur.[CurrencyID] = EuroBudgetExchangeRate.[SourceCurrency]
            AND
            date_eur.[ExchangeRateEffectiveDate] = EuroBudgetExchangeRate.[ExchangeRateEffectiveDate]
),   

PUP_EUR AS(

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
    PVEER.[ExchangeRate], 
    PV.[StockPricePerUnit],
    CONVERT(decimal(19,6), PV.[StockPricePerUnit] * PVEER.[ExchangeRate]) AS [StockPricePerUnit_EUR],
    PV.[t_applicationId],
    PV.[t_extractionDtm]
FROM 
    ProductValuationPUP AS PV
LEFT JOIN
    ProductValuationEuroExchangeRate PVEER 
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

),

 EuroBudgetExchangeRateUSD as (
       select
            TargetCurrency
           ,ExchangeRateEffectiveDate
           ,ExchangeRate
       from
           edw.dim_ExchangeRates
       where
           ExchangeRateType = 'ZAXBIBUD'
           AND
           SourceCurrency = 'USD'
),

    ExchangeRateUSD as (
        SELECT
            [ProductID]
        ,   [ValuationAreaID]
        ,   [ValuationTypeID]
        ,   [CurrencyID]
        ,   [FiscalYearPeriod]
        ,   [FiscalMonthPeriod]
        ,   EuroBudgetExchangeRateUSD.[ExchangeRate] AS [ExchangeRate]
        FROM (
            SELECT
                PUP_EUR.[ProductID]
            ,   PUP_EUR.[ValuationAreaID]
            ,   PUP_EUR.[ValuationTypeID]
            ,   PUP_EUR.[FiscalYearPeriod]
            ,   PUP_EUR.[FiscalMonthPeriod]
            ,   'EUR' as [CurrencyID]
            ,   MAX([ExchangeRateEffectiveDate]) AS [ExchangeRateEffectiveDate]
        FROM 
            PUP_EUR
            LEFT JOIN 
                EuroBudgetExchangeRateUSD
                ON 
                    EuroBudgetExchangeRateUSD.TargetCurrency = 'EUR'
            WHERE 
                [ExchangeRateEffectiveDate] <= PUP_EUR.[FiscalStartYearPeriodDate]
            GROUP BY
                PUP_EUR.[ProductID]
            ,   PUP_EUR.[ValuationAreaID]
            ,   PUP_EUR.[ValuationTypeID]
            ,   PUP_EUR.[CurrencyID]
            ,   PUP_EUR.[FiscalYearPeriod]
            ,   PUP_EUR.[FiscalMonthPeriod]
        ) bdi_er_date_usd            
        LEFT JOIN 
            EuroBudgetExchangeRateUSD
            ON
                bdi_er_date_usd.[CurrencyID] = EuroBudgetExchangeRateUSD.[TargetCurrency]
                AND
                bdi_er_date_usd.[ExchangeRateEffectiveDate] = EuroBudgetExchangeRateUSD.[ExchangeRateEffectiveDate]
)


SELECT
   PUP_EUR.[nk_dim_ProductValuationPUP],
   PUP_EUR.[ProductID],
   PUP_EUR.[ValuationAreaID],
   PUP_EUR.[ValuationArea],        
   PUP_EUR.[ValuationTypeID],
   PUP_EUR.[ValuationClassID],        
   PUP_EUR.[FiscalYearPeriod],
   PUP_EUR.[FiscalMonthPeriod],
   PUP_EUR.[FiscalPeriodDate],
   PUP_EUR.[TotalValuatedStock],
   PUP_EUR.[TotalValuatedStockValue], 
   PUP_EUR.[PriceControlIndicatorID],
   PUP_EUR.[PriceControlIndicator],
   PUP_EUR.[PeriodicUnitPrice],
   PUP_EUR.[StandardPrice],
   PUP_EUR.[PriceUnit], 
   PUP_EUR.[SAPTotalStockValuePUP],
   PUP_EUR.[SAPTotalStockValueAtSalesPrice],
   PUP_EUR.[CurrencyID],    
   PUP_EUR.ExchangeRate as ExchangeRate_EUR,
   PVUSD.ExchangeRate as ExchangeRate_USD,     
   PUP_EUR.[StockPricePerUnit],
   PUP_EUR.[StockPricePerUnit_EUR],
   CONVERT(decimal(19,6), PUP_EUR.[StockPricePerUnit_EUR] * (1/PVUSD.[ExchangeRate])) AS [StockPricePerUnit_USD],
   PUP_EUR.[t_applicationId],
   PUP_EUR.[t_extractionDtm]
FROM 
    PUP_EUR

    LEFT JOIN
    ExchangeRateUSD PVUSD 
        ON 
            PVUSD.[ProductID] = PUP_EUR.[ProductID]
            AND
            PVUSD.[ValuationAreaID] = PUP_EUR.[ValuationAreaID]
            AND
            PVUSD.[ValuationTypeID] = PUP_EUR.[ValuationTypeID]
            AND 
            PVUSD.[FiscalYearPeriod] = PUP_EUR.[FiscalYearPeriod]
            AND 
            PVUSD.[FiscalMonthPeriod] = PUP_EUR.[FiscalMonthPeriod]