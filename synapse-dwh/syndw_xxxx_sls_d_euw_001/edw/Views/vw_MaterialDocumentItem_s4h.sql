CREATE VIEW [edw].[vw_MaterialDocumentItem_s4h]
	AS 
SELECT 
  MDI.[MaterialDocumentYear] AS MaterialDocumentYear
, MDI.[MaterialDocument]  AS MaterialDocument
, MDI.[MaterialDocumentItem] AS MaterialDocumentItem
, MDI.[Material] as [MaterialID]
, MDI.[Plant]  as [PlantID] 
, MDI.[StorageLocation]  as [StorageLocationID]
, MDI.[StorageType] as [StorageTypeID] 
, MDI.[StorageBin]  AS StorageBin
, MDI.[Batch]  AS Batch
, MDI.[ShelfLifeExpirationDate] 
, MDI.[ManufactureDate] 
, MDI.[Supplier] as [SupplierID] 
, MDI.[SalesOrder] AS SalesOrder
, MDI.[SalesOrderItem]  AS SalesOrderItem
, MDI.[SalesOrderScheduleLine]  AS SalesOrderScheduleLine
, MDI.[WBSElementInternalID]  AS WBSElementInternalID
, MDI.[Customer] as [CustomerID]
, MDI.[InventorySpecialStockType] as [InventorySpecialStockTypeID]
, MDI.[InventoryStockType] as [InventoryStockTypeID]
, MDI.[StockOwner]  AS StockOwner
, MDI.[GoodsMovementType] as [GoodsMovementTypeID]
, MDI.[DebitCreditCode]  AS DebitCreditCode
, MDI.[InventoryUsabilityCode]  AS InventoryUsabilityCode
, MDI.[QuantityInBaseUnit] 
, MDI.[MaterialBaseUnit] as [MaterialBaseUnitID]
, MDI.[QuantityInEntryUnit] 
, MDI.[EntryUnit] as [EntryUnitID]
, MDI.[PostingDate] as [HDR_PostingDate]
, MDI.[DocumentDate] 
, MDI.[TotalGoodsMvtAmtInCCCrcy] 
, MDI.[CompanyCodeCurrency]  AS CompanyCodeCurrency
, MDI.[InventoryValuationType] as [InventoryValuationTypeID]
, MDI.[ReservationIsFinallyIssued] AS ReservationIsFinallyIssued
, MDI.[PurchaseOrder]  AS PurchaseOrder
, MDI.[PurchaseOrderItem]  AS PurchaseOrderItem
, MDI.[ProjectNetwork]  AS ProjectNetwork
, MDI.[OrderID] as [Order]                       
, MDI.[OrderItem]  AS OrderItem
, MDI.[Reservation] AS Reservation
, MDI.[ReservationItem] AS ReservationItem
, MDI.[DeliveryDocument] AS DeliveryDocument
, MDI.[DeliveryDocumentItem]  AS DeliveryDocumentItem
, MDI.[ReversedMaterialDocumentYear] AS ReversedMaterialDocumentYear
, MDI.[ReversedMaterialDocument]  AS ReversedMaterialDocument
, MDI.[ReversedMaterialDocumentItem]  AS ReversedMaterialDocumentItem
, MDI.[RvslOfGoodsReceiptIsAllowed]  AS RvslOfGoodsReceiptIsAllowed
, MDI.[GoodsRecipientName]  AS GoodsRecipientName
, MDI.[UnloadingPointName]  AS UnloadingPointName
, MDI.[CostCenter] as [CostCenterID]
, MDI.[GLAccount] as [GLAccountID]
, MDI.[ServicePerformer] AS ServicePerformer
, MDI.[EmploymentInternalID]  AS EmploymentInternalID
, MDI.[AccountAssignmentCategory]  AS AccountAssignmentCategory
, MDI.[WorkItem]  AS WorkItem
, MDI.[ServicesRenderedDate] 
, MDI.[IssgOrRcvgMaterial]  AS IssgOrRcvgMaterial
, MDI.[CompanyCode] as [CompanyCodeID]
, MDI.[GoodsMovementRefDocType] as [GoodsMovementRefDocTypeID]
, MDI.[IsAutomaticallyCreated] AS IsAutomaticallyCreated
, MDI.[IsCompletelyDelivered] AS IsCompletelyDelivered
, MDI.[IssuingOrReceivingPlant] as [IssuingOrReceivingPlantID]
, MDI.[IssuingOrReceivingStorageLoc] as [IssuingOrReceivingStorageLocID]
, MDI.[BusinessArea] as [BusinessAreaID]
, MDI.[ControllingArea] as [ControllingAreaID]
, MDI.[FiscalYearPeriod] AS FiscalYearPeriod
, MDI.[FiscalYearVariant] AS FiscalYearVariant
, MDI.[IssgOrRcvgBatch] AS IssgOrRcvgBatch
, MDI.[IssgOrRcvgSpclStockInd] AS IssgOrRcvgSpclStockInd
, MDI.[MaterialDocumentItemText] AS MaterialDocumentItemText
, '10' as [CurrencyTypeID]
, MDH.[AccountingDocumentType] as [HDR_AccountingDocumentTypeID]
, MDH.[InventoryTransactionType] as [HDR_InventoryTransactionTypeID]
, MDH.[CreatedByUser] as [HDR_CreatedByUser]
, MDH.[CreationDate] as [HDR_CreationDate]
, MDH.[CreationTime] as [HDR_CreationTime]
, MDH.[MaterialDocumentHeaderText] as [HDR_MaterialDocumentHeaderText]
, MDH.[ReferenceDocument] as [HDR_ReferenceDocument]
, MDH.[BillOfLading] as [HDR_BillOfLading]
, MDI.[MatlStkChangeQtyInBaseUnit]
, CASE WHEN ISNULL(MDI.[PurchaseOrder],'') <>''
    THEN MDI.[MatlCnsmpnQtyInMatlBaseUnit]
    ELSE NULL  
  END AS [ConsumptionQtyICPOInBaseUnit]
