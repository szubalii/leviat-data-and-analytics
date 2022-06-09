CREATE VIEW [dm_sales].[vw_fact_MaterialDocumentItem]
	AS 
WITH MaterialDocumentItem_CTE AS (
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
    , dimGMT.[GoodsMovementTypeName]
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
    , CASE WHEN ISNULL(MDI.[PurchaseOrder],'') <>'' AND dimPDT.[PurchasingDocumentTypeID] = 'STO' 
        THEN  MDI.[MatlStkChangeQtyInBaseUnit]
        ELSE NULL
    END                                                 AS ConsumptionQtySTOInBaseUnit
    , dimPDT.[PurchasingDocumentTypeID]                 AS [PurchaseOrderTypeID]
    , dimPDT.[PurchasingDocumentTypeName]               AS [PurchaseOrderType]
    , dimPVs.[nk_dim_ProductValuationPUP]               AS [nk_dim_ProductValuationPUP]
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
        [edw].[dim_GoodsMovementType] dimGMT
            ON dimGMT.GoodsMovementTypeID = MDI.[GoodsMovementTypeID]
    LEFT JOIN
        [edw].[dim_InventorySpecialStockType] dimISST
            ON  dimISST.[InventorySpecialStockTypeID] = MDI.[InventorySpecialStockTypeID]
    LEFT JOIN
        [edw].[dim_InventoryStockType] dimIST
            ON dimIST.[InventoryStockTypeID] = MDI.[InventoryStockTypeID]
    LEFT JOIN 
        [edw].[dim_PurchasingDocument] dimPD 
            ON MDI.[PurchaseOrder] COLLATE Latin1_General_100_BIN2 = dimPD.[PurchasingDocumentID] 
    LEFT JOIN  
        [edw].[dim_PurchasingDocumentType] dimPDT 
            ON  
                dimPDT.[PurchasingDocumentTypeID]  = dimPD.[PurchasingDocumentType] 
                AND
                dimPDT.[PurchasingDocumentCategory]  = dimPD.[PurchasingDocumentCategory]             
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
          
)
select       
      MDI_CTE.[MaterialDocumentYear]
    , MDI_CTE.[MaterialDocument]
    , MDI_CTE.[MaterialDocumentItem]
    , MDI_CTE.[MaterialID]
    , MDI_CTE.[PlantID]
    , MDI_CTE.[StorageLocationID]
    , MDI_CTE.[StorageTypeID]
    , MDI_CTE.[StorageBin]
    , MDI_CTE.[Batch]
    , MDI_CTE.[ShelfLifeExpirationDate]
    , MDI_CTE.[ManufactureDate]
    , MDI_CTE.[SupplierID]
    , MDI_CTE.[SalesOrder]
    , MDI_CTE.[SalesOrderItem]
    , MDI_CTE.[SalesOrderScheduleLine]
    , MDI_CTE.[WBSElementInternalID]
    , MDI_CTE.[CustomerID]
    , MDI_CTE.[InventorySpecialStockTypeID]
    , MDI_CTE.[InventorySpecialStockTypeName]
    , MDI_CTE.[InventoryStockTypeID]
    , MDI_CTE.[InventoryStockTypeName]
    , MDI_CTE.[StockOwner]
    , MDI_CTE.[GoodsMovementTypeID]
    , MDI_CTE.[GoodsMovementTypeName]
    , MDI_CTE.[DebitCreditCode]
    , MDI_CTE.[InventoryUsabilityCode]
    , MDI_CTE.[QuantityInBaseUnit]
    , MDI_CTE.[MaterialBaseUnitID]
    , MDI_CTE.[QuantityInEntryUnit]
    , MDI_CTE.[EntryUnitID]
    , MDI_CTE.[HDR_PostingDate]
    , MDI_CTE.[DocumentDate]
    , MDI_CTE.[TotalGoodsMvtAmtInCCCrcy]
    , MDI_CTE.[CompanyCodeCurrency]
    , MDI_CTE.[InventoryValuationTypeID]
    , MDI_CTE.[ReservationIsFinallyIssued]
    , MDI_CTE.[PurchaseOrder]
    , MDI_CTE.[PurchaseOrderItem]
    , MDI_CTE.[ProjectNetwork]
    , MDI_CTE.[Order]
    , MDI_CTE.[OrderItem]
    , MDI_CTE.[Reservation]
    , MDI_CTE.[ReservationItem]
    , MDI_CTE.[DeliveryDocument]
    , MDI_CTE.[DeliveryDocumentItem]
    , MDI_CTE.[ReversedMaterialDocumentYear]
    , MDI_CTE.[ReversedMaterialDocument]
    , MDI_CTE.[ReversedMaterialDocumentItem]
    , MDI_CTE.[RvslOfGoodsReceiptIsAllowed]
    , MDI_CTE.[GoodsRecipientName]
    , MDI_CTE.[UnloadingPointName]
    , MDI_CTE.[CostCenterID]
    , MDI_CTE.[GLAccountID]
    , MDI_CTE.[ServicePerformer]
    , MDI_CTE.[EmploymentInternalID]
    , MDI_CTE.[AccountAssignmentCategory]
    , MDI_CTE.[WorkItem]
    , MDI_CTE.[ServicesRenderedDate]
    , MDI_CTE.[IssgOrRcvgMaterial]
    , MDI_CTE.[CompanyCodeID]
    , MDI_CTE.[GoodsMovementRefDocTypeID]
    , MDI_CTE.[IsAutomaticallyCreated]
    , MDI_CTE.[IsCompletelyDelivered]
    , MDI_CTE.[IssuingOrReceivingPlantID]
    , MDI_CTE.[IssuingOrReceivingStorageLocID]
    , MDI_CTE.[BusinessAreaID]
    , MDI_CTE.[ControllingAreaID]
    , MDI_CTE.[FiscalYearPeriod]
    , MDI_CTE.[FiscalYearVariant]
    , MDI_CTE.[IssgOrRcvgBatch]
    , MDI_CTE.[IssgOrRcvgSpclStockInd]
    , MDI_CTE.[MaterialDocumentItemText]
    , MDI_CTE.[CurrencyTypeID]
    , MDI_CTE.[HDR_AccountingDocumentTypeID]
    , MDI_CTE.[HDR_InventoryTransactionTypeID]
    , MDI_CTE.[HDR_CreatedByUser]
    , MDI_CTE.[HDR_CreationDate]
    , MDI_CTE.[HDR_CreationTime]
    , MDI_CTE.[HDR_MaterialDocumentHeaderText]
    , MDI_CTE.[HDR_ReferenceDocument]
    , MDI_CTE.[HDR_BillOfLading]
    , MDI_CTE.[SalesDocumentTypeID]
    , MDI_CTE.[SalesDocumentType] 
    , MDI_CTE.[SalesDocumentItemCategoryID] 
    , MDI_CTE.[SalesDocumentItemCategory]
    , MDI_CTE.[HDR_DeliveryDocumentTypeID]
    , MDI_CTE.[MatlStkChangeQtyInBaseUnit]
    , MDI_CTE.[ConsumptionQtyICPOInBaseUnit]     
    , MDI_CTE.[ConsumptionQtyOBDProInBaseUnit]
    , MDI_CTE.[ConsumptionQtySOInBaseUnit]
    , MDI_CTE.[MatlCnsmpnQtyInMatlBaseUnit]
    , MDI_CTE.[GoodsReceiptQtyInOrderUnit]
    , MDI_CTE.[GoodsMovementIsCancelled]
    , MDI_CTE.[GoodsMovementCancellationType]
    , MDI_CTE.[ConsumptionPosting]
    , MDI_CTE.[ManufacturingOrder]
    , MDI_CTE.[ManufacturingOrderItem]
    , MDI_CTE.[IsReversalMovementType]
    , MDI_CTE.[ConsumptionQtySTOInBaseUnit]
    , MDI_CTE.[PurchaseOrderTypeID]
    , MDI_CTE.[PurchaseOrderType]
    , dimPV.[StockPricePerUnit]
    , dimPV.[StockPricePerUnit_EUR]
    , MDI_CTE.[ConsumptionQtyICPOInBaseUnit] * dimPV.[StockPricePerUnit]           AS ConsumptionQtyICPOInStandardValue
    , MDI_CTE.[ConsumptionQtyICPOInBaseUnit] * dimPV.[StockPricePerUnit_EUR]       AS ConsumptionQtyICPOInStandardValue_EUR
    , MDI_CTE.[ConsumptionQtyOBDProInBaseUnit] * dimPV.[StockPricePerUnit]         AS ConsumptionQtyOBDProStandardValue
    , MDI_CTE.[ConsumptionQtyOBDProInBaseUnit] * dimPV.[StockPricePerUnit_EUR]     AS ConsumptionQtyOBDProStandardValue_EUR
    , MDI_CTE.[ConsumptionQtySOInBaseUnit] * dimPV.[StockPricePerUnit]             AS ConsumptionQtySOStandardValue
    , MDI_CTE.[ConsumptionQtySOInBaseUnit] * dimPV.[StockPricePerUnit_EUR]         AS ConsumptionQtySOStandardValue_EUR
    , MDI_CTE.[MatlStkChangeQtyInBaseUnit] * dimPV.[StockPricePerUnit]             AS MatlStkChangeStandardValue
    , MDI_CTE.[MatlStkChangeQtyInBaseUnit] * dimPV.[StockPricePerUnit_EUR]         AS MatlStkChangeStandardValue_EUR
    , MDI_CTE.[QuantityInBaseUnit] * dimPV.[StockPricePerUnit]                     AS QuantityInBaseUnitStandardValue
    , MDI_CTE.[QuantityInBaseUnit] * dimPV.[StockPricePerUnit_EUR]                 AS QuantityInBaseUnitStandardValue_EUR
    , dimPV.[nk_dim_ProductValuationPUP]
    -- fields PriceControlIndicatorID, PriceControlIndicator are being used in [vw_fact_MaterialStockLevel]
    , dimPV.[PriceControlIndicatorID]
    , dimPV.[PriceControlIndicator]
    , MDI_CTE.[t_applicationId]
    , MDI_CTE.[t_extractionDtm]

FROM MaterialDocumentItem_CTE AS MDI_CTE  
LEFT JOIN 
    [edw].[dim_ProductValuationPUP] dimPV
        ON 
            MDI_CTE.[nk_dim_ProductValuationPUP] = dimPV.[nk_dim_ProductValuationPUP] 