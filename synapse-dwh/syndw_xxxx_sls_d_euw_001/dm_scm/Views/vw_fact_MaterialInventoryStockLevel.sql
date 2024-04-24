CREATE VIEW [dm_scm].[vw_fact_MaterialInventoryStockLevel]
AS
SELECT
  [MaterialID]
, [PlantID]
, [StorageLocationID]
, [InventorySpecialStockTypeID]
, [InventoryStockTypeID]
, [StockOwner]
, [CostCenterID]
, [CompanyCodeID]
, [SalesDocumentTypeID]
, [SalesDocumentItemCategoryID]
, [MaterialBaseUnitID]
, [PurchaseOrderTypeID]
, [InventoryValuationTypeID]
, [nk_StoragePlantID]
, [sk_ProductSalesOrg]
, [PlantSalesOrgID]
, NULL AS [nk_dim_ProductValuationPUP]
, NULL AS [sk_dim_ProductValuationPUP]
, [ReportingDate]
, [Year] AS [ReportingYear]
, [YearMonth] AS [ReportingMonth]
, [CalendarMonth]
, [YearWeek] AS [ReportingWeek]
, [CalendarWeek]
, [MaxPostingDate]
, [CurrencyID]
, [StockPricePerUnit]
, [StockPricePerUnit_EUR]
, [StockPricePerUnit_USD]
, [LatestStockPricePerUnit] AS LatestPricePerPiece_Local
, [LatestStockPricePerUnit_EUR] AS LatestPricePerPiece_EUR
, [LatestStockPricePerUnit_USD] AS LatestPricePerPiece_USD
, NULL AS [MatlStkChangeQtyInBaseUnit]
, [StockLevelQtyInBaseUnit]
, [StockLevelStandardPPU]
, [StockLevelStandardPPU_EUR]
, [StockLevelStandardPPU_USD]
, [StockLevelStandardLatestPPU] AS [StockLevelStandardLastPPU]
, [StockLevelStandardLatestPPU_EUR] AS [StockLevelStandardLastPPU_EUR]
, [StockLevelStandardLatestPPU_USD] AS [StockLevelStandardLastPPU_USD]
, NULL AS [PriceControlIndicatorID]
, NULL AS [PriceControlIndicator]
, [Rolling12MonthConsumptionQty] AS [Prev12MConsumptionQty]
, [ConsumptionQtyICPOInBaseUnit]
, [ConsumptionQtyICPOInStandardValue_EUR]
, [ConsumptionQtyICPOInStandardValue_USD]
, [ConsumptionQtyOBDProStandardValue]
, [ConsumptionQtyOBDProInBaseUnit]
, [ConsumptionQtyOBDProStandardValue_EUR]
, [ConsumptionQtyOBDProStandardValue_USD]
, [ConsumptionQtySOStandardValue]
, [ConsumptionQtySOInBaseUnit]
, [ConsumptionQtySOStandardValue_EUR]
, [ConsumptionQtySOStandardValue_USD]
, [ConsumptionQty]
, [ConsumptionValueByLatestPriceInBaseValue]
, [ConsumptionValueByLatestPrice_EUR]
, [ConsumptionValueByLatestPrice_USD]
, [t_applicationId]
, [t_extractionDtm]
FROM
  [edw].[fact_MaterialInventoryStockLevel]
