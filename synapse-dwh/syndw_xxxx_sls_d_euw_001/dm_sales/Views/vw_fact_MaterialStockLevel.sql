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
        sum(viewMD.MatlStkChangeQtyInBaseUnit) AS MatlStkChangeQtyInBaseUnit,
        viewMD.[StockPricePerUnit],
        viewMD.[StockPricePerUnit_EUR],
        min(viewMD.HDR_PostingDate) minHDR_PostingDate,
        MONTH(viewMD.HDR_PostingDate) AS HDR_PostingDate_Month,
        YEAR(viewMD.HDR_PostingDate)  AS HDR_PostingDate_Year,
        HDR_PostingDate,
        [PriceControlIndicatorID],
        [PriceControlIndicator]
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
        MONTH(viewMD.HDR_PostingDate),
        YEAR(viewMD.HDR_PostingDate),
        HDR_PostingDate,
        [PriceControlIndicatorID],
        [PriceControlIndicator] 
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
        HC.[PriceControlIndicatorID],
        HC.[PriceControlIndicator] 
    FROM Hash_Calc HC
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
        HC.[PriceControlIndicatorID],
        HC.[PriceControlIndicator] 
), Calendar_TotalAmount AS (
    SELECT
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
        CASE -- if StockPricePerUnit Is NULL then needs to take the previous non-empty value
            WHEN 
               HC.[StockPricePerUnit] IS NULL
            THEN 
               (
                   SELECT TOP 1 [StockPricePerUnit]
                   FROM Hash_Calc
                   WHERE HDR_PostingDate <= CAST( CC.[CalendarYear] + '-' + CC.CalendarMonth + '-01' AS DATE)
                   AND _hash = CC._hash
                   AND [StockPricePerUnit] is not NULL
                   ORDER BY HDR_PostingDate DESC
               )
            ELSE     
                HC.[StockPricePerUnit]
        END AS [StockPricePerUnit],
        CASE -- if StockPricePerUnit_EUR Is NULL then needs to take the previous non-empty value
            WHEN 
               HC.[StockPricePerUnit_EUR] IS NULL
            THEN 
               (
                   SELECT TOP 1 [StockPricePerUnit_EUR]
                   FROM Hash_Calc
                   WHERE HDR_PostingDate <= CAST( CC.[CalendarYear] + '-' + CC.CalendarMonth + '-01' AS DATE)
                   AND _hash = CC._hash
                   AND [StockPricePerUnit] is not NULL                   
                   ORDER BY HDR_PostingDate DESC
               )
            ELSE     
                HC.[StockPricePerUnit_EUR]
        END AS [StockPricePerUnit_EUR],
        HC.[PriceControlIndicatorID],
        HC.[PriceControlIndicator] 
        FROM Calendar_Calc CC
        LEFT JOIN Hash_Calc HC
            ON
                CC._hash = HC._hash
            AND
                CC.[CalendarYear] = HC.HDR_PostingDate_Year
            AND
                CC.[CalendarMonth] = HC.HDR_PostingDate_Month
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
    [PriceControlIndicatorID],
    [PriceControlIndicator] 
FROM 
    Calendar_TotalAmount