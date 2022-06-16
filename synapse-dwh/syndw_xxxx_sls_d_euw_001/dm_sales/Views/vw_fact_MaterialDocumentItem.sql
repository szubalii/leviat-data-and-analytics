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