CREATE VIEW [dm_sales].[vw_fact_MaterialStockLevel]
AS

WITH Hash_Calc AS (
SELECT
        CONVERT(NVARCHAR(32),
            HashBytes('SHA2_256',
            isNull(CAST(viewMD.[MaterialID] AS VARCHAR) COLLATE Latin1_General_100_BIN2, '')  +
            isNull(CAST(viewMD.[PlantID] AS VARCHAR) COLLATE Latin1_General_100_BIN2, '') +
            isNull(CAST(viewMD.[StorageLocationID] AS VARCHAR) COLLATE Latin1_General_100_BIN2, '')  +
            isNull(CAST(viewMD.[InventorySpecialStockTypeID] AS VARCHAR) COLLATE Latin1_General_100_BIN2, '') +
            isNull(CAST(viewMD.[InventoryStockTypeID] AS VARCHAR) COLLATE Latin1_General_100_BIN2, '') +
            isNull(CAST(viewMD.[StockOwner] AS VARCHAR) COLLATE Latin1_General_100_BIN2, '') +
            isNull(CAST(viewMD.[CostCenterID] AS VARCHAR) COLLATE Latin1_General_100_BIN2, '')  +
            isNull(CAST(viewMD.[CompanyCodeID] AS VARCHAR) COLLATE Latin1_General_100_BIN2, '') +
            isNull(CAST(viewMD.[SalesDocumentTypeID] AS VARCHAR) COLLATE Latin1_General_100_BIN2, '')  +
            isNull(CAST(viewMD.[SalesDocumentItemCategoryID] AS VARCHAR) COLLATE Latin1_General_100_BIN2, '')  +
            isNull(CAST(viewMD.[MaterialBaseUnitID] AS VARCHAR) COLLATE Latin1_General_100_BIN2, '') +
            isNull(CAST(viewMD.[PurchaseOrderTypeID] AS VARCHAR) COLLATE Latin1_General_100_BIN2, '')
            )
        , 2)  _hash,
        viewMD.[MaterialID],
        viewMD.[PlantID],
        viewMD.[StorageLocationID],
        viewMD.[InventorySpecialStockTypeID],
        viewMD.[InventorySpecialStockTypeName],
        viewMD.[InventoryStockTypeID],
        viewMD.[InventoryStockTypeName],
        viewMD.[StockOwner],
        viewMD.[CostCenterID],
        viewMD.[CompanyCodeID],
        viewMD.[SalesDocumentTypeID],
        viewMD.[SalesDocumentType],
        viewMD.[SalesDocumentItemCategoryID],
        viewMD.[SalesDocumentItemCategory],
        viewMD.[MaterialBaseUnitID],
        viewMD.[PurchaseOrderTypeID],
        viewMD.[PurchaseOrderType],
        sum(viewMD.MatlStkChangeQtyInBaseUnit)   AS MatlStkChangeQtyInBaseUnit,
        viewMD.[StockPricePerUnit],
        viewMD.[StockPricePerUnit_EUR],
        viewMD.[StockPricePerUnit_USD],
        DATEADD(day, -(DAY(viewMD.[HDR_PostingDate])-1),viewMD.[HDR_PostingDate]) AS HDR_PostingDate_FMD,
        viewMD.[InventoryValuationTypeID]
    FROM [dm_sales].[vw_fact_MaterialDocumentItem] viewMD
    group by
        viewMD.[MaterialID],
        viewMD.[PlantID],
        viewMD.[StorageLocationID],
        viewMD.[InventorySpecialStockTypeID],
        viewMD.[InventorySpecialStockTypeName],
        viewMD.[InventoryStockTypeID],
        viewMD.[InventoryStockTypeName],
        viewMD.[StockOwner],
        viewMD.[CostCenterID],
        viewMD.[CompanyCodeID],
        viewMD.[SalesDocumentTypeID],
        viewMD.[SalesDocumentType],
        viewMD.[SalesDocumentItemCategoryID],
        viewMD.[SalesDocumentItemCategory],
        viewMD.[MaterialBaseUnitID],
        viewMD.[PurchaseOrderTypeID],
        viewMD.[PurchaseOrderType],
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
        max([InventorySpecialStockTypeName]) AS InventorySpecialStockTypeName,
        max([InventoryStockTypeID]) AS InventoryStockTypeID,
        max([InventoryStockTypeName]) AS InventoryStockTypeName,
        max([StockOwner]) AS StockOwner,
        max([CostCenterID]) AS CostCenterID,
        max([CompanyCodeID]) AS CompanyCodeID,
        max([SalesDocumentTypeID]) AS SalesDocumentTypeID,
        max([SalesDocumentType]) AS SalesDocumentType,
        max([SalesDocumentItemCategoryID]) AS SalesDocumentItemCategoryID,
        max([SalesDocumentItemCategory]) AS SalesDocumentItemCategory,
        max([MaterialBaseUnitID]) AS MaterialBaseUnitID,
        max([PurchaseOrderTypeID]) AS PurchaseOrderTypeID,
        max([PurchaseOrderType]) AS PurchaseOrderType,
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
        CC.InventorySpecialStockTypeName,
        CC.InventoryStockTypeID,
        CC.InventoryStockTypeName,
        CC.StockOwner,
        CC.CostCenterID,
        CC.CompanyCodeID,
        CC.SalesDocumentTypeID,
        CC.SalesDocumentType,
        CC.SalesDocumentItemCategoryID,
        CC.SalesDocumentItemCategory,
        CC.MaterialBaseUnitID,
        CC.PurchaseOrderTypeID,
        CC.PurchaseOrderType,
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
            CPPUP.[ValuationTypeID] = CC.[InventoryValuationTypeID] 
            AND
            CPPUP.[ValuationAreaID] = CC.[PlantID]
            AND
            CPPUP.[ProductID] = CC.[MaterialID]     
            AND 
            CPPUP.[CalendarYear] = CC.[CalendarYear] COLLATE Latin1_General_100_BIN2
            AND
            CPPUP.[CalendarMonth] = CC.[CalendarMonth] COLLATE Latin1_General_100_BIN2

)   SELECT 
    [ReportingYear],
    [ReportingMonth],
    [ReportingDate],
    [MaterialID],
    [PlantID],
    [StorageLocationID],
    [InventorySpecialStockTypeID],
    [InventorySpecialStockTypeName],
    [InventoryStockTypeID],
    [InventoryStockTypeName],
    [StockOwner],
    [CostCenterID],
    [CompanyCodeID],
    [SalesDocumentTypeID],
    [SalesDocumentType],
    [SalesDocumentItemCategoryID],
    [SalesDocumentItemCategory],
    [MaterialBaseUnitID],
    [PurchaseOrderTypeID],
    [PurchaseOrderType],
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