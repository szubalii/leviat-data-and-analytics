CREATE VIEW [edw].[vw_ProductValuationPUP]
AS
/*
    Since the prices are not filled for all periods, 
    the price values for the month are calculated according to the following rule: 
    if the price is indicated for the period, we take it
    if not, we take it for the nearest past period
*/
WITH Hash_Calc AS (
    SELECT 
        dim_PPUP.[ValuationTypeID],
        dim_PPUP.[ValuationAreaID],
        dim_PPUP.[ProductID],
        min(dim_PPUP.[FiscalPeriodDate]) 
            OVER ( PARTITION BY dim_PPUP.[ValuationTypeID], dim_PPUP.[ValuationAreaID], dim_PPUP.[ProductID]) AS [min_FiscalPeriodDate],
        FORMAT(dim_PPUP.[FiscalPeriodDate],'yyyy')  AS HDR_PostingDate_Year,
        FORMAT(dim_PPUP.[FiscalPeriodDate],'MM')    AS HDR_PostingDate_Month,
        dim_PPUP.[nk_dim_ProductValuationPUP]
    FROM
        [edw].[vw_StockPricePerUnit] dim_PPUP 
), Calendar_Calc AS (
    SELECT
        dimC.[CalendarYear],
        dimC.[CalendarMonth],
        dimC.[FirstDayOfMonthDate],
        HC.[ValuationTypeID],
        HC.[ValuationAreaID],
        HC.[ProductID],
        CONCAT_WS(
            '¦' ,
            HC.[ProductID],
            HC.[ValuationAreaID],
            HC.[ValuationTypeID],
            dimC.[CalendarYear] ,
            dimC.[CalendarMonth] 
        ) as  nk_dim_ProductValuationPUP
    FROM Hash_Calc HC
    CROSS JOIN [edw].[dim_Calendar] AS dimC
    WHERE
        dimC.[CalendarDate] >= DATEADD(DAY, 1, EOMONTH([min_FiscalPeriodDate],-1))
    AND
        dimC.[CalendarDate] <=  GETDATE()
    AND
        dimC.CalendarDay = '01'
    GROUP BY 
        dimC.[CalendarYear],
        dimC.[CalendarMonth],
        dimC.[FirstDayOfMonthDate],  
        HC.[ValuationTypeID],
        HC.[ValuationAreaID],
        HC.[ProductID]    
), Calendar_Total AS (
    SELECT
        CC.[nk_dim_ProductValuationPUP],
        CASE
            WHEN HC.[nk_dim_ProductValuationPUP] IS NOT NULL
            THEN
                HC.[nk_dim_ProductValuationPUP]
            ELSE
                (
                    SELECT TOP 1
                    dimPVs.[nk_dim_ProductValuationPUP] 
                    FROM [edw].[vw_StockPricePerUnit] dimPVs
                    WHERE  
                        dimPVs.[ValuationTypeID] = CC.[ValuationTypeID] 
                        AND
                        dimPVs.[ValuationAreaID] = CC.[ValuationAreaID]
                        AND
                        dimPVs.[ProductID] = CC.[ProductID]    
                        AND [FiscalPeriodDate] <=  CC.[FirstDayOfMonthDate]
                    ORDER BY dimPVs.[FiscalPeriodDate] DESC               
                )             
        END  AS [original_nk_dim_ProductValuationPUP],       
        CC.[CalendarYear],
        CC.[CalendarMonth],
        CC.[FirstDayOfMonthDate],
        CC.[ValuationTypeID],
        CC.[ValuationAreaID],
        CC.[ProductID],
        CASE
            WHEN HC.[nk_dim_ProductValuationPUP] IS NOT NULL 
            THEN NULL
            ELSE 1
        END                             AS isAddedMissingMonth 
    FROM Calendar_Calc CC    
    LEFT JOIN Hash_Calc HC 
        ON
            CC.[ValuationTypeID] = HC.[ValuationTypeID] 
        AND
            CC.[ValuationAreaID] = HC.[ValuationAreaID] 
        AND 
            CC.[ProductID] = HC.[ProductID]      
        AND
            CC.[CalendarYear] = HC.HDR_PostingDate_Year
        AND
            CC.[CalendarMonth] = HC.HDR_PostingDate_Month                      
)  
SELECT 
    CT.[nk_dim_ProductValuationPUP],         
    CT.[CalendarYear],
    CT.[CalendarMonth],
    CT.[FirstDayOfMonthDate],
    CT.[ProductID],
    CT.[ValuationAreaID],
    dimPVs.[ValuationArea],
    CT.[ValuationTypeID],
    dimPVs.[ValuationClassID],               
    dimPVs.[FiscalYearPeriod],               
    dimPVs.[FiscalMonthPeriod],              
    dimPVs.[FiscalPeriodDate],              
    dimPVs.[TotalValuatedStock],             
    dimPVs.[TotalValuatedStockValue],        
    dimPVs.[PriceControlIndicatorID],        
    dimPVs.[PriceControlIndicator],          
    dimPVs.[PeriodicUnitPrice],              
    dimPVs.[StandardPrice],                  
    dimPVs.[PriceUnit],                      
    dimPVs.[SAPTotalStockValuePUP],          
    dimPVs.[SAPTotalStockValueAtSalesPrice],
    dimPVs.[CurrencyID],                     
    dimPVs.[StockPricePerUnit],              
    dimPVs.[StockPricePerUnit_EUR],
    dimPVs.[StockPricePerUnit_USD],
    CT.isAddedMissingMonth,
    dimPVs.[t_applicationId],
    dimPVs.[t_extractionDtm]
FROM 
    Calendar_Total CT
LEFT JOIN 
    [edw].[vw_StockPricePerUnit] dimPVs
    ON 
        dimPVs.[nk_dim_ProductValuationPUP] = CT.[original_nk_dim_ProductValuationPUP]