, CASE WHEN ISNULL(MDI.[OrderID],'') <>''
    THEN MDI.[MatlCnsmpnQtyInMatlBaseUnit]
    ELSE NULL
  END AS [ConsumptionQtyOBDProInBaseUnit]
, CASE WHEN ISNULL(MDI.[SalesOrder],'') <>''
    THEN MDI.[MatlCnsmpnQtyInMatlBaseUnit]
    ELSE NULL
  END AS [ConsumptionQtySOInBaseUnit]
, MDI.[MatlCnsmpnQtyInMatlBaseUnit]
, MDI.[GoodsReceiptQtyInOrderUnit]
, MDI.[GoodsMovementIsCancelled] AS GoodsMovementIsCancelled
, MDI.[GoodsMovementCancellationType] AS GoodsMovementCancellationType
, MDI.[ConsumptionPosting] AS ConsumptionPosting
, MDI.[ManufacturingOrder] AS ManufacturingOrder
, MDI.[ManufacturingOrderItem] AS ManufacturingOrderItem
, MDI.[IsReversalMovementType] AS IsReversalMovementType
, dimPVs.[nk_dim_ProductValuationPUP]                                      AS [nk_dim_ProductValuationPUP]
, dimPVs.[StockPricePerUnit]
, dimPVs.[StockPricePerUnit_EUR]
, dimPVs.[StockPricePerUnit_USD]
, SDT.[SalesDocumentTypeID]  AS SalesDocumentTypeID
, SDT.[SalesDocumentType]  AS SalesDocumentType
, dimSDIC.[SalesDocumentItemCategoryID]  AS SalesDocumentItemCategoryID
, dimSDIC.[SalesDocumentItemCategory]  AS SalesDocumentItemCategory
, dimPDT.[PurchasingDocumentTypeID]                                           AS [PurchaseOrderTypeID]
, dimPDT.[PurchasingDocumentTypeName]                                         AS [PurchaseOrderType]
, dimDel.[DeliveryDocumentType]                     AS [HDR_DeliveryDocumentTypeID]
, dimGMT.[GoodsMovementTypeName]        AS GoodsMovementTypeName
, MDI.[MatlStkChangeQtyInBaseUnit] * dimPVs.[StockPricePerUnit]             AS MatlStkChangeStandardValue
, MDI.[MatlStkChangeQtyInBaseUnit] * dimPVs.[StockPricePerUnit_EUR]         AS MatlStkChangeStandardValue_EUR
, MDI.[MatlStkChangeQtyInBaseUnit] * dimPVs.[StockPricePerUnit_USD]         AS MatlStkChangeStandardValue_USD
, CASE WHEN ISNULL(MDI.[PurchaseOrder],'') <>''
    THEN MDI.[MatlCnsmpnQtyInMatlBaseUnit]
    ELSE NULL  
  END  * dimPVs.[StockPricePerUnit]           AS ConsumptionQtyICPOInStandardValue
