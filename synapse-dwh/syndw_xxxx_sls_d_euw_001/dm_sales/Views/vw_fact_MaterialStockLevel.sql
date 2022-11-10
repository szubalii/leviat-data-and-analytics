create VIEW [dm_sales].[vw_fact_MaterialStockLevel]
AS
SELECT
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
    [StockLevelStandardPPU],
    [StockLevelStandardPPU_EUR],
    [StockLevelStandardPPU_USD],
    [PriceControlIndicatorID],
    [PriceControlIndicator],
    [nk_dim_ProductValuationPUP],
    [sk_dim_ProductValuationPUP],
    [t_applicationId],
  	[t_extractionDtm]   
FROM 
    [edw].[fact_MaterialStockLevel]