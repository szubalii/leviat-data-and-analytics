CREATE VIEW [dm_sales].[vw_dim_ProductValuation]
	AS
    SELECT
        PV.[ProductID],
        PV.[ValuationAreaID],
        SO.[SalesOrganization] AS [ValuationArea],
        PV.[ValuationTypeID],
        VT.[ValuationType],
        PV.[ValuationClassID],
        VC.[ValuationClass],
        PV.[PriceDeterminationControlID],
        PV.[FiscalMonthCurrentPeriod],
        PV.[FiscalYearCurrentPeriod],
        PV.[StandardPrice],
        PV.[PriceUnitQuantity],
        PV.[StandardPricePerUnit],
        PV.[StandardPricePerUnit_EUR],
        PV.[InventoryValuationProcedure],
        PV.[MovingAveragePrice],
        PV.[MovingAvgPricePerUnit] AS [MovingAvgPricePPU],
        PV.[MovingAvgPricePerUnit_EUR],
        PV.[ValuationCategoryID],
        VCat.[ValuationCategory],
        PV.[ProdCostEstNumber],
        PV.[IsMarkedForDeletion],
        PV.[IsActiveEntity],
        PV.[CompanyCodeID],
        PV.[PriceLastChangeDate],
        PV.[CurrencyID]
    FROM
        [edw].[dim_ProductValuation] AS PV
    LEFT JOIN
        [edw].[dim_ValuationClass] AS VC
            ON
            VC.[ValuationClassID] = PV.[ValuationClassID]
    LEFT JOIN
        [edw].[dim_ValuationType] AS VT
            ON
            VT.[ValuationTypeID] = PV.[ValuationTypeID]
    LEFT JOIN
        [edw].[dim_ValuationCategory] AS VCat
            ON
            VCat.[ValuationCategoryID] = PV.[ValuationCategoryID]
    LEFT JOIN 
        [edw].[dim_SalesOrganization] AS SO      
            ON
            SO.[SalesOrganizationID] collate Latin1_General_100_BIN2 = PV.[ValuationAreaID]