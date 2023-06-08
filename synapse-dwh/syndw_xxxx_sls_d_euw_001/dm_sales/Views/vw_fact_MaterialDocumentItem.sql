﻿CREATE VIEW [dm_sales].[vw_fact_MaterialDocumentItem] AS
SELECT  MDI.[MaterialDocumentYear] 
    ,   MDI.[MaterialDocument] COLLATE DATABASE_DEFAULT          AS MaterialDocument
    ,   MDI.[MaterialDocumentItem]
    ,   MDI.[MaterialID] COLLATE DATABASE_DEFAULT                AS MaterialID
    ,   MDI.[PlantID] COLLATE DATABASE_DEFAULT                   AS PlantID
    ,   MDI.[StorageLocationID] COLLATE DATABASE_DEFAULT         AS StorageLocationID
    ,   CONVERT(NVARCHAR(32),
            HashBytes('SHA2_256',
                  isNull(CAST([StorageLocationID] COLLATE DATABASE_DEFAULT AS VARCHAR) , '') +
			      isNull(CAST([PlantID] COLLATE DATABASE_DEFAULT AS VARCHAR) , '') 
            )
        , 2)  as StoragePlantID
    ,   MDI.[StorageTypeID]
    ,   MDI.[StorageBin] 
    ,   MDI.[Batch] 
    ,   MDI.[ShelfLifeExpirationDate] 
    ,   MDI.[ManufactureDate] 
    ,   MDI.[SupplierID]
    ,   MDI.[SalesOrder] COLLATE DATABASE_DEFAULT                AS SalesOrder
    ,   MDI.[SalesOrderItem] COLLATE DATABASE_DEFAULT            AS SalesOrderItem
    ,   MDI.[SalesOrderScheduleLine] 
    ,   MDI.[WBSElementInternalID] 
    ,   MDI.[CustomerID]
    ,   MDI.[InventorySpecialStockTypeID]
    ,   MDI.[InventoryStockTypeID]       
    ,   MDI.[StockOwner]                 
    ,   MDI.[GoodsMovementTypeID]
    ,   MDI.[DebitCreditCode] 
    ,   MDI.[InventoryUsabilityCode] 
    ,   MDI.[QuantityInBaseUnit] 
    ,   MDI.[MaterialBaseUnitID] COLLATE DATABASE_DEFAULT        AS MaterialBaseUnitID
    ,   MDI.[QuantityInEntryUnit] 
    ,   MDI.[EntryUnitID]
    ,   MDI.[HDR_PostingDate]
    ,   MDI.[DocumentDate] 
    ,   MDI.[TotalGoodsMvtAmtInCCCrcy] 
    ,   MDI.[CompanyCodeCurrency]  COLLATE DATABASE_DEFAULT      AS CompanyCodeCurrency
    ,   MDI.[InventoryValuationTypeID]
    ,   MDI.[ReservationIsFinallyIssued]
    ,   MDI.[PurchaseOrder] COLLATE DATABASE_DEFAULT             AS PurchaseOrder
    ,   MDI.[PurchaseOrderItem] COLLATE DATABASE_DEFAULT         AS PurchaseOrderItem
    ,   MDI.[ProjectNetwork] 
    ,   MDI.[Order]                 COLLATE DATABASE_DEFAULT     AS [Order]
    ,   MDI.[OrderItem]             COLLATE DATABASE_DEFAULT     AS OrderItem
    ,   MDI.[SalesDocumentItemCategoryID]
    ,   MDI.[SalesDocumentItemCategory]
    ,   MDI.[Reservation]
    ,   MDI.[ReservationItem]
    ,   MDI.[DeliveryDocument]
    ,   MDI.[DeliveryDocumentItem] 
    ,   MDI.[ReversedMaterialDocumentYear]
    ,   MDI.[ReversedMaterialDocument] 
    ,   MDI.[ReversedMaterialDocumentItem] 
    ,   MDI.[RvslOfGoodsReceiptIsAllowed] 
    ,   MDI.[GoodsRecipientName] 
    ,   MDI.[UnloadingPointName] 
    ,   MDI.[CostCenterID]
    ,   MDI.[GLAccountID]
    ,   MDI.[ServicePerformer]
    ,   MDI.[EmploymentInternalID] 
    ,   MDI.[AccountAssignmentCategory] 
    ,   MDI.[WorkItem] 
    ,   MDI.[ServicesRenderedDate] 
    ,   MDI.[IssgOrRcvgMaterial] 
    ,   MDI.[CompanyCodeID]
    ,   MDI.[GoodsMovementRefDocTypeID]
    ,   MDI.[IsAutomaticallyCreated]
    ,   MDI.[IsCompletelyDelivered]
    ,   MDI.[IssuingOrReceivingPlantID]
    ,   MDI.[IssuingOrReceivingStorageLocID]
    ,   MDI.[BusinessAreaID]
    ,   MDI.[ControllingAreaID]
    ,   MDI.[FiscalYearPeriod]
    ,   MDI.[FiscalYearVariant]
    ,   MDI.[IssgOrRcvgBatch]
    ,   MDI.[IssgOrRcvgSpclStockInd]
    ,   MDI.[MaterialDocumentItemText]
    ,   MDI.[CurrencyTypeID]
    ,   MDI.[HDR_AccountingDocumentTypeID]
    ,   MDI.[HDR_InventoryTransactionTypeID]
    ,   MDI.[HDR_CreatedByUser]
    ,   MDI.[HDR_CreationDate]
    ,   MDI.[HDR_CreationTime]
    ,   MDI.[HDR_MaterialDocumentHeaderText]
    ,   MDI.[HDR_ReferenceDocument]
    ,   MDI.[HDR_BillOfLading]
    ,   MDI.[MatlStkChangeQtyInBaseUnit]
    ,   MDI.[ConsumptionQtyICPOInBaseUnit]
    ,   MDI.[ConsumptionQtyOBDProInBaseUnit]
    ,   MDI.[ConsumptionQtySOInBaseUnit]
    ,   MDI.[MatlCnsmpnQtyInMatlBaseUnit]
    ,   MDI.[GoodsReceiptQtyInOrderUnit]
    ,   MDI.[GoodsMovementIsCancelled]
    ,   MDI.[GoodsMovementCancellationType]
    ,   MDI.[ConsumptionPosting]
    ,   MDI.[ManufacturingOrder] COLLATE DATABASE_DEFAULT        AS ManufacturingOrder
    ,   MDI.[ManufacturingOrderItem] COLLATE DATABASE_DEFAULT    AS ManufacturingOrderItem
    ,   MDI.[IsReversalMovementType]
    ,   MDI.[nk_dim_ProductValuationPUP]
    ,   MDI.[StockPricePerUnit]
    ,   MDI.[StockPricePerUnit_EUR]
    ,   MDI.[StockPricePerUnit_USD]
    ,   MDI.[SalesDocumentTypeID]
    ,   MDI.[SalesDocumentType] 
    ,   MDI.[PurchaseOrderTypeID] 
    ,   MDI.[PurchaseOrderType]
    ,   MDI.[HDR_DeliveryDocumentTypeID]
    ,   MDI.[GoodsMovementTypeName]
    ,   MDI.[MatlStkChangeStandardValue]
    ,   MDI.[MatlStkChangeStandardValue_EUR]
    ,   MDI.[MatlStkChangeStandardValue_USD]
    ,   MDI.[ConsumptionQtyICPOInStandardValue]
    ,   MDI.[ConsumptionQtyICPOInStandardValue_EUR]
    ,   MDI.[ConsumptionQtyICPOInStandardValue_USD]
    ,   MDI.[QuantityInBaseUnitStandardValue]
    ,   MDI.[QuantityInBaseUnitStandardValue_EUR]
    ,   MDI.[QuantityInBaseUnitStandardValue_USD]
    ,   MDI.[ConsumptionQtyOBDProStandardValue]
    ,   MDI.[ConsumptionQtyOBDProStandardValue_EUR]
    ,   MDI.[ConsumptionQtyOBDProStandardValue_USD]
    ,   MDI.[ConsumptionQtySOStandardValue]
    ,   MDI.[ConsumptionQtySOStandardValue_EUR]
    ,   MDI.[ConsumptionQtySOStandardValue_USD]
    ,   CASE WHEN ISNULL(MDI.[PurchaseOrder],'') <>'' AND MDI.[PurchaseOrderTypeID] = 'STO' 
            THEN  MDI.[MatlStkChangeQtyInBaseUnit]
            ELSE NULL
        END                                                                        AS [ConsumptionQtySTOInBaseUnit]
    ,   MDI.[InventorySpecialStockTypeName]
    ,   MDI.[InventoryStockTypeName] 
    ,   MDI.[PriceControlIndicatorID]
    ,   MDI.[PriceControlIndicator]  
    ,   MDI.[StandardPricePerUnit]    
    ,   MDI.[StandardPricePerUnit_EUR]
    ,   MDI.[StandardPricePerUnit_USD]
    ,   MDI.[ConsumptionQty]                          
    ,   MDI.[LatestPricePerPiece_Local]               
    ,   MDI.[LatestPricePerPiece_EUR]                 
    ,   MDI.[LatestPricePerPiece_USD]                 
    ,   MDI.[ConsumptionValueByLatestPriceInBaseValue]
    ,   MDI.[ConsumptionValueByLatestPrice_EUR]       
    ,   MDI.[ConsumptionValueByLatestPrice_USD]       
    ,   MDI.[t_applicationId]
    ,   MDI.[t_extractionDtm]
