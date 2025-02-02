CREATE VIEW [dm_sales].[vw_dim_ProductValuationPUP]
	AS
    SELECT 
       PV.[sk_dim_ProductValuationPUP], 
       PV.[nk_dim_ProductValuationPUP], 
       PV.[CalendarYear],
       PV.[CalendarMonth],
       PV.[ProductID],
       PV.[ValuationAreaID],
       PV.[ValuationArea],
       PV.[ValuationTypeID],
       VT.[ValuationType],
       PV.[ValuationClassID],
       VC.[ValuationClass],
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
       PV.[StockPricePerUnit],
       PV.[StockPricePerUnit_EUR],
       PV.[StockPricePerUnit_USD],
       PV.[isAddedMissingMonth]
    FROM [edw].[dim_ProductValuationPUP] AS PV
    LEFT JOIN
        [edw].[dim_ValuationClass] AS VC
            ON
            VC.[ValuationClassID] = PV.[ValuationClassID]
    LEFT JOIN
        [edw].[dim_ValuationType] AS VT
            ON
            VT.[ValuationTypeID] = PV.[ValuationTypeID] 
