CREATE VIEW [edw].[vw_MaterialStockLevel]
AS

WITH Hash_Calc AS (
SELECT
        viewMD._hash,
        viewMD.[MaterialID],
        viewMD.[PlantID],
        viewMD.[StorageLocationID],
        viewMD.[axbi_DataAreaID],
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
        viewMD.[InventoryValuationTypeID],
        viewMD.[LatestPricePerPiece_Local],  
        viewMD.[LatestPricePerPiece_EUR],    
        viewMD.[LatestPricePerPiece_USD],   
        viewMD.t_applicationId,
        viewMD.t_extractionDtm
    FROM [edw].[fact_MaterialDocumentItem] viewMD
    group by
        viewMD.[_hash],
        viewMD.[MaterialID],
        viewMD.[PlantID],
        viewMD.[StorageLocationID],
        viewMD.[axbi_DataAreaID],
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
        viewMD.[InventoryValuationTypeID],
        viewMD.[LatestPricePerPiece_Local],  
        viewMD.[LatestPricePerPiece_EUR],    
        viewMD.[LatestPricePerPiece_USD],   
        viewMD.t_applicationId,
        viewMD.t_extractionDtm 
), Hash_Calc_Min AS(
    SELECT
        _hash,
        max([MaterialID]) AS MaterialID,
        max([PlantID]) AS PlantID,
        max([StorageLocationID]) AS StorageLocationID,
        max(axbi_DataAreaID) AS axbi_DataAreaID,
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
        max(viewMD.[LatestPricePerPiece_Local]) AS LatestPricePerPiece_Local,  
        max(viewMD.[LatestPricePerPiece_EUR]) AS LatestPricePerPiece_EUR,    
        max(viewMD.[LatestPricePerPiece_USD]) AS LatestPricePerPiece_USD,   
        max(t_applicationId) AS t_applicationId,
        max(t_extractionDtm) AS t_extractionDtm,
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
        HC.[axbi_DataAreaID],
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
        HC.[minHDR_PostingDate],
        HC.[LatestPricePerPiece_Local], 
        HC.[LatestPricePerPiece_EUR],   
        HC.[LatestPricePerPiece_USD],   
        HC.[t_applicationId],
        HC.[t_extractionDtm]
    FROM Hash_Calc_Min HC
    CROSS JOIN [edw].[dim_Calendar] AS dimC
    WHERE dimC.[CalendarDate] BETWEEN minHDR_PostingDate AND GETDATE()
        AND dimC.CalendarDay = '01'
), Calendar_TotalAmount AS (
    SELECT
        CC._hash,
        CC.CalendarYear          AS ReportingYear,
        CC.CalendarMonth         AS ReportingMonth,
        CC.LastDayOfMonthDate    AS ReportingDate,
        CC.MaterialID,
        CC.PlantID,
        CC.StorageLocationID,
        CC.axbi_DataAreaID,
        CC.InventorySpecialStockTypeID,
        CC.InventoryStockTypeID,
        CC.StockOwner,
        CC.CostCenterID,
        CC.CompanyCodeID,
        CC.SalesDocumentTypeID,
        CC.SalesDocumentItemCategoryID,
        CC.MaterialBaseUnitID,
        CC.PurchaseOrderTypeID,
        CC.[LatestPricePerPiece_Local], 
        CC.[LatestPricePerPiece_EUR],   
        CC.[LatestPricePerPiece_USD],   
        HC.MatlStkChangeQtyInBaseUnit,
        CASE
            WHEN CC.LastDayOfMonthDate > AXM.MigrationDate THEN 0
            ELSE
                SUM(ISNULL(HC.MatlStkChangeQtyInBaseUnit, 0))
                OVER (PARTITION BY CC._hash ORDER BY CC.CalendarYear, CC.CalendarMonth)
        END AS StockLevelQtyInBaseUnit,
        CPPUP.[StockPricePerUnit]             AS [StockPricePerUnit],
        CPPUP.[StockPricePerUnit_EUR]         AS [StockPricePerUnit_EUR],
        CPPUP.[StockPricePerUnit_USD]         AS [StockPricePerUnit_USD],
        CPPUP.[PriceControlIndicatorID],
        CPPUP.[PriceControlIndicator], 
        CPPUP.[sk_dim_ProductValuationPUP]    AS [sk_dim_ProductValuationPUP],
        CPPUP.[nk_dim_ProductValuationPUP]    AS [nk_dim_ProductValuationPUP],
        CC.t_applicationId,
        CC.t_extractionDtm
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
        LEFT JOIN [map_AXBI].[Migration] AXM
        ON
            CC.axbi_DataAreaID = AXM.DataAreaID

)   SELECT 
    [_hash],
    [ReportingYear],
    [ReportingMonth],
    [ReportingDate],
    [MaterialID],
    [PlantID],
    [StorageLocationID],
    [axbi_DataAreaID],
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
    [StockLevelQtyInBaseUnit] * [LatestPricePerPiece_Local]     AS StockLevelStandardLastPPU,
    [StockLevelQtyInBaseUnit] * [LatestPricePerPiece_EUR] AS StockLevelStandardLastPPU_EUR,
    [StockLevelQtyInBaseUnit] * [LatestPricePerPiece_USD] AS StockLevelStandardLastPPU_USD,
    [StockPricePerUnit],    
    [StockPricePerUnit_EUR],
    [StockPricePerUnit_USD],
    [LatestPricePerPiece_Local],
    [LatestPricePerPiece_EUR],
    [LatestPricePerPiece_USD],
    [PriceControlIndicatorID],
    [PriceControlIndicator],
    [nk_dim_ProductValuationPUP],
    [sk_dim_ProductValuationPUP],
    [t_applicationId],
    [t_extractionDtm]
FROM 
    Calendar_TotalAmount