FROM
    [edw].[fact_MaterialDocumentItem] MDI;


/* -- 10.11.2022  US 2191
WITH MDI_UNION AS(
SELECT 
      MDI.[MaterialDocumentYear]
    , MDI.[MaterialDocument]
    , MDI.[MaterialDocumentItem]
    , MDI.[MaterialID]
    , MDI.[PlantID]
    , MDI.[StorageLocationID]
    , MDI.[StorageTypeID]
    , MDI.[StorageBin]
    , MDI.[Batch]
    , MDI.[ShelfLifeExpirationDate]
    , MDI.[ManufactureDate]
    , MDI.[SupplierID]
    , MDI.[SalesOrder]
    , MDI.[SalesOrderItem]
    , MDI.[SalesOrderScheduleLine]
    , MDI.[WBSElementInternalID]
    , MDI.[CustomerID]
    , MDI.[InventorySpecialStockTypeID]
    , dimISST.[InventorySpecialStockTypeName]
    , MDI.[InventoryStockTypeID]
    , dimIST.[InventoryStockTypeName]
    , MDI.[StockOwner]
    , MDI.[GoodsMovementTypeID]
    , dimGMT.[GoodsMovementTypeName] COLLATE Latin1_General_100_BIN2 as GoodsMovementTypeName
    , MDI.[DebitCreditCode]
    , MDI.[InventoryUsabilityCode]
    , MDI.[QuantityInBaseUnit]
    , MDI.[MaterialBaseUnitID]
    , MDI.[QuantityInEntryUnit]
    , MDI.[EntryUnitID]
    , MDI.[HDR_PostingDate]
    , MDI.[DocumentDate]
    , MDI.[TotalGoodsMvtAmtInCCCrcy]
    , MDI.[CompanyCodeCurrency]
    , MDI.[InventoryValuationTypeID]
    , MDI.[ReservationIsFinallyIssued]
    , MDI.[PurchaseOrder]
    , MDI.[PurchaseOrderItem]
    , MDI.[ProjectNetwork]
    , MDI.[Order]
    , MDI.[OrderItem]
    , MDI.[Reservation]
    , MDI.[ReservationItem]
    , MDI.[DeliveryDocument]
    , MDI.[DeliveryDocumentItem]
    , MDI.[ReversedMaterialDocumentYear]
    , MDI.[ReversedMaterialDocument]
    , MDI.[ReversedMaterialDocumentItem]
    , MDI.[RvslOfGoodsReceiptIsAllowed]
    , MDI.[GoodsRecipientName]
    , MDI.[UnloadingPointName]
    , MDI.[CostCenterID]
    , MDI.[GLAccountID]
    , MDI.[ServicePerformer]
    , MDI.[EmploymentInternalID]
    , MDI.[AccountAssignmentCategory]
    , MDI.[WorkItem]
    , MDI.[ServicesRenderedDate]
    , MDI.[IssgOrRcvgMaterial]
    , MDI.[CompanyCodeID]
    , MDI.[GoodsMovementRefDocTypeID]
    , MDI.[IsAutomaticallyCreated]
    , MDI.[IsCompletelyDelivered]
    , MDI.[IssuingOrReceivingPlantID]
    , MDI.[IssuingOrReceivingStorageLocID]
    , MDI.[BusinessAreaID]
    , MDI.[ControllingAreaID]
    , MDI.[FiscalYearPeriod]
    , MDI.[FiscalYearVariant]
    , MDI.[IssgOrRcvgBatch]
    , MDI.[IssgOrRcvgSpclStockInd]
    , MDI.[MaterialDocumentItemText]
    , MDI.[CurrencyTypeID]
    , MDI.[HDR_AccountingDocumentTypeID]
    , MDI.[HDR_InventoryTransactionTypeID]
    , MDI.[HDR_CreatedByUser]
    , MDI.[HDR_CreationDate]
    , MDI.[HDR_CreationTime]
    , MDI.[HDR_MaterialDocumentHeaderText]
    , MDI.[HDR_ReferenceDocument]
    , MDI.[HDR_BillOfLading]
    , SDT.[SalesDocumentTypeID]
    , SDT.[SalesDocumentType] 
    , dimSDIC.[SalesDocumentItemCategoryID] 
    , dimSDIC.[SalesDocumentItemCategory]
    , dimDel.[DeliveryDocumentType]                     AS [HDR_DeliveryDocumentTypeID]
    , MDI.[MatlStkChangeQtyInBaseUnit]
    , MDI.[ConsumptionQtyICPOInBaseUnit]     
    , MDI.[ConsumptionQtyOBDProInBaseUnit]
    , MDI.[ConsumptionQtySOInBaseUnit]
    , MDI.[MatlCnsmpnQtyInMatlBaseUnit]
    , MDI.[GoodsReceiptQtyInOrderUnit]
    , MDI.[GoodsMovementIsCancelled]
    , MDI.[GoodsMovementCancellationType]
    , MDI.[ConsumptionPosting]
    , MDI.[ManufacturingOrder]
    , MDI.[ManufacturingOrderItem]
    , MDI.[IsReversalMovementType]
    , dimPVs.[nk_dim_ProductValuationPUP]                                      AS [nk_dim_ProductValuationPUP]
    , dimPVs.[StockPricePerUnit]
    , dimPVs.[StockPricePerUnit_EUR]
    , dimPVs.[StockPricePerUnit_USD]
    , MDI.[ConsumptionQtyICPOInBaseUnit] * dimPVs.[StockPricePerUnit]           AS ConsumptionQtyICPOInStandardValue
    , MDI.[ConsumptionQtyICPOInBaseUnit] * dimPVs.[StockPricePerUnit_EUR]       AS ConsumptionQtyICPOInStandardValue_EUR
    , MDI.[ConsumptionQtyICPOInBaseUnit] * dimPVs.[StockPricePerUnit_USD]       AS ConsumptionQtyICPOInStandardValue_USD
    , MDI.[ConsumptionQtyOBDProInBaseUnit] * dimPVs.[StockPricePerUnit]         AS ConsumptionQtyOBDProStandardValue
    , MDI.[ConsumptionQtyOBDProInBaseUnit] * dimPVs.[StockPricePerUnit_EUR]     AS ConsumptionQtyOBDProStandardValue_EUR
    , MDI.[ConsumptionQtyOBDProInBaseUnit] * dimPVs.[StockPricePerUnit_USD]     AS ConsumptionQtyOBDProStandardValue_USD
    , MDI.[ConsumptionQtySOInBaseUnit] * dimPVs.[StockPricePerUnit]             AS ConsumptionQtySOStandardValue
    , MDI.[ConsumptionQtySOInBaseUnit] * dimPVs.[StockPricePerUnit_EUR]         AS ConsumptionQtySOStandardValue_EUR
    , MDI.[ConsumptionQtySOInBaseUnit] * dimPVs.[StockPricePerUnit_USD]         AS ConsumptionQtySOStandardValue_USD
    , MDI.[MatlStkChangeQtyInBaseUnit] * dimPVs.[StockPricePerUnit]             AS MatlStkChangeStandardValue
    , MDI.[MatlStkChangeQtyInBaseUnit] * dimPVs.[StockPricePerUnit_EUR]         AS MatlStkChangeStandardValue_EUR
    , MDI.[MatlStkChangeQtyInBaseUnit] * dimPVs.[StockPricePerUnit_USD]         AS MatlStkChangeStandardValue_USD
    , MDI.[QuantityInBaseUnit] * dimPVs.[StockPricePerUnit]                     AS QuantityInBaseUnitStandardValue
    , MDI.[QuantityInBaseUnit] * dimPVs.[StockPricePerUnit_EUR]                 AS QuantityInBaseUnitStandardValue_EUR
    , MDI.[QuantityInBaseUnit] * dimPVs.[StockPricePerUnit_USD]                 AS QuantityInBaseUnitStandardValue_USD
    , NULL AS [StandardPricePerUnit]
    , NULL AS [StandardPricePerUnit_EUR]
    -- fields PriceControlIndicatorID, PriceControlIndicator are being used in [vw_fact_MaterialStockLevel] 
    , dimPVs.[PriceControlIndicatorID]
    , dimPVs.[PriceControlIndicator]
    , MDI.[t_applicationId]
    , MDI.[t_extractionDtm]
    FROM [edw].[fact_MaterialDocumentItem] MDI
    LEFT JOIN 
        [edw].[fact_SalesDocumentItem] SDI
            ON MDI.[SalesOrder] = SDI.[SalesDocument] collate Latin1_General_100_BIN2
                AND
                MDI.[SalesOrderItem] = SDI.[SalesDocumentItem]
                AND
                SDI.[CurrencyTypeID] = 10
    LEFT JOIN 
        [edw].[dim_SalesDocumentType] SDT
            ON SDI.[SalesDocumentTypeID] = SDT.[SalesDocumentTypeID]
    LEFT JOIN
        [edw].[dim_InventorySpecialStockType] dimISST
            ON  dimISST.[InventorySpecialStockTypeID] = MDI.[InventorySpecialStockTypeID]
    LEFT JOIN
        [edw].[dim_InventoryStockType] dimIST
            ON dimIST.[InventoryStockTypeID] = MDI.[InventoryStockTypeID]      
    LEFT JOIN 
        [edw].[dim_DeliveryDocument] dimDel 
            ON dimDel.DeliveryDocumentID = MDI.[HDR_ReferenceDocument]     
    LEFT JOIN 
        [edw].[dim_SalesDocumentItemCategory] dimSDIC
            ON SDI.[SalesDocumentItemCategoryID] = dimSDIC.[SalesDocumentItemCategoryID]

    LEFT JOIN 
        [edw].[dim_ProductValuationPUP] dimPVs
            ON  
                dimPVs.[ValuationTypeID] =  MDI.[InventoryValuationTypeID] 
                AND
                dimPVs.[ValuationAreaID] = MDI.[PlantID]
                AND
                dimPVs.[ProductID] = MDI.[MaterialID]    
                AND 
                dimPVs.[CalendarYear] =  FORMAT(MDI.[HDR_PostingDate],'yyyy')
                AND
                dimPVs.[CalendarMonth] = FORMAT(MDI.[HDR_PostingDate],'MM')
    LEFT JOIN
        [edw].[dim_GoodsMovementType] dimGMT
            ON 
                dimGMT.GoodsMovementTypeID = MDI.[GoodsMovementTypeID]
    
    UNION ALL
    
    SELECT 
      MDI_axbi.[MaterialDocumentYear]
    , MDI_axbi.[MaterialDocument]
    , MDI_axbi.[MaterialDocumentItem]
    , MDI_axbi.[MaterialID]
    , MDI_axbi.[PlantID]
    , MDI_axbi.[StorageLocationID]
    , NULL AS [StorageTypeID]
    , NULL AS [StorageBin]
    , NULL AS [Batch]
    , NULL AS [ShelfLifeExpirationDate]
    , NULL AS [ManufactureDate]
    , NULL AS [SupplierID]
    , MDI_axbi.[SalesOrder]
    , MDI_axbi.[SalesOrderItem]
    , NULL AS [SalesOrderScheduleLine]
    , NULL AS [WBSElementInternalID]
    , NULL AS [CustomerID]
    , NULL AS [InventorySpecialStockTypeID]
    , NULL AS [InventorySpecialStockTypeName]
    , NULL AS [InventoryStockTypeID]
    , NULL AS [InventoryStockTypeName]
    , NULL AS [StockOwner]
    , MDI_axbi.[GoodsMovementTypeID]
    , MDI_axbi.[GoodsMovementTypeName]
    , NULL AS [DebitCreditCode]
    , NULL AS [InventoryUsabilityCode]
    , NULL AS [QuantityInBaseUnit]
    , MDI_axbi.[MaterialBaseUnitID]
    , NULL AS [QuantityInEntryUnit]
    , NULL AS [EntryUnitID]
    , MDI_axbi.[HDR_PostingDate]
    , MDI_axbi.[DocumentDate]
    , NULL AS [TotalGoodsMvtAmtInCCCrcy]
    , MDI_axbi.[CompanyCodeCurrency]
    , NULL AS [InventoryValuationTypeID]
    , NULL AS [ReservationIsFinallyIssued]
    , MDI_axbi.[PurchaseOrder]
    , MDI_axbi.[PurchaseOrderItem]
    , NULL AS [ProjectNetwork]
    , MDI_axbi.[Order]
    , MDI_axbi.[OrderItem]
    , NULL AS [Reservation]
    , NULL AS [ReservationItem]
    , NULL AS [DeliveryDocument]
    , NULL AS [DeliveryDocumentItem]
    , NULL AS [ReversedMaterialDocumentYear]
    , NULL AS [ReversedMaterialDocument]
    , NULL AS [ReversedMaterialDocumentItem]
    , NULL AS [RvslOfGoodsReceiptIsAllowed]
    , NULL AS [GoodsRecipientName]
    , NULL AS [UnloadingPointName]
    , NULL AS [CostCenterID]
    , NULL AS [GLAccountID]
    , NULL AS [ServicePerformer]
    , NULL AS [EmploymentInternalID]
    , NULL AS [AccountAssignmentCategory]
    , NULL AS [WorkItem]
    , NULL AS [ServicesRenderedDate]
    , NULL AS [IssgOrRcvgMaterial]
    , NULL AS [CompanyCodeID]
    , NULL AS [GoodsMovementRefDocTypeID]
    , NULL AS [IsAutomaticallyCreated]
    , NULL AS [IsCompletelyDelivered]
    , NULL AS [IssuingOrReceivingPlantID]
    , NULL AS [IssuingOrReceivingStorageLocID]
    , NULL AS [BusinessAreaID]
    , NULL AS [ControllingAreaID]
    , NULL AS [FiscalYearPeriod]
    , NULL AS [FiscalYearVariant]
    , NULL AS [IssgOrRcvgBatch]
    , NULL AS [IssgOrRcvgSpclStockInd]
    , NULL AS [MaterialDocumentItemText]
    , MDI_axbi.[CurrencyTypeID]
    , NULL AS [HDR_AccountingDocumentTypeID]
    , NULL AS [HDR_InventoryTransactionTypeID]
    , NULL AS [HDR_CreatedByUser]
    , NULL AS [HDR_CreationDate]
    , NULL AS [HDR_CreationTime]
    , NULL AS [HDR_MaterialDocumentHeaderText]
    , NULL AS [HDR_ReferenceDocument]
    , NULL AS [HDR_BillOfLading]
    , NULL AS [SalesDocumentTypeID]
    , NULL AS [SalesDocumentType] 
    , MDI_axbi.[SalesDocumentItemCategoryID] 
    , MDI_axbi.[SalesDocumentItemCategory]
    , NULL AS [HDR_DeliveryDocumentTypeID]
    , MDI_axbi.[MatlStkChangeQtyInBaseUnit]
    , MDI_axbi.[ConsumptionQtyICPOInBaseUnit]     
    , MDI_axbi.[ConsumptionQtyOBDProInBaseUnit]
    , MDI_axbi.[ConsumptionQtySOInBaseUnit]
    , MDI_axbi.[MatlCnsmpnQtyInMatlBaseUnit]
    , NULL AS [GoodsReceiptQtyInOrderUnit]
    , NULL AS [GoodsMovementIsCancelled]
    , NULL AS [GoodsMovementCancellationType]
    , NULL AS [ConsumptionPosting]
    , MDI_axbi.[ManufacturingOrder]
    , MDI_axbi.[ManufacturingOrderItem]
    , NULL AS [IsReversalMovementType]
    , NULL AS [nk_dim_ProductValuationPUP]
    , NULL AS [StockPricePerUnit]
    , NULL AS [StockPricePerUnit_EUR]
    , NULL AS [StockPricePerUnit_USD]
    , MDI_axbi.[ConsumptionQtyICPOInStandardValue]
    , MDI_axbi.[ConsumptionQtyICPOInStandardValue_EUR]
    , NULL AS [ConsumptionQtyICPOInStandardValue_USD]
    , NULL AS [ConsumptionQtyOBDProStandardValue]
    , NULL AS [ConsumptionQtyOBDProStandardValue_EUR]
    , NULL AS [ConsumptionQtyOBDProStandardValue_USD]
    , MDI_axbi.[ConsumptionQtySOStandardValue]
    , MDI_axbi.[ConsumptionQtySOStandardValue_EUR]
    , NULL AS [ConsumptionQtySOStandardValue_USD]
    , MDI_axbi.[MatlStkChangeStandardValue]
    , MDI_axbi.[MatlStkChangeStandardValue_EUR]
    , NULL AS [MatlStkChangeStandardValue_USD]
    , NULL AS [QuantityInBaseUnitStandardValue]
    , NULL AS [QuantityInBaseUnitStandardValue_EUR]
    , NULL AS [QuantityInBaseUnitStandardValue_USD]
    , MDI_axbi.[StandardPricePerUnit]
    , MDI_axbi.[StandardPricePerUnit_EUR]
    , NULL AS [PriceControlIndicatorID]
    , NULL AS [PriceControlIndicator]
    , MDI_axbi.[t_applicationId]
    , MDI_axbi.[t_extractionDtm]
    FROM
        [edw].[fact_MaterialDocumentItem_axbi] MDI_axbi
)
SELECT
      MDIU.[MaterialDocumentYear]
    , MDIU.[MaterialDocument]
    , MDIU.[MaterialDocumentItem]
    , MDIU.[MaterialID]
    , MDIU.[PlantID]
    , MDIU.[StorageLocationID]
    , MDIU.[StorageTypeID]
    , MDIU.[StorageBin]
    , MDIU.[Batch]
    , MDIU.[ShelfLifeExpirationDate]
    , MDIU.[ManufactureDate]
    , MDIU.[SupplierID]
    , MDIU.[SalesOrder]
    , MDIU.[SalesOrderItem]
    , MDIU.[SalesOrderScheduleLine]
    , MDIU.[WBSElementInternalID]
    , MDIU.[CustomerID]
    , MDIU.[InventorySpecialStockTypeID]
    , MDIU.[InventorySpecialStockTypeName]
    , MDIU.[InventoryStockTypeID]
    , MDIU.[InventoryStockTypeName]
    , MDIU.[StockOwner]
    , MDIU.[GoodsMovementTypeID]
    , MDIU.[GoodsMovementTypeName]
    , MDIU.[DebitCreditCode]
    , MDIU.[InventoryUsabilityCode]
    , MDIU.[QuantityInBaseUnit]
    , MDIU.[MaterialBaseUnitID]
    , MDIU.[QuantityInEntryUnit]
    , MDIU.[EntryUnitID]
    , MDIU.[HDR_PostingDate]
    , MDIU.[DocumentDate]
    , MDIU.[TotalGoodsMvtAmtInCCCrcy]
    , MDIU.[CompanyCodeCurrency]
    , MDIU.[InventoryValuationTypeID]
    , MDIU.[ReservationIsFinallyIssued]
    , MDIU.[PurchaseOrder]
    , MDIU.[PurchaseOrderItem]
    , MDIU.[ProjectNetwork]
    , MDIU.[Order]
    , MDIU.[OrderItem]
    , MDIU.[Reservation]
    , MDIU.[ReservationItem]
    , MDIU.[DeliveryDocument]
    , MDIU.[DeliveryDocumentItem]
    , MDIU.[ReversedMaterialDocumentYear]
    , MDIU.[ReversedMaterialDocument]
    , MDIU.[ReversedMaterialDocumentItem]
    , MDIU.[RvslOfGoodsReceiptIsAllowed]
    , MDIU.[GoodsRecipientName]
    , MDIU.[UnloadingPointName]
    , MDIU.[CostCenterID]
    , MDIU.[GLAccountID]
    , MDIU.[ServicePerformer]
    , MDIU.[EmploymentInternalID]
    , MDIU.[AccountAssignmentCategory]
    , MDIU.[WorkItem]
    , MDIU.[ServicesRenderedDate]
    , MDIU.[IssgOrRcvgMaterial]
    , MDIU.[CompanyCodeID]
    , MDIU.[GoodsMovementRefDocTypeID]
    , MDIU.[IsAutomaticallyCreated]
    , MDIU.[IsCompletelyDelivered]
    , MDIU.[IssuingOrReceivingPlantID]
    , MDIU.[IssuingOrReceivingStorageLocID]
    , MDIU.[BusinessAreaID]
    , MDIU.[ControllingAreaID]
    , MDIU.[FiscalYearPeriod]
    , MDIU.[FiscalYearVariant]
    , MDIU.[IssgOrRcvgBatch]
    , MDIU.[IssgOrRcvgSpclStockInd]
    , MDIU.[MaterialDocumentItemText]
    , MDIU.[CurrencyTypeID]
    , MDIU.[HDR_AccountingDocumentTypeID]
    , MDIU.[HDR_InventoryTransactionTypeID]
    , MDIU.[HDR_CreatedByUser]
    , MDIU.[HDR_CreationDate]
    , MDIU.[HDR_CreationTime]
    , MDIU.[HDR_MaterialDocumentHeaderText]
    , MDIU.[HDR_ReferenceDocument]
    , MDIU.[HDR_BillOfLading]
    , MDIU.[SalesDocumentTypeID]
    , MDIU.[SalesDocumentType] 
    , MDIU.[SalesDocumentItemCategoryID] 
    , MDIU.[SalesDocumentItemCategory]
    , MDIU.[HDR_DeliveryDocumentTypeID]
    , MDIU.[MatlStkChangeQtyInBaseUnit]
    , MDIU.[ConsumptionQtyICPOInBaseUnit]     
    , MDIU.[ConsumptionQtyOBDProInBaseUnit]
    , MDIU.[ConsumptionQtySOInBaseUnit]
    , MDIU.[MatlCnsmpnQtyInMatlBaseUnit]
    , MDIU.[GoodsReceiptQtyInOrderUnit]
    , MDIU.[GoodsMovementIsCancelled]
    , MDIU.[GoodsMovementCancellationType]
    , MDIU.[ConsumptionPosting]
    , MDIU.[ManufacturingOrder]
    , MDIU.[ManufacturingOrderItem]
    , MDIU.[IsReversalMovementType]
    , CASE WHEN ISNULL(MDIU.[PurchaseOrder],'') <>'' AND dimPDT.[PurchasingDocumentTypeID] = 'STO' 
        THEN  MDIU.[MatlStkChangeQtyInBaseUnit]
        ELSE NULL
      END                                                                        AS [ConsumptionQtySTOInBaseUnit]
    , dimPDT.[PurchasingDocumentTypeID]                                           AS [PurchaseOrderTypeID]
    , dimPDT.[PurchasingDocumentTypeName]                                         AS [PurchaseOrderType]
    , MDIU.[nk_dim_ProductValuationPUP]
    , MDIU.[StockPricePerUnit]
    , MDIU.[StockPricePerUnit_EUR]
    , MDIU.[StockPricePerUnit_USD]
    , MDIU.[ConsumptionQtyICPOInStandardValue]
    , MDIU.[ConsumptionQtyICPOInStandardValue_EUR]
    , MDIU.[ConsumptionQtyICPOInStandardValue_USD]
    , MDIU.[ConsumptionQtyOBDProStandardValue]
    , MDIU.[ConsumptionQtyOBDProStandardValue_EUR]
    , MDIU.[ConsumptionQtyOBDProStandardValue_USD]
    , MDIU.[ConsumptionQtySOStandardValue]
    , MDIU.[ConsumptionQtySOStandardValue_EUR]
    , MDIU.[ConsumptionQtySOStandardValue_USD]
    , MDIU.[MatlStkChangeStandardValue]
    , MDIU.[MatlStkChangeStandardValue_EUR]
    , MDIU.[MatlStkChangeStandardValue_USD]
    , MDIU.[QuantityInBaseUnitStandardValue]
    , MDIU.[QuantityInBaseUnitStandardValue_EUR]
    , MDIU.[QuantityInBaseUnitStandardValue_USD]
    , MDIU.[StandardPricePerUnit]
    , MDIU.[StandardPricePerUnit_EUR]
    , MDIU.[PriceControlIndicatorID]
    , MDIU.[PriceControlIndicator]
    , MDIU.[t_applicationId]
    , MDIU.[t_extractionDtm]
FROM
    MDI_UNION MDIU
LEFT JOIN 
    [edw].[fact_PurchasingDocument] dimPD 
        ON 
            MDIU.[PurchaseOrder] COLLATE Latin1_General_100_BIN2 = dimPD.[PurchasingDocument] 
LEFT JOIN  
    [edw].[dim_PurchasingDocumentType] dimPDT 
        ON  
            dimPDT.[PurchasingDocumentTypeID]  = dimPD.[PurchasingDocumentTypeID] 
            AND
            dimPDT.[PurchasingDocumentCategoryID]  = dimPD.[PurchasingDocumentCategoryID]
*/            