, CASE WHEN ISNULL(MDI.[PurchaseOrder],'') <>''
    THEN MDI.[MatlCnsmpnQtyInMatlBaseUnit]
    ELSE NULL  
  END  * dimPVs.[StockPricePerUnit_EUR]       AS ConsumptionQtyICPOInStandardValue_EUR
, CASE WHEN ISNULL(MDI.[PurchaseOrder],'') <>''
    THEN MDI.[MatlCnsmpnQtyInMatlBaseUnit]
    ELSE NULL  
  END  * dimPVs.[StockPricePerUnit_USD]       AS ConsumptionQtyICPOInStandardValue_USD
, MDI.[QuantityInBaseUnit] * dimPVs.[StockPricePerUnit]                     AS QuantityInBaseUnitStandardValue
, MDI.[QuantityInBaseUnit] * dimPVs.[StockPricePerUnit_EUR]                 AS QuantityInBaseUnitStandardValue_EUR
, MDI.[QuantityInBaseUnit] * dimPVs.[StockPricePerUnit_USD]                 AS QuantityInBaseUnitStandardValue_USD
, dimISST.[InventorySpecialStockTypeName]          AS InventorySpecialStockTypeName
, dimIST.[InventoryStockTypeName]                  AS InventoryStockTypeName
, dimPVs.[PriceControlIndicatorID]                 AS PriceControlIndicatorID
, dimPVs.[PriceControlIndicator]                   AS PriceControlIndicator
, MDI.[MaterialDocumentRecordType]
, MDI.[t_applicationId] AS t_applicationId
, MDI.[t_extractionDtm]
FROM [edw].[vw_MaterialDocumentItem_MDOC_CP] MDI
LEFT JOIN [base_s4h_cax].[I_MaterialDocumentHeader] MDH
  ON 
  MDI.[MaterialDocumentYear]=MDH.[MaterialDocumentYear]
    AND
  MDI.[MaterialDocument]=MDH.[MaterialDocument]
LEFT JOIN 
  [edw].[dim_ProductValuationPUP] dimPVs
  ON  
  dimPVs.[ValuationTypeID] =  MDI.[InventoryValuationType] 
    AND
  dimPVs.[ValuationAreaID] = MDI.[Plant]
    AND
  dimPVs.[ProductID] = MDI.[Material]    
    AND 
  dimPVs.[CalendarYear] =  FORMAT(MDI.[PostingDate],'yyyy')
    AND
  dimPVs.[CalendarMonth] = FORMAT(MDI.[PostingDate],'MM')
LEFT JOIN 
    [edw].[fact_SalesDocumentItem] SDI
        ON MDI.[SalesOrder] = SDI.[SalesDocument]
            AND
            MDI.[SalesOrderItem] = SDI.[SalesDocumentItem]
            AND
            SDI.[CurrencyTypeID] = 10
LEFT JOIN 
    [edw].[dim_SalesDocumentType] SDT
        ON SDI.[SalesDocumentTypeID] = SDT.[SalesDocumentTypeID]
LEFT JOIN 
    [edw].[dim_SalesDocumentItemCategory] dimSDIC
        ON SDI.[SalesDocumentItemCategoryID] = dimSDIC.[SalesDocumentItemCategoryID]
LEFT JOIN 
    [edw].[fact_PurchasingDocument] dimPD 
        ON 
            MDI.[PurchaseOrder] = dimPD.[PurchasingDocument] 
LEFT JOIN  
    [edw].[dim_PurchasingDocumentType] dimPDT 
        ON  
            dimPDT.[PurchasingDocumentTypeID]  = dimPD.[PurchasingDocumentTypeID] 
            AND
            dimPDT.[PurchasingDocumentCategoryID]  = dimPD.[PurchasingDocumentCategoryID]
LEFT JOIN 
    [edw].[dim_DeliveryDocument] dimDel 
        ON dimDel.DeliveryDocumentID = MDH.[ReferenceDocument] 
LEFT JOIN
        [edw].[dim_GoodsMovementType] dimGMT
            ON 
                dimGMT.GoodsMovementTypeID = MDI.[GoodsMovementType]
LEFT JOIN
        [edw].[dim_InventorySpecialStockType] dimISST
            ON  dimISST.[InventorySpecialStockTypeID] = MDI.[InventorySpecialStockType]
LEFT JOIN
        [edw].[dim_InventoryStockType] dimIST
            ON dimIST.[InventoryStockTypeID] = MDI.[InventoryStockType]  
-- WHERE MDI.[MANDT] = 200 MPS 2021/11/01: commented out due to different client values between dev,qas, and prod