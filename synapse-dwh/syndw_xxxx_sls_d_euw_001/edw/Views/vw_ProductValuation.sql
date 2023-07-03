CREATE VIEW [edw].[vw_ProductValuation]
AS
WITH ProductValuation AS (
    SELECT
       basePV.[Product]                                AS [ProductID],
       basePV.[ValuationArea]                          AS [ValuationAreaID],
       basePV.[ValuationType]                          AS [ValuationTypeID],
       basePV.[ValuationClass]                         AS [ValuationClassID],
       basePV.[PriceDeterminationControl]              AS [PriceDeterminationControlID],
       basePV.[FiscalMonthCurrentPeriod],
       basePV.[FiscalYearCurrentPeriod],
       basePV.[StandardPrice],
       basePV.[PriceUnitQty]                           AS [PriceUnitQuantity],
       basePV.[StandardPrice] / basePV.[PriceUnitQty]  AS [StandardPricePerUnit],
       basePV.[InventoryValuationProcedure],
       basePV.[FutureEvaluatedAmountValue],
       basePV.[FuturePriceValidityStartDate],
       basePV.[PrevInvtryPriceInCoCodeCrcy],       
       basePV.[MovingAveragePrice],
       basePV.[MovingAveragePrice] / basePV.[PriceUnitQty]  AS [MovingAvgPricePerUnit],
       basePV.[ValuationCategory]                           AS [ValuationCategoryID],
       basePV.[ProductUsageType], 
       basePV.[ProductOriginType],
       basePV.[IsProducedInhouse],
       basePV.[ProdCostEstNumber],
       basePV.[IsMarkedForDeletion],
       basePV.[ValuationMargin],
       basePV.[IsActiveEntity],
       basePV.[CompanyCode]                            AS [CompanyCodeID],
       basePV.[ValuationClassSalesOrderStock], 
       basePV.[ProjectStockValuationClass],
       basePV.[PlannedPrice1InCoCodeCrcy], 
       basePV.[PlannedPrice2InCoCodeCrcy], 
       basePV.[PlannedPrice3InCoCodeCrcy], 
       basePV.[FuturePlndPrice1ValdtyDate], 
       basePV.[FuturePlndPrice2ValdtyDate], 
       basePV.[FuturePlndPrice3ValdtyDate], 
       basePV.[TaxBasedPricesPriceUnitQty],     
       basePV.[PriceLastChangeDate],
       basePV.[PlannedPrice],       
       basePV.[Currency]                               AS [CurrencyID],
       basePV.[t_applicationId],
       basePV.[t_extractionDtm]
    FROM [base_s4h_cax].[I_ProductValuation] AS basePV
), EuroBudgetExchangeRate AS (
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
        AND
        [ExchangeRateEffectiveDate] <= GETDATE()
            UNION ALL
    SELECT
        'EUR'
        ,'1900-01-01'
        ,1.0
), ProductValuationEuroExchangeRate AS (
    SELECT
            [ProductID]
        ,   [ValuationAreaID]
        ,   [ValuationTypeID]
        ,   [CurrencyID]
        ,   EuroBudgetExchangeRate.[ExchangeRate] AS [ExchangeRate]
    FROM
    (    
        SELECT
                PV.[ProductID]
            ,   PV.[ValuationAreaID]
            ,   PV.[ValuationTypeID]
            ,   PV.[CurrencyID]
            ,   MAX([ExchangeRateEffectiveDate]) AS [ExchangeRateEffectiveDate]
        FROM 
            ProductValuation AS PV
        LEFT JOIN 
            EuroBudgetExchangeRate
            ON 
                PV.[CurrencyID] = EuroBudgetExchangeRate.SourceCurrency
        GROUP BY
                PV.[ProductID]
            ,   PV.[ValuationAreaID]
            ,   PV.[ValuationTypeID]
            ,   PV.[CurrencyID]
    ) date_eur
    LEFT JOIN 
        EuroBudgetExchangeRate
        ON
            date_eur.[CurrencyID] = EuroBudgetExchangeRate.[SourceCurrency]
            AND
            date_eur.[ExchangeRateEffectiveDate] = EuroBudgetExchangeRate.[ExchangeRateEffectiveDate]
)                      
SELECT
       PV.[ProductID],
       PV.[ValuationAreaID],
       PV.[ValuationTypeID],
       PV.[ValuationClassID], 
       PV.[PriceDeterminationControlID],
       PV.[FiscalMonthCurrentPeriod],
       PV.[FiscalYearCurrentPeriod],
       PV.[StandardPrice],
       PV.[PriceUnitQuantity],
       PV.[StandardPricePerUnit],
       CONVERT(decimal(19,6), PV.[StandardPricePerUnit] * PVEER.[ExchangeRate]) AS StandardPricePerUnit_EUR,
       PV.[InventoryValuationProcedure],
       PV.[FutureEvaluatedAmountValue],
       PV.[FuturePriceValidityStartDate],
       PV.[PrevInvtryPriceInCoCodeCrcy],
       PV.[MovingAveragePrice],
       PV.[MovingAvgPricePerUnit],
       CONVERT(decimal(19,6), PV.[MovingAvgPricePerUnit] * PVEER.[ExchangeRate]) AS MovingAvgPricePerUnit_EUR,
       PV.[ValuationCategoryID],
       PV.[ProductUsageType], 
       PV.[ProductOriginType],
       PV.[IsProducedInhouse],
       PV.[ProdCostEstNumber],
       PV.[IsMarkedForDeletion],
       PV.[ValuationMargin],
       PV.[IsActiveEntity],
       PV.[CompanyCodeID],
       PV.[ValuationClassSalesOrderStock], 
       PV.[ProjectStockValuationClass],
       PV.[PlannedPrice1InCoCodeCrcy], 
       PV.[PlannedPrice2InCoCodeCrcy], 
       PV.[PlannedPrice3InCoCodeCrcy], 
       PV.[FuturePlndPrice1ValdtyDate], 
       PV.[FuturePlndPrice2ValdtyDate], 
       PV.[FuturePlndPrice3ValdtyDate], 
       PV.[TaxBasedPricesPriceUnitQty],           
       PV.[PriceLastChangeDate],
       PV.[PlannedPrice],
       PV.[CurrencyID],
       PV.[t_applicationId],
       PV.[t_extractionDtm]
FROM 
    ProductValuation AS PV
LEFT JOIN
    ProductValuationEuroExchangeRate PVEER 
        ON 
            PVEER.[ProductID] = PV.[ProductID]
            AND
            PVEER.[ValuationAreaID] = PV.[ValuationAreaID]
            AND
            PVEER.[ValuationTypeID] = PV.[ValuationTypeID]