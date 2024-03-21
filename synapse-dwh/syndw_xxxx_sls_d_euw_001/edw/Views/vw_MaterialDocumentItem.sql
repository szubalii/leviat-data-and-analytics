CREATE VIEW [edw].[vw_MaterialDocumentItem]
	AS 
WITH LastPPU AS (
    SELECT 
        ValuationTypeID
    ,   ValuationAreaID
    ,   ProductID
    ,   FirstDayOfMonthDate
    ,   StockPricePerUnit
    ,   StockPricePerUnit_EUR
    ,   StockPricePerUnit_USD 
    FROM (
        SELECT 
            ValuationTypeID
        ,   ValuationAreaID
        ,   ProductID
        ,   FirstDayOfMonthDate
        ,   StockPricePerUnit
        ,   StockPricePerUnit_EUR
        ,   StockPricePerUnit_USD 
        ,   row_number() OVER ( PARTITION BY ValuationTypeID,
                                            ValuationAreaID,
                                            ProductID 
                                ORDER BY FirstDayOfMonthDate DESC
            ) as rn
        FROM  [edw].[dim_ProductValuationPUP]
    ) a WHERE rn=1
)
SELECT  CONVERT(NVARCHAR(32),
            HashBytes('SHA2_256',
            isNull(CAST(UV.[MaterialID] COLLATE DATABASE_DEFAULT AS VARCHAR) , '')  +
            isNull(CAST(UV.[PlantID] COLLATE DATABASE_DEFAULT AS VARCHAR) , '') +
            isNull(CAST(UV.[StorageLocationID] COLLATE DATABASE_DEFAULT AS VARCHAR) , '')  +
            isNull(CAST(UV.[InventorySpecialStockTypeID] COLLATE DATABASE_DEFAULT AS VARCHAR) , '') +
            isNull(CAST(UV.[InventoryStockTypeID] COLLATE DATABASE_DEFAULT AS VARCHAR) , '') +
            isNull(CAST(UV.[StockOwner] COLLATE DATABASE_DEFAULT AS VARCHAR) , '') +
            isNull(CAST(UV.[CostCenterID] COLLATE DATABASE_DEFAULT AS VARCHAR) , '')  +
            isNull(CAST(UV.[CompanyCodeID] COLLATE DATABASE_DEFAULT AS VARCHAR) , '') +
            isNull(CAST(UV.[SalesDocumentTypeID] COLLATE DATABASE_DEFAULT AS VARCHAR) , '')  +
            isNull(CAST(UV.[SalesDocumentItemCategoryID] COLLATE DATABASE_DEFAULT AS VARCHAR) , '')  +
            isNull(CAST(UV.[MaterialBaseUnitID] COLLATE DATABASE_DEFAULT AS VARCHAR) , '') +
            isNull(CAST(UV.[PurchaseOrderTypeID] COLLATE DATABASE_DEFAULT AS VARCHAR) , '')
            )
        , 2)  _hash
    ,   UV.[nk_StoragePlantID]
    ,   UV.[MaterialDocumentYear] 
    ,   UV.[MaterialDocument] COLLATE DATABASE_DEFAULT          AS MaterialDocument
    ,   UV.[MaterialDocumentItem]
    ,   UV.[MaterialID] COLLATE DATABASE_DEFAULT                AS MaterialID
    ,   UV.[PlantID] COLLATE DATABASE_DEFAULT                   AS PlantID
    ,   UV.[StorageLocationID] COLLATE DATABASE_DEFAULT         AS StorageLocationID
    ,   UV.[axbi_DataAreaID]
    ,   UV.[StorageTypeID]
    ,   UV.[StorageBin] 
    ,   UV.[Batch] 
    ,   UV.[ShelfLifeExpirationDate] 
    ,   UV.[ManufactureDate] 
    ,   UV.[SupplierID]
    ,   UV.[SalesOrder] COLLATE DATABASE_DEFAULT                AS SalesOrder
    ,   UV.[SalesOrderItem] COLLATE DATABASE_DEFAULT            AS SalesOrderItem
    ,   UV.[SalesOrderScheduleLine] 
    ,   UV.[WBSElementInternalID] 
    ,   UV.[CustomerID]
    ,   UV.[InventorySpecialStockTypeID]
    ,   UV.[InventoryStockTypeID]       
    ,   UV.[StockOwner]                 
    ,   UV.[GoodsMovementTypeID]
    ,   UV.[DebitCreditCode] 
    ,   UV.[InventoryUsabilityCode] 
    ,   UV.[QuantityInBaseUnit] 
    ,   UV.[MaterialBaseUnitID] COLLATE DATABASE_DEFAULT        AS MaterialBaseUnitID
    ,   UV.[QuantityInEntryUnit] 
    ,   UV.[EntryUnitID]
    ,   UV.[HDR_PostingDate]
    ,   UV.[DocumentDate] 
    ,   UV.[TotalGoodsMvtAmtInCCCrcy] 
    ,   UV.[CompanyCodeCurrency]  COLLATE DATABASE_DEFAULT      AS CompanyCodeCurrency
    ,   UV.[InventoryValuationTypeID]
    ,   UV.[ReservationIsFinallyIssued]
    ,   UV.[PurchaseOrder] COLLATE DATABASE_DEFAULT             AS PurchaseOrder
    ,   UV.[PurchaseOrderItem] COLLATE DATABASE_DEFAULT         AS PurchaseOrderItem
    ,   UV.[ProjectNetwork] 
    ,   UV.[Order]                 COLLATE DATABASE_DEFAULT     AS [Order]
    ,   UV.[OrderItem]             COLLATE DATABASE_DEFAULT     AS OrderItem
    ,   UV.[SalesDocumentItemCategoryID]
    ,   UV.[SalesDocumentItemCategory]
    ,   UV.[Reservation]
    ,   UV.[ReservationItem]
    ,   UV.[DeliveryDocument]
    ,   UV.[DeliveryDocumentItem] 
    ,   UV.[ReversedMaterialDocumentYear]
    ,   UV.[ReversedMaterialDocument] 
    ,   UV.[ReversedMaterialDocumentItem] 
    ,   UV.[RvslOfGoodsReceiptIsAllowed] 
    ,   UV.[GoodsRecipientName] 
    ,   UV.[UnloadingPointName] 
    ,   UV.[CostCenterID]
    ,   UV.[GLAccountID]
    ,   UV.[ServicePerformer]
    ,   UV.[EmploymentInternalID] 
    ,   UV.[AccountAssignmentCategory] 
    ,   UV.[WorkItem] 
    ,   UV.[ServicesRenderedDate] 
    ,   UV.[IssgOrRcvgMaterial] 
    ,   UV.[CompanyCodeID]
    ,   UV.[GoodsMovementRefDocTypeID]
    ,   UV.[IsAutomaticallyCreated]
    ,   UV.[IsCompletelyDelivered]
    ,   UV.[IssuingOrReceivingPlantID]
    ,   UV.[IssuingOrReceivingStorageLocID]
    ,   UV.[BusinessAreaID]
    ,   UV.[ControllingAreaID]
    ,   UV.[FiscalYearPeriod]
    ,   UV.[FiscalYearVariant]
    ,   UV.[IssgOrRcvgBatch]
    ,   UV.[IssgOrRcvgSpclStockInd]
    ,   UV.[MaterialDocumentItemText]
    ,   UV.[CurrencyTypeID]
    ,   UV.[HDR_AccountingDocumentTypeID]
    ,   UV.[HDR_InventoryTransactionTypeID]
    ,   UV.[HDR_CreatedByUser]
    ,   UV.[HDR_CreationDate]
    ,   UV.[HDR_CreationTime]
    ,   UV.[HDR_MaterialDocumentHeaderText]
    ,   UV.[HDR_ReferenceDocument]
    ,   UV.[HDR_BillOfLading]
    ,   UV.[MatlStkChangeQtyInBaseUnit]
    ,   UV.[ConsumptionQtyICPOInBaseUnit]
    ,   UV.[ConsumptionQtyOBDProInBaseUnit]
    ,   UV.[ConsumptionQtySOInBaseUnit]
    ,   UV.[MatlCnsmpnQtyInMatlBaseUnit]
    ,   UV.[GoodsReceiptQtyInOrderUnit]
    ,   UV.[GoodsMovementIsCancelled]
    ,   UV.[GoodsMovementCancellationType]
    ,   UV.[ConsumptionPosting]
    ,   UV.[ManufacturingOrder] COLLATE DATABASE_DEFAULT        AS ManufacturingOrder
    ,   UV.[ManufacturingOrderItem] COLLATE DATABASE_DEFAULT    AS ManufacturingOrderItem
    ,   UV.[IsReversalMovementType]
    ,   UV.[nk_dim_ProductValuationPUP]
    ,   UV.[StockPricePerUnit]
    ,   UV.[StockPricePerUnit_EUR]
    ,   UV.[StockPricePerUnit_USD]
    ,   UV.[SalesDocumentTypeID]
    ,   UV.[SalesDocumentType] 
    ,   UV.[PurchaseOrderTypeID] 
    ,   UV.[PurchaseOrderType]
    ,   UV.[HDR_DeliveryDocumentTypeID]
    ,   UV.[GoodsMovementTypeName]
    ,   UV.[MatlStkChangeStandardValue]
    ,   UV.[MatlStkChangeStandardValue_EUR]
    ,   UV.[MatlStkChangeStandardValue_USD]
    ,   UV.[ConsumptionQtyICPOInStandardValue]
    ,   UV.[ConsumptionQtyICPOInStandardValue_EUR]
    ,   UV.[ConsumptionQtyICPOInStandardValue_USD]
    ,   UV.[QuantityInBaseUnitStandardValue]
    ,   UV.[QuantityInBaseUnitStandardValue_EUR]
    ,   UV.[QuantityInBaseUnitStandardValue_USD]
    ,   UV.[ConsumptionQtyOBDProInBaseUnit] * UV.[StockPricePerUnit]         AS ConsumptionQtyOBDProStandardValue
    ,   UV.[ConsumptionQtyOBDProInBaseUnit] * UV.[StockPricePerUnit_EUR]     AS ConsumptionQtyOBDProStandardValue_EUR
    ,   UV.[ConsumptionQtyOBDProInBaseUnit] * UV.[StockPricePerUnit_USD]     AS ConsumptionQtyOBDProStandardValue_USD
    ,   UV.[ConsumptionQtySOInBaseUnit] * UV.[StockPricePerUnit]             AS ConsumptionQtySOStandardValue
    ,   UV.[ConsumptionQtySOInBaseUnit] * UV.[StockPricePerUnit_EUR]         AS ConsumptionQtySOStandardValue_EUR
    ,   UV.[ConsumptionQtySOInBaseUnit] * UV.[StockPricePerUnit_USD]         AS ConsumptionQtySOStandardValue_USD
    ,   UV.[InventorySpecialStockTypeName]
    ,   UV.[InventoryStockTypeName]
    ,   UV.[PriceControlIndicatorID] 
    ,   UV.[PriceControlIndicator]  
    ,   UV.[StandardPricePerUnit]
    ,   UV.[StandardPricePerUnit_EUR] 
    ,   UV.[StandardPricePerUnit_USD]
    ,   COALESCE(UV.[ConsumptionQtyOBDProInBaseUnit],0) 
        + COALESCE(UV.[ConsumptionQtySOInBaseUnit],0) 
        + COALESCE(UV.[ConsumptionQtyICPOInBaseUnit],0)                     AS ConsumptionQty
    ,   LastPPU.[StockPricePerUnit]                                         AS LatestPricePerPiece_Local
    ,   LastPPU.[StockPricePerUnit_EUR]                                     AS LatestPricePerPiece_EUR
    ,   LastPPU.[StockPricePerUnit_USD]                                     AS LatestPricePerPiece_USD
    ,   ( COALESCE(UV.[ConsumptionQtyOBDProInBaseUnit],0) 
        + COALESCE(UV.[ConsumptionQtySOInBaseUnit],0) 
        + COALESCE(UV.[ConsumptionQtyICPOInBaseUnit],0))
        * LastPPU.[StockPricePerUnit]                                       AS ConsumptionValueByLatestPriceInBaseValue
    ,   ( COALESCE(UV.[ConsumptionQtyOBDProInBaseUnit],0) 
        + COALESCE(UV.[ConsumptionQtySOInBaseUnit],0) 
        + COALESCE(UV.[ConsumptionQtyICPOInBaseUnit],0))
        * LastPPU.[StockPricePerUnit_EUR]                                   AS ConsumptionValueByLatestPrice_EUR                                                                            
    ,   ( COALESCE(UV.[ConsumptionQtyOBDProInBaseUnit],0) 
        + COALESCE(UV.[ConsumptionQtySOInBaseUnit],0) 
        + COALESCE(UV.[ConsumptionQtyICPOInBaseUnit],0))
        * LastPPU.[StockPricePerUnit_USD]                                   AS ConsumptionValueByLatestPrice_USD 
    ,   P.SalesOrganization                                                 AS PlantSalesOrgID
    ,   PSD.sk_ProductSalesDelivery                                         AS sk_ProductSalesOrg
    ,   UV.[MaterialDocumentRecordType]
    ,   UV.[t_applicationId]
    ,   UV.[t_extractionDtm]
    FROM
