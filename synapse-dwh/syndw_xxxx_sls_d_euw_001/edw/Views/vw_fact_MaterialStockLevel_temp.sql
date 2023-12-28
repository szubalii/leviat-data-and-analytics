CREATE VIEW [edw].[vw_fact_MaterialStockLevel_temp]
  AS 

WITH Hash_Calc AS (
    SELECT
        CONVERT(NVARCHAR(32),
            HashBytes('SHA2_256',
            isNull(CAST(viewMD.[MaterialID] AS VARCHAR) , '')  +
            isNull(CAST(viewMD.[PlantID] AS VARCHAR) , '') +
            isNull(CAST(viewMD.[StorageLocationID] AS VARCHAR) , '')  +
            isNull(CAST(viewMD.[InventorySpecialStockTypeID] AS VARCHAR) , '') +
            isNull(CAST(viewMD.[InventoryStockTypeID] AS VARCHAR) , '') +
            isNull(CAST(viewMD.[StockOwner] AS VARCHAR) , '') +
            isNull(CAST(viewMD.[CostCenterID] AS VARCHAR) , '')  +
            isNull(CAST(viewMD.[CompanyCodeID] AS VARCHAR) , '') +
            isNull(CAST(viewMD.[SalesDocumentTypeID] AS VARCHAR) , '')  +
            isNull(CAST(viewMD.[SalesDocumentItemCategoryID] AS VARCHAR) , '')  +
            isNull(CAST(viewMD.[MaterialBaseUnitID] AS VARCHAR) , '') +
            isNull(CAST(viewMD.[PurchaseOrderTypeID] AS VARCHAR) , '')
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
        FORMAT(viewMD.[HDR_PostingDate],'yyyy')  AS HDR_PostingDate_Year,
        FORMAT(viewMD.[HDR_PostingDate],'MM')    AS HDR_PostingDate_Month,
        EOMONTH(CAST(FORMAT(viewMD.[HDR_PostingDate],'yyyy-MM') + '-01' AS DATE)) AS HDR_PostingDate_LMD,
        viewMD.[nk_dim_ProductValuationPUP],
        viewMD.[InventoryValuationTypeID]
    FROM [edw].[fact_MaterialDocumentItem_temp] viewMD
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
        FORMAT(viewMD.[HDR_PostingDate],'yyyy'),
        FORMAT(viewMD.[HDR_PostingDate],'MM'),
        EOMONTH(CAST(FORMAT(viewMD.[HDR_PostingDate],'yyyy-MM') + '-01' AS DATE)),
        viewMD.[nk_dim_ProductValuationPUP],
        viewMD.[InventoryValuationTypeID] 
), Hash_Calc_Min AS(
    SELECT
        _hash,
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
        [InventoryValuationTypeID],
        min([HDR_PostingDate_LMD]) over(PARTITION BY _hash) AS minHDR_PostingDate       
    FROM Hash_Calc viewMD   
), Calendar_Calc AS (
    Select
        _hash,
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
        HC.[InventoryValuationTypeID]    
    FROM Hash_Calc_Min HC
    CROSS JOIN [edw].[dim_Calendar] AS dimC
    WHERE
        dimC.[CalendarDate] >= DATEADD(DAY, 1, EOMONTH(minHDR_PostingDate,-1))
    AND
        dimC.[CalendarDate] <=  GETDATE()
    AND
        dimC.CalendarDay = '01'
    GROUP By _hash,
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
        HC.[InventoryValuationTypeID] 
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
                CC._hash = HC._hash
            AND
                CC.[CalendarYear] = HC.HDR_PostingDate_Year
            AND
                CC.[CalendarMonth] = HC.HDR_PostingDate_Month
        LEFT JOIN [edw].[dim_ProductValuationPUP]  CPPUP 
        ON             
            CPPUP.[ValuationTypeID] = CC.[InventoryValuationTypeID]
            AND
            CPPUP.[ValuationAreaID] = CC.[PlantID] 
            AND
            CPPUP.[ProductID] = CC.[MaterialID]      
            AND 
            CPPUP.[CalendarYear] = CC.[CalendarYear] 
            AND
            CPPUP.[CalendarMonth] = CC.[CalendarMonth] 

)   SELECT 
    _hash,
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
