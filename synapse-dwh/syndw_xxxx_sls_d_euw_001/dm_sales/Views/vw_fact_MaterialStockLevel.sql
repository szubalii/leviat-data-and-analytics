CREATE VIEW [dm_sales].[vw_fact_MaterialStockLevel]
AS
SELECT 
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
    [edw].[fact_MaterialStockLevel]