(
    SELECT  
            edw.svf_get2PartNaturalKey (S4H.StorageLocationID,S4H.PlantID) AS [nk_StoragePlantID]
        ,   S4H.[MaterialDocumentYear] 
        ,   S4H.[MaterialDocument]
        ,   S4H.[MaterialDocumentItem]
        ,   S4H.[MaterialID]
        ,   S4H.[PlantID]
        ,   S4H.[StorageLocationID]
        ,   null AS axbi_DataAreaID
        ,   S4H.[StorageTypeID]
        ,   S4H.[StorageBin] 
        ,   S4H.[Batch] 
        ,   S4H.[ShelfLifeExpirationDate] 
        ,   S4H.[ManufactureDate] 
        ,   S4H.[SupplierID]
        ,   S4H.[SalesOrder]
        ,   S4H.[SalesOrderItem] 
        ,   S4H.[SalesOrderScheduleLine] 
        ,   S4H.[WBSElementInternalID] 
        ,   S4H.[CustomerID]
        ,   S4H.[InventorySpecialStockTypeID]
        ,   S4H.[InventoryStockTypeID]       
        ,   S4H.[StockOwner]                 
        ,   S4H.[GoodsMovementTypeID]
        ,   S4H.[DebitCreditCode] 
        ,   S4H.[InventoryUsabilityCode] 
        ,   S4H.[QuantityInBaseUnit] 
        ,   S4H.[MaterialBaseUnitID]
        ,   S4H.[QuantityInEntryUnit] 
        ,   S4H.[EntryUnitID]
        ,   S4H.[HDR_PostingDate]
        ,   S4H.[DocumentDate] 
        ,   S4H.[TotalGoodsMvtAmtInCCCrcy] 
        ,   S4H.[CompanyCodeCurrency] 
        ,   S4H.[InventoryValuationTypeID]
        ,   S4H.[ReservationIsFinallyIssued]
        ,   S4H.[PurchaseOrder] 
        ,   S4H.[PurchaseOrderItem] 
        ,   S4H.[ProjectNetwork] 
        ,   S4H.[Order]                      
        ,   S4H.[OrderItem] 
        ,   S4H.[SalesDocumentItemCategoryID]
        ,   S4H.[SalesDocumentItemCategory]
        ,   S4H.[Reservation]
        ,   S4H.[ReservationItem]
        ,   S4H.[DeliveryDocument]
        ,   S4H.[DeliveryDocumentItem] 
        ,   S4H.[ReversedMaterialDocumentYear]
        ,   S4H.[ReversedMaterialDocument] 
        ,   S4H.[ReversedMaterialDocumentItem] 
        ,   S4H.[RvslOfGoodsReceiptIsAllowed] 
        ,   S4H.[GoodsRecipientName] 
        ,   S4H.[UnloadingPointName] 
        ,   S4H.[CostCenterID]
        ,   S4H.[GLAccountID]
        ,   S4H.[ServicePerformer]
        ,   S4H.[EmploymentInternalID] 
        ,   S4H.[AccountAssignmentCategory] 
        ,   S4H.[WorkItem] 
        ,   S4H.[ServicesRenderedDate] 
        ,   S4H.[IssgOrRcvgMaterial] 
        ,   S4H.[CompanyCodeID]
        ,   S4H.[GoodsMovementRefDocTypeID]
        ,   S4H.[IsAutomaticallyCreated]
        ,   S4H.[IsCompletelyDelivered]
        ,   S4H.[IssuingOrReceivingPlantID]
        ,   S4H.[IssuingOrReceivingStorageLocID]
        ,   S4H.[BusinessAreaID]
        ,   S4H.[ControllingAreaID]
        ,   S4H.[FiscalYearPeriod]
        ,   S4H.[FiscalYearVariant]
        ,   S4H.[IssgOrRcvgBatch]
        ,   S4H.[IssgOrRcvgSpclStockInd]
        ,   S4H.[MaterialDocumentItemText]
        ,   S4H.[CurrencyTypeID]
        ,   S4H.[HDR_AccountingDocumentTypeID]
        ,   S4H.[HDR_InventoryTransactionTypeID]
        ,   S4H.[HDR_CreatedByUser]
        ,   S4H.[HDR_CreationDate]
        ,   S4H.[HDR_CreationTime]
        ,   S4H.[HDR_MaterialDocumentHeaderText]
        ,   S4H.[HDR_ReferenceDocument]
        ,   S4H.[HDR_BillOfLading]
        ,   S4H.[MatlStkChangeQtyInBaseUnit]
        ,   S4H.[ConsumptionQtyICPOInBaseUnit]
        ,   S4H.[ConsumptionQtyOBDProInBaseUnit]
        ,   S4H.[ConsumptionQtySOInBaseUnit]
        ,   S4H.[MatlCnsmpnQtyInMatlBaseUnit]
        ,   S4H.[GoodsReceiptQtyInOrderUnit]
        ,   S4H.[GoodsMovementIsCancelled]
        ,   S4H.[GoodsMovementCancellationType]
        ,   S4H.[ConsumptionPosting]
        ,   S4H.[ManufacturingOrder]
        ,   S4H.[ManufacturingOrderItem]
        ,   S4H.[IsReversalMovementType]
        ,   S4H.[nk_dim_ProductValuationPUP]
        ,   S4H.[StockPricePerUnit]
        ,   S4H.[StockPricePerUnit_EUR]
        ,   S4H.[StockPricePerUnit_USD]
        ,   S4H.[SalesDocumentTypeID]
        ,   S4H.[SalesDocumentType] 
        ,   S4H.[PurchaseOrderTypeID]
        ,   S4H.[PurchaseOrderType]
        ,   S4H.[HDR_DeliveryDocumentTypeID]
        ,   S4H.[GoodsMovementTypeName]
        ,   S4H.[MatlStkChangeStandardValue]
        ,   S4H.[MatlStkChangeStandardValue_EUR]
        ,   S4H.[MatlStkChangeStandardValue_USD]
        ,   S4H.[ConsumptionQtyICPOInStandardValue]
        ,   S4H.[ConsumptionQtyICPOInStandardValue_EUR]
        ,   S4H.[ConsumptionQtyICPOInStandardValue_USD]
        ,   S4H.[QuantityInBaseUnitStandardValue]
        ,   S4H.[QuantityInBaseUnitStandardValue_EUR]
        ,   S4H.[QuantityInBaseUnitStandardValue_USD]
        ,   S4H.[InventorySpecialStockTypeName]
        ,   S4H.[InventoryStockTypeName]
        ,   S4H.[PriceControlIndicatorID] 
        ,   S4H.[PriceControlIndicator]   
        ,   null AS [StandardPricePerUnit]
        ,   null AS [StandardPricePerUnit_EUR] 
        ,   null AS [StandardPricePerUnit_USD]
        ,   S4H.[MaterialDocumentRecordType]
        ,   S4H.[t_applicationId]
        ,   S4H.[t_extractionDtm]
    FROM [edw].[vw_MaterialDocumentItem_s4h] S4H

        UNION ALL

    SELECT  
            edw.svf_get2PartNaturalKey (AXBI.StorageLocationID,AXBI.PlantID) AS [nk_StoragePlantID]
        ,   AXBI.[MaterialDocumentYear]                         
        ,   AXBI.[MaterialDocument]
        ,   AXBI.[MaterialDocumentItem]
        ,   AXBI.[MaterialID]
        ,   AXBI.[PlantID]
        ,   AXBI.[StorageLocationID]
        ,   AXBI.[axbi_DataAreaID]
        ,   null AS [StorageTypeID]
        ,   null AS [StorageBin] 
        ,   null AS [Batch] 
        ,   null AS [ShelfLifeExpirationDate] 
        ,   null AS [ManufactureDate] 
        ,   null AS [SupplierID]
        ,   AXBI.[SalesOrder]
        ,   AXBI.[SalesOrderItem]
        ,   null AS [SalesOrderScheduleLine] 
        ,   null AS [WBSElementInternalID] 
        ,   null AS [CustomerID]
        ,   null AS [InventorySpecialStockTypeID]
        ,   null AS [InventoryStockTypeID]       
        ,   null AS [StockOwner] 
        ,   AXBI.[GoodsMovementTypeID]
        ,   null AS [DebitCreditCode] 
        ,   null AS [InventoryUsabilityCode] 
        ,   null AS [QuantityInBaseUnit] 
        ,   AXBI.[MaterialBaseUnitID]
        ,   null AS [QuantityInEntryUnit] 
        ,   null AS [EntryUnitID]
        ,   AXBI.[HDR_PostingDate]
        ,   AXBI.[DocumentDate]
        ,   null AS [TotalGoodsMvtAmtInCCCrcy]
        ,   AXBI.[CompanyCodeCurrency]
        ,   null AS [InventoryValuationTypeID]
        ,   null AS [ReservationIsFinallyIssued]
        ,   AXBI.[PurchaseOrder]
        ,   AXBI.[PurchaseOrderItem]
        ,   null AS [ProjectNetwork] 
        ,   AXBI.[Order]
        ,   AXBI.[OrderItem]
        ,   AXBI.[SalesDocumentItemCategoryID]
        ,   AXBI.[SalesDocumentItemCategory]
        ,   null AS [Reservation]
        ,   null AS [ReservationItem]
        ,   null AS [DeliveryDocument]
        ,   null AS [DeliveryDocumentItem] 
        ,   null AS [ReversedMaterialDocumentYear]
        ,   null AS [ReversedMaterialDocument] 
        ,   null AS [ReversedMaterialDocumentItem] 
        ,   null AS [RvslOfGoodsReceiptIsAllowed] 
        ,   null AS [GoodsRecipientName] 
        ,   null AS [UnloadingPointName] 
        ,   null AS [CostCenterID]
        ,   null AS [GLAccountID]
        ,   null AS [ServicePerformer]
        ,   null AS [EmploymentInternalID] 
        ,   null AS [AccountAssignmentCategory] 
        ,   null AS [WorkItem] 
        ,   null AS [ServicesRenderedDate] 
        ,   null AS [IssgOrRcvgMaterial] 
        ,   null AS [CompanyCodeID]
        ,   null AS [GoodsMovementRefDocTypeID]
        ,   null AS [IsAutomaticallyCreated]
        ,   null AS [IsCompletelyDelivered]
        ,   null AS [IssuingOrReceivingPlantID]
        ,   null AS [IssuingOrReceivingStorageLocID]
        ,   null AS [BusinessAreaID]
        ,   null AS [ControllingAreaID]
        ,   null AS [FiscalYearPeriod]
        ,   null AS [FiscalYearVariant]
        ,   null AS [IssgOrRcvgBatch]
        ,   null AS [IssgOrRcvgSpclStockInd]
        ,   null AS [MaterialDocumentItemText]
        ,   AXBI.[CurrencyTypeID]
        ,   null AS [HDR_AccountingDocumentTypeID]
        ,   null AS [HDR_InventoryTransactionTypeID]
        ,   null AS [HDR_CreatedByUser]
        ,   null AS [HDR_CreationDate]
        ,   null AS [HDR_CreationTime]
        ,   null AS [HDR_MaterialDocumentHeaderText]
        ,   null AS [HDR_ReferenceDocument]
        ,   null AS [HDR_BillOfLading]
        ,   AXBI.[MatlStkChangeQtyInBaseUnit]
        ,   AXBI.[ConsumptionQtyICPOInBaseUnit]
        ,   AXBI.[ConsumptionQtyOBDProInBaseUnit]
        ,   AXBI.[ConsumptionQtySOInBaseUnit]
        ,   AXBI.[MatlCnsmpnQtyInMatlBaseUnit]
        ,   null AS [GoodsReceiptQtyInOrderUnit]
        ,   null AS [GoodsMovementIsCancelled]
        ,   null AS [GoodsMovementCancellationType]
        ,   null AS [ConsumptionPosting]
        ,   AXBI.[ManufacturingOrder]
        ,   AXBI.[ManufacturingOrderItem]
        ,   null AS [IsReversalMovementType]
        ,   null AS [nk_dim_ProductValuationPUP]
        ,   AXBI.[StandardPricePerUnit] AS [StockPricePerUnit]
        ,   AXBI.[StandardPricePerUnit_EUR] AS [StockPricePerUnit_EUR]
        ,   null AS [StockPricePerUnit_USD]
        ,   null AS [SalesDocumentTypeID]
        ,   null AS [SalesDocumentType] 
        ,   null AS [PurchaseOrderTypeID]
        ,   null AS [PurchaseOrderType]
        ,   null AS [HDR_DeliveryDocumentTypeID]
        ,   null AS [GoodsMovementTypeName]
        ,   AXBI.[MatlStkChangeQtyInBaseUnit] * AXBI.[StandardPricePerUnit]         AS [MatlStkChangeStandardValue]
        ,   AXBI.[MatlStkChangeQtyInBaseUnit] * AXBI.[StandardPricePerUnit_EUR]     AS [MatlStkChangeStandardValue_EUR]
        ,   null AS [MatlStkChangeStandardValue_USD]
        ,   AXBI.[ConsumptionQtyICPOInBaseUnit] * AXBI.[StandardPricePerUnit]       AS [ConsumptionQtyICPOInStandardValue]
        ,   AXBI.[ConsumptionQtyICPOInBaseUnit] * AXBI.[StandardPricePerUnit_EUR]   AS [ConsumptionQtyICPOInStandardValue_EUR]
        ,   null AS [ConsumptionQtyICPOInStandardValue_USD]
        ,   null AS [QuantityInBaseUnitStandardValue]
        ,   null AS [QuantityInBaseUnitStandardValue_EUR]
        ,   null AS [QuantityInBaseUnitStandardValue_USD]
        ,   null AS [InventorySpecialStockTypeName]
        ,   null AS [InventoryStockTypeName]
        ,   null AS [PriceControlIndicatorID] 
        ,   null AS [PriceControlIndicator]  
        ,   AXBI.[StandardPricePerUnit]
        ,   AXBI.[StandardPricePerUnit_EUR] 
        ,   null AS [StandardPricePerUnit_USD]
        ,   null AS [MaterialDocumentRecordType]
        ,   AXBI.[t_applicationId]
        ,   AXBI.[t_extractionDtm]
    FROM [edw].[vw_MaterialDocumentItem_axbi] AXBI
) UV
LEFT JOIN 
    LastPPU
    ON  
        UV.[InventoryValuationTypeID] =  LastPPU.[ValuationTypeID]      COLLATE DATABASE_DEFAULT
    AND
        UV.[PlantID] = LastPPU.[ValuationAreaID]                        COLLATE DATABASE_DEFAULT
    AND
        UV.[MaterialID] = LastPPU.[ProductID]                           COLLATE DATABASE_DEFAULT
LEFT JOIN
    [edw].[dim_Plant] P
    ON
        UV.PlantID = P.PlantID
LEFT JOIN
    [edw].[dim_ProductSalesDelivery] PSD
    ON
        UV.MaterialID = PSD.ProductID
    AND
        P.SalesOrganization = PSD.SalesOrganizationID
    AND
        PSD.DistributionChannel = 10