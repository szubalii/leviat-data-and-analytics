create VIEW [dm_sales].[vw_fact_MaterialStockLevel]
AS
SELECT
    [ReportingYear],
    [ReportingMonth],
    [ReportingDate],
    [MaterialID],
    [PlantID],
    [StorageLocationID],
    CONVERT(NVARCHAR(32),
            HashBytes('SHA2_256',
                  isNull(CAST([StorageLocationID] COLLATE DATABASE_DEFAULT AS VARCHAR) , '') +
			            isNull(CAST([PlantID] COLLATE DATABASE_DEFAULT AS VARCHAR) , '') 
            )
        , 2)  as StoragePlantID,
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
    [Prev12MConsumptionQty],
    [StockLevelStandardPPU],
    [StockLevelStandardPPU_EUR],
    [StockLevelStandardPPU_USD],
    [StockLevelStandardLastPPU],     
    [StockLevelStandardLastPPU_EUR], 
    [StockLevelStandardLastPPU_USD],
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
    [CurrencyID],
    [t_applicationId],
  	[t_extractionDtm]
FROM 
    [edw].[fact_MaterialStockLevel]