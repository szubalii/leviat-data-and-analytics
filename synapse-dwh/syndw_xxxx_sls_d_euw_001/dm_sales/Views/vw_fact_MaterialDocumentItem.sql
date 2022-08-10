CREATE VIEW [dm_sales].[vw_fact_MaterialDocumentItem]
	AS 
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
    END                                                                        AS ConsumptionQtySTOInBaseUnit
    , dimPDT.[PurchasingDocumentTypeID]                                        AS [PurchaseOrderTypeID]
    , dimPDT.[PurchasingDocumentTypeName]                                      AS [PurchaseOrderType]
    , dimPVs.[nk_dim_ProductValuationPUP]                                      AS [nk_dim_ProductValuationPUP]
    , dimPVs.[StockPricePerUnit]
    , dimPVs.[StockPricePerUnit_EUR]
    , MDI.[ConsumptionQtyICPOInBaseUnit] * dimPVs.[StockPricePerUnit]           AS ConsumptionQtyICPOInStandardValue
    , MDI.[ConsumptionQtyICPOInBaseUnit] * dimPVs.[StockPricePerUnit_EUR]       AS ConsumptionQtyICPOInStandardValue_EUR
    , MDI.[ConsumptionQtyOBDProInBaseUnit] * dimPVs.[StockPricePerUnit]         AS ConsumptionQtyOBDProStandardValue
    , MDI.[ConsumptionQtyOBDProInBaseUnit] * dimPVs.[StockPricePerUnit_EUR]     AS ConsumptionQtyOBDProStandardValue_EUR
    , MDI.[ConsumptionQtySOInBaseUnit] * dimPVs.[StockPricePerUnit]             AS ConsumptionQtySOStandardValue
    , MDI.[ConsumptionQtySOInBaseUnit] * dimPVs.[StockPricePerUnit_EUR]         AS ConsumptionQtySOStandardValue_EUR
    , MDI.[MatlStkChangeQtyInBaseUnit] * dimPVs.[StockPricePerUnit]             AS MatlStkChangeStandardValue
    , MDI.[MatlStkChangeQtyInBaseUnit] * dimPVs.[StockPricePerUnit_EUR]         AS MatlStkChangeStandardValue_EUR
    , MDI.[QuantityInBaseUnit] * dimPVs.[StockPricePerUnit]                     AS QuantityInBaseUnitStandardValue
    , MDI.[QuantityInBaseUnit] * dimPVs.[StockPricePerUnit_EUR]                 AS QuantityInBaseUnitStandardValue_EUR
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
    , dimGMT.[GoodsMovementTypeName]
    , NULL AS [DebitCreditCode]
    , NULL AS [InventoryUsabilityCode]
    , NULL AS [QuantityInBaseUnit]
    , NULL AS [MaterialBaseUnitID]
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
    , MDI_axbi.[DeliveryDocument]
    , MDI_axbi.[DeliveryDocumentItem]
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
    , CASE WHEN ISNULL(MDI_axbi.[PurchaseOrder],'') <>'' AND dimPDT.[PurchasingDocumentTypeID] = 'STO' 
        THEN  MDI_axbi.[MatlStkChangeQtyInBaseUnit]
        ELSE NULL
      END                                                                        AS [ConsumptionQtySTOInBaseUnit]
    , dimPDT.[PurchasingDocumentTypeID]                                           AS [PurchaseOrderTypeID]
    , dimPDT.[PurchasingDocumentTypeName]                                         AS [PurchaseOrderType]
    , NULL AS [nk_dim_ProductValuationPUP]
    , NULL AS [StockPricePerUnit]
    , NULL AS [StockPricePerUnit_EUR]
    , MDI_axbi.[ConsumptionQtyICPOInStandardValue]
    , MDI_axbi.[ConsumptionQtyICPOInStandardValue_EUR]
    , NULL AS [ConsumptionQtyOBDProStandardValue]
    , NULL AS [ConsumptionQtyOBDProStandardValue_EUR]
    , MDI_axbi.[ConsumptionQtySOStandardValue]
    , MDI_axbi.[ConsumptionQtySOStandardValue_EUR]
    , MDI_axbi.[MatlStkChangeStandardValue]
    , MDI_axbi.[MatlStkChangeStandardValue_EUR]
    , NULL AS [QuantityInBaseUnitStandardValue]
    , NULL AS [QuantityInBaseUnitStandardValue_EUR]
    , MDI_axbi.[StandardPricePerUnit]
    , MDI_axbi.[StandardPricePerUnit_EUR]
    , NULL AS [PriceControlIndicatorID]
    , NULL AS [PriceControlIndicator]
    , MDI_axbi.[t_applicationId]
    , MDI_axbi.[t_extractionDtm]
    FROM
        [edw].[fact_MaterialDocumentItem_axbi] MDI_axbi
    LEFT JOIN
        [edw].[dim_GoodsMovementType] dimGMT
            ON 
                dimGMT.GoodsMovementTypeID = MDI_axbi.[GoodsMovementTypeID]
    LEFT JOIN 
        [edw].[dim_PurchasingDocument] dimPD 
            ON 
                MDI_axbi.[PurchaseOrder] COLLATE Latin1_General_100_BIN2 = dimPD.[PurchasingDocumentID] 
    LEFT JOIN  
        [edw].[dim_PurchasingDocumentType] dimPDT 
            ON  
                dimPDT.[PurchasingDocumentTypeID]  = dimPD.[PurchasingDocumentType] 
                AND
                dimPDT.[PurchasingDocumentCategory]  = dimPD.[PurchasingDocumentCategory]