CREATE VIEW [edw].[vw_MaterialStockLevel]
AS

WITH Hash_Calc AS (
SELECT
        viewMD._hash,
        viewMD.[MaterialID],
        viewMD.[PlantID],
        viewMD.[StorageLocationID],
        viewMD.[InventorySpecialStockTypeID],
        viewMD.[InventoryStockTypeID],
        viewMD.[StockOwner],
        viewMD.[CostCenterID],
        viewMD.[CompanyCodeID],
        viewMD.[SalesDocumentTypeID],
        viewMD.[SalesDocumentItemCategoryID],
        viewMD.[MaterialBaseUnitID],
        viewMD.[PurchaseOrderTypeID],
        sum(viewMD.MatlStkChangeQtyInBaseUnit)   AS MatlStkChangeQtyInBaseUnit,
        viewMD.[StockPricePerUnit],
        viewMD.[StockPricePerUnit_EUR],
        viewMD.[StockPricePerUnit_USD],
        DATEADD(day, -(DAY(viewMD.[HDR_PostingDate])-1),viewMD.[HDR_PostingDate]) AS HDR_PostingDate_FMD,
        viewMD.[InventoryValuationTypeID]
    FROM [edw].[fact_MaterialDocumentItem] viewMD
    group by
        viewMD.[_hash],
        viewMD.[MaterialID],
        viewMD.[PlantID],
        viewMD.[StorageLocationID],
        viewMD.[InventorySpecialStockTypeID],
        viewMD.[InventoryStockTypeID],
        viewMD.[StockOwner],
        viewMD.[CostCenterID],
        viewMD.[CompanyCodeID],
        viewMD.[SalesDocumentTypeID],
        viewMD.[SalesDocumentItemCategoryID],
        viewMD.[MaterialBaseUnitID],
        viewMD.[PurchaseOrderTypeID],
        viewMD.[StockPricePerUnit],
        viewMD.[StockPricePerUnit_EUR],
        viewMD.[StockPricePerUnit_USD],
        DATEADD(day, -(DAY(viewMD.[HDR_PostingDate])-1),viewMD.[HDR_PostingDate]),
        viewMD.[InventoryValuationTypeID] 
), Hash_Calc_Min AS(
    SELECT
        _hash,
        max([MaterialID]) AS MaterialID,
        max([PlantID]) AS PlantID,
        max([StorageLocationID]) AS StorageLocationID,
        max([InventorySpecialStockTypeID]) AS InventorySpecialStockTypeID,
        max([InventoryStockTypeID]) AS InventoryStockTypeID,
        max([StockOwner]) AS StockOwner,
        max([CostCenterID]) AS CostCenterID,
        max([CompanyCodeID]) AS CompanyCodeID,
        max([SalesDocumentTypeID]) AS SalesDocumentTypeID,
        max([SalesDocumentItemCategoryID]) AS SalesDocumentItemCategoryID,
        max([MaterialBaseUnitID]) AS MaterialBaseUnitID,
        max([PurchaseOrderTypeID]) AS PurchaseOrderTypeID,
        max([InventoryValuationTypeID]) AS InventoryValuationTypeID,
        min([HDR_PostingDate_FMD]) AS minHDR_PostingDate       
    FROM Hash_Calc viewMD   
    GROUP BY _hash
), Calendar_Calc AS (
    Select
        _hash,
        dimC.[CalendarYear],
        dimC.[CalendarMonth],
        dimC.[LastDayOfMonthDate],
        dimC.[CalendarDate],
        HC.[MaterialID],
        HC.[PlantID],
        HC.[StorageLocationID],
        HC.[InventorySpecialStockTypeID],
        HC.[InventoryStockTypeID],
        HC.[StockOwner],
        HC.[CostCenterID],
        HC.[CompanyCodeID],
        HC.[SalesDocumentTypeID],
        HC.[SalesDocumentItemCategoryID],
        HC.[MaterialBaseUnitID],
        HC.[PurchaseOrderTypeID],
        HC.[InventoryValuationTypeID],
        HC.[minHDR_PostingDate]
    FROM Hash_Calc_Min HC
    CROSS JOIN [edw].[dim_Calendar] AS dimC
    WHERE dimC.[CalendarDate] BETWEEN minHDR_PostingDate AND GETDATE()
        AND dimC.CalendarDay = '01'
 /*   GROUP By _hash,
        dimC.[CalendarYear],
        dimC.[CalendarMonth],
        dimC.[LastDayOfMonthDate],
        HC.[MaterialID],
        HC.[PlantID],
        HC.[StorageLocationID],
        HC.[InventorySpecialStockTypeID],
        HC.[InventorySpecialStockTypeName],
        HC.[InventoryStockTypeID],
        HC.[InventoryStockTypeName],
        HC.[StockOwner],
        HC.[CostCenterID],
        HC.[CompanyCodeID],
        HC.[SalesDocumentTypeID],
        HC.[SalesDocumentType],
        HC.[SalesDocumentItemCategoryID],
        HC.[SalesDocumentItemCategory],
        HC.[MaterialBaseUnitID],
        HC.[PurchaseOrderTypeID],
        HC.[PurchaseOrderType],
        HC.[InventoryValuationTypeID] */
), Calendar_TotalAmount AS (
    SELECT
        CC._hash,
        CC.CalendarYear          AS ReportingYear,
        CC.CalendarMonth         AS ReportingMonth,
        CC.LastDayOfMonthDate    AS ReportingDate,
        CC.MaterialID,
        CC.PlantID,
        CC.StorageLocationID,
        CC.InventorySpecialStockTypeID,
        CC.InventoryStockTypeID,
        CC.StockOwner,
        CC.CostCenterID,
        CC.CompanyCodeID,
        CC.SalesDocumentTypeID,
        CC.SalesDocumentItemCategoryID,
        CC.MaterialBaseUnitID,
        CC.PurchaseOrderTypeID,
        HC.MatlStkChangeQtyInBaseUnit,
        SUM(ISNULL(HC.MatlStkChangeQtyInBaseUnit, 0))
            OVER (PARTITION BY CC._hash ORDER BY CC.CalendarYear, CC.CalendarMonth) AS StockLevelQtyInBaseUnit,
        CPPUP.[StockPricePerUnit]             AS [StockPricePerUnit],
        CPPUP.[StockPricePerUnit_EUR]         AS [StockPricePerUnit_EUR],
        CPPUP.[StockPricePerUnit_USD]         AS [StockPricePerUnit_USD],
        CPPUP.[PriceControlIndicatorID],
        CPPUP.[PriceControlIndicator], 
        CPPUP.[sk_dim_ProductValuationPUP]    AS [sk_dim_ProductValuationPUP],
        CPPUP.[nk_dim_ProductValuationPUP]    AS [nk_dim_ProductValuationPUP]
        FROM Calendar_Calc CC
        LEFT JOIN Hash_Calc HC
            ON
                CC._hash = HC._hash AND CC.CalendarDate=HC.HDR_PostingDate_FMD
        LEFT JOIN [edw].[dim_ProductValuationPUP]  CPPUP 
        ON             
            CPPUP.[ValuationTypeID] = CC.[InventoryValuationTypeID] COLLATE DATABASE_DEFAULT
            AND
            CPPUP.[ValuationAreaID] = CC.[PlantID] COLLATE DATABASE_DEFAULT
            AND
            CPPUP.[ProductID] = CC.[MaterialID]   COLLATE DATABASE_DEFAULT  
            AND 
            CPPUP.[CalendarYear] = CC.[CalendarYear] COLLATE DATABASE_DEFAULT
            AND
            CPPUP.[CalendarMonth] = CC.[CalendarMonth] COLLATE DATABASE_DEFAULT

)   SELECT 
    [_hash],
    [ReportingYear],
    [ReportingMonth],
    [ReportingDate],
    [MaterialID],
    [PlantID],
    [StorageLocationID],
    [InventorySpecialStockTypeID],
    [InventoryStockTypeID],
    [StockOwner],
    [CostCenterID],
    [CompanyCodeID],
    [SalesDocumentTypeID],
    [SalesDocumentItemCategoryID],
    [MaterialBaseUnitID],
    [PurchaseOrderTypeID],
    [MatlStkChangeQtyInBaseUnit],
    [StockLevelQtyInBaseUnit],
    [StockLevelQtyInBaseUnit] * [StockPricePerUnit]     AS StockLevelStandardPPU,
    [StockLevelQtyInBaseUnit] * [StockPricePerUnit_EUR] AS StockLevelStandardPPU_EUR,
    [StockLevelQtyInBaseUnit] * [StockPricePerUnit_USD] AS StockLevelStandardPPU_USD,
    [PriceControlIndicatorID],
    [PriceControlIndicator],
    [nk_dim_ProductValuationPUP],
    [sk_dim_ProductValuationPUP]  
FROM 
    Calendar_TotalAmount