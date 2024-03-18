CREATE VIEW [edw].[vw_MaterialDocumentItem_s4h]
	AS 
SELECT 
  MDI.[MaterialDocumentYear] collate DATABASE_DEFAULT AS MaterialDocumentYear
, MDI.[MaterialDocument]  collate DATABASE_DEFAULT AS MaterialDocument
, MDI.[MaterialDocumentItem] collate DATABASE_DEFAULT AS MaterialDocumentItem
, MDI.[Material] collate DATABASE_DEFAULT as [MaterialID]
, MDI.[Plant]  collate DATABASE_DEFAULT as [PlantID] 
, MDI.[StorageLocation]  collate DATABASE_DEFAULT as [StorageLocationID]
, MDI.[StorageType] collate DATABASE_DEFAULT as [StorageTypeID] 
, MDI.[StorageBin]  collate DATABASE_DEFAULT AS StorageBin
, MDI.[Batch]  collate DATABASE_DEFAULT AS Batch
, MDI.[ShelfLifeExpirationDate] 
, MDI.[ManufactureDate] 
, MDI.[Supplier] collate DATABASE_DEFAULT as [SupplierID] 
, MDI.[SalesOrder] collate DATABASE_DEFAULT AS SalesOrder
, MDI.[SalesOrderItem]  collate DATABASE_DEFAULT AS SalesOrderItem
, MDI.[SalesOrderScheduleLine]  collate DATABASE_DEFAULT AS SalesOrderScheduleLine
, MDI.[WBSElementInternalID]  collate DATABASE_DEFAULT AS WBSElementInternalID
, MDI.[Customer] collate DATABASE_DEFAULT as [CustomerID]
, MDI.[InventorySpecialStockType] collate DATABASE_DEFAULT as [InventorySpecialStockTypeID]
, MDI.[InventoryStockType] collate DATABASE_DEFAULT as [InventoryStockTypeID]
, MDI.[StockOwner]  collate DATABASE_DEFAULT AS StockOwner
, MDI.[GoodsMovementType] collate DATABASE_DEFAULT as [GoodsMovementTypeID]
, MDI.[DebitCreditCode]  collate DATABASE_DEFAULT AS DebitCreditCode
, MDI.[InventoryUsabilityCode]  collate DATABASE_DEFAULT AS InventoryUsabilityCode
, MDI.[QuantityInBaseUnit] 
, MDI.[MaterialBaseUnit] collate DATABASE_DEFAULT as [MaterialBaseUnitID]
, MDI.[QuantityInEntryUnit] 
, MDI.[EntryUnit] collate DATABASE_DEFAULT as [EntryUnitID]
, MDI.[PostingDate] as [HDR_PostingDate]
, MDI.[DocumentDate] 
, MDI.[TotalGoodsMvtAmtInCCCrcy] 
, MDI.[CompanyCodeCurrency]  collate DATABASE_DEFAULT AS CompanyCodeCurrency
, MDI.[InventoryValuationType] collate DATABASE_DEFAULT as [InventoryValuationTypeID]
, MDI.[ReservationIsFinallyIssued] collate DATABASE_DEFAULT AS ReservationIsFinallyIssued
, MDI.[PurchaseOrder]  collate DATABASE_DEFAULT AS PurchaseOrder
, MDI.[PurchaseOrderItem]  collate DATABASE_DEFAULT AS PurchaseOrderItem
, MDI.[ProjectNetwork]  collate DATABASE_DEFAULT AS ProjectNetwork
, MDI.[OrderID] collate DATABASE_DEFAULT as [Order]                       
, MDI.[OrderItem]  collate DATABASE_DEFAULT AS OrderItem
, MDI.[Reservation] collate DATABASE_DEFAULT AS Reservation
, MDI.[ReservationItem] collate DATABASE_DEFAULT AS ReservationItem
, MDI.[DeliveryDocument] collate DATABASE_DEFAULT AS DeliveryDocument
, MDI.[DeliveryDocumentItem]  collate DATABASE_DEFAULT AS DeliveryDocumentItem
, MDI.[ReversedMaterialDocumentYear] collate DATABASE_DEFAULT AS ReversedMaterialDocumentYear
, MDI.[ReversedMaterialDocument]  collate DATABASE_DEFAULT AS ReversedMaterialDocument
, MDI.[ReversedMaterialDocumentItem]  collate DATABASE_DEFAULT AS ReversedMaterialDocumentItem
, MDI.[RvslOfGoodsReceiptIsAllowed]  collate DATABASE_DEFAULT AS RvslOfGoodsReceiptIsAllowed
, MDI.[GoodsRecipientName]  collate DATABASE_DEFAULT AS GoodsRecipientName
, MDI.[UnloadingPointName]  collate DATABASE_DEFAULT AS UnloadingPointName
, MDI.[CostCenter] collate DATABASE_DEFAULT as [CostCenterID]
, MDI.[GLAccount] collate DATABASE_DEFAULT as [GLAccountID]
, MDI.[ServicePerformer] collate DATABASE_DEFAULT AS ServicePerformer
, MDI.[EmploymentInternalID]  collate DATABASE_DEFAULT AS EmploymentInternalID
, MDI.[AccountAssignmentCategory]  collate DATABASE_DEFAULT AS AccountAssignmentCategory
, MDI.[WorkItem]  collate DATABASE_DEFAULT AS WorkItem
, MDI.[ServicesRenderedDate] 
, MDI.[IssgOrRcvgMaterial]  collate DATABASE_DEFAULT AS IssgOrRcvgMaterial
, MDI.[CompanyCode] collate DATABASE_DEFAULT as [CompanyCodeID]
, MDI.[GoodsMovementRefDocType] collate DATABASE_DEFAULT as [GoodsMovementRefDocTypeID]
, MDI.[IsAutomaticallyCreated] collate DATABASE_DEFAULT AS IsAutomaticallyCreated
, MDI.[IsCompletelyDelivered] collate DATABASE_DEFAULT AS IsCompletelyDelivered
, MDI.[IssuingOrReceivingPlant] collate DATABASE_DEFAULT as [IssuingOrReceivingPlantID]
, MDI.[IssuingOrReceivingStorageLoc] collate DATABASE_DEFAULT as [IssuingOrReceivingStorageLocID]
, MDI.[BusinessArea] collate DATABASE_DEFAULT as [BusinessAreaID]
, MDI.[ControllingArea] collate DATABASE_DEFAULT as [ControllingAreaID]
, MDI.[FiscalYearPeriod] collate DATABASE_DEFAULT AS FiscalYearPeriod
, MDI.[FiscalYearVariant] collate DATABASE_DEFAULT AS FiscalYearVariant
, MDI.[IssgOrRcvgBatch] collate DATABASE_DEFAULT AS IssgOrRcvgBatch
, MDI.[IssgOrRcvgSpclStockInd] collate DATABASE_DEFAULT AS IssgOrRcvgSpclStockInd
, MDI.[MaterialDocumentItemText] collate DATABASE_DEFAULT AS MaterialDocumentItemText
, '10' as [CurrencyTypeID]
, MDH.[AccountingDocumentType] collate DATABASE_DEFAULT as [HDR_AccountingDocumentTypeID]
, MDH.[InventoryTransactionType] collate DATABASE_DEFAULT as [HDR_InventoryTransactionTypeID]
, MDH.[CreatedByUser] collate DATABASE_DEFAULT as [HDR_CreatedByUser]
, MDH.[CreationDate] as [HDR_CreationDate]
, MDH.[CreationTime] as [HDR_CreationTime]
, MDH.[MaterialDocumentHeaderText] collate DATABASE_DEFAULT as [HDR_MaterialDocumentHeaderText]
, MDH.[ReferenceDocument] collate DATABASE_DEFAULT as [HDR_ReferenceDocument]
, MDH.[BillOfLading] collate DATABASE_DEFAULT as [HDR_BillOfLading]
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
, MDI.[GoodsMovementIsCancelled] collate DATABASE_DEFAULT AS GoodsMovementIsCancelled
, MDI.[GoodsMovementCancellationType] collate DATABASE_DEFAULT AS GoodsMovementCancellationType
, MDI.[ConsumptionPosting] collate DATABASE_DEFAULT AS ConsumptionPosting
, MDI.[ManufacturingOrder] collate DATABASE_DEFAULT AS ManufacturingOrder
, MDI.[ManufacturingOrderItem] collate DATABASE_DEFAULT AS ManufacturingOrderItem
, MDI.[IsReversalMovementType] collate DATABASE_DEFAULT AS IsReversalMovementType
, dimPVs.[nk_dim_ProductValuationPUP]   collate DATABASE_DEFAULT                                    AS [nk_dim_ProductValuationPUP]
, dimPVs.[StockPricePerUnit]
, dimPVs.[StockPricePerUnit_EUR]
, dimPVs.[StockPricePerUnit_USD]
, SDT.[SalesDocumentTypeID]  collate DATABASE_DEFAULT AS SalesDocumentTypeID
, SDT.[SalesDocumentType]  collate DATABASE_DEFAULT AS SalesDocumentType
, dimSDIC.[SalesDocumentItemCategoryID]  collate DATABASE_DEFAULT AS SalesDocumentItemCategoryID
, dimSDIC.[SalesDocumentItemCategory] collate DATABASE_DEFAULT  AS SalesDocumentItemCategory
, dimPDT.[PurchasingDocumentTypeID]          collate DATABASE_DEFAULT                                  AS [PurchaseOrderTypeID]
, dimPDT.[PurchasingDocumentTypeName]         collate DATABASE_DEFAULT                                 AS [PurchaseOrderType]
, dimDel.[DeliveryDocumentType]               collate DATABASE_DEFAULT       AS [HDR_DeliveryDocumentTypeID]
, dimGMT.[GoodsMovementTypeName]        COLLATE DATABASE_DEFAULT AS GoodsMovementTypeName
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
, dimISST.[InventorySpecialStockTypeName]   COLLATE DATABASE_DEFAULT        AS InventorySpecialStockTypeName
, dimIST.[InventoryStockTypeName]           COLLATE DATABASE_DEFAULT        AS InventoryStockTypeName
, dimPVs.[PriceControlIndicatorID]          COLLATE DATABASE_DEFAULT        AS PriceControlIndicatorID
, dimPVs.[PriceControlIndicator]            COLLATE DATABASE_DEFAULT        AS PriceControlIndicator
, MDI.[MaterialDocumentRecordType]
, MDI.[t_applicationId] collate DATABASE_DEFAULT AS t_applicationId
, MDI.[t_extractionDtm]
FROM [base_s4h_cax].[Z_I_MaterialDocumentItem] MDI
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
        ON MDI.[SalesOrder] = SDI.[SalesDocument] collate DATABASE_DEFAULT
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
            MDI.[PurchaseOrder] COLLATE DATABASE_DEFAULT = dimPD.[PurchasingDocument] 
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