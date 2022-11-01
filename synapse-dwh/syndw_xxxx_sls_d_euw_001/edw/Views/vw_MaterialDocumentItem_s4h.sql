﻿CREATE VIEW [edw].[vw_MaterialDocumentItem_s4h]
	AS 
SELECT 
  MDI.[MaterialDocumentYear] 
, MDI.[MaterialDocument]
, MDI.[MaterialDocumentItem]
, MDI.[Material] as [MaterialID]
, MDI.[Plant] as [PlantID]
, MDI.[StorageLocation] as [StorageLocationID]
, MDI.[StorageType] as [StorageTypeID]
, MDI.[StorageBin] 
, MDI.[Batch] 
, MDI.[ShelfLifeExpirationDate] 
, MDI.[ManufactureDate] 
, MDI.[Supplier] as [SupplierID]
, MDI.[SalesOrder]
, MDI.[SalesOrderItem] 
, MDI.[SalesOrderScheduleLine] 
, MDI.[WBSElementInternalID] 
, MDI.[Customer] as [CustomerID]
, MDI.[InventorySpecialStockType] as [InventorySpecialStockTypeID]
, MDI.[InventoryStockType] as [InventoryStockTypeID]
, MDI.[StockOwner] 
, MDI.[GoodsMovementType] as [GoodsMovementTypeID]
, MDI.[DebitCreditCode] 
, MDI.[InventoryUsabilityCode] 
, MDI.[QuantityInBaseUnit] 
, MDI.[MaterialBaseUnit] as [MaterialBaseUnitID]
, MDI.[QuantityInEntryUnit] 
, MDI.[EntryUnit] as [EntryUnitID]
, MDI.[PostingDate] as [HDR_PostingDate]
, MDI.[DocumentDate] 
, MDI.[TotalGoodsMvtAmtInCCCrcy] 
, MDI.[CompanyCodeCurrency] 
, MDI.[InventoryValuationType] as [InventoryValuationTypeID]
, MDI.[ReservationIsFinallyIssued]
, MDI.[PurchaseOrder] 
, MDI.[PurchaseOrderItem] 
, MDI.[ProjectNetwork] 
, MDI.[OrderID] as [Order]                      
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
, MDI.[CostCenter] as [CostCenterID]
, MDI.[GLAccount] as [GLAccountID]
, MDI.[ServicePerformer]
, MDI.[EmploymentInternalID] 
, MDI.[AccountAssignmentCategory] 
, MDI.[WorkItem] 
, MDI.[ServicesRenderedDate] 
, MDI.[IssgOrRcvgMaterial] 
, MDI.[CompanyCode] as [CompanyCodeID]
, MDI.[GoodsMovementRefDocType] as [GoodsMovementRefDocTypeID]
, MDI.[IsAutomaticallyCreated]
, MDI.[IsCompletelyDelivered]
, MDI.[IssuingOrReceivingPlant] as [IssuingOrReceivingPlantID]
, MDI.[IssuingOrReceivingStorageLoc] as [IssuingOrReceivingStorageLocID]
, MDI.[BusinessArea] as [BusinessAreaID]
, MDI.[ControllingArea] as [ControllingAreaID]
, MDI.[FiscalYearPeriod]
, MDI.[FiscalYearVariant]
, MDI.[IssgOrRcvgBatch]
, MDI.[IssgOrRcvgSpclStockInd]
, MDI.[MaterialDocumentItemText]
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
, MDI.[GoodsMovementIsCancelled]
, MDI.[GoodsMovementCancellationType]
, MDI.[ConsumptionPosting]
, MDI.[ManufacturingOrder]
, MDI.[ManufacturingOrderItem]
, MDI.[IsReversalMovementType]
, MDI.[t_applicationId]
, MDI.[t_extractionDtm]
, dimPVs.[nk_dim_ProductValuationPUP]                                      AS [nk_dim_ProductValuationPUP]
, dimPVs.[StockPricePerUnit]
, dimPVs.[StockPricePerUnit_EUR]
, dimPVs.[StockPricePerUnit_USD]
, SDT.[SalesDocumentTypeID]
, SDT.[SalesDocumentType] 
, dimSDIC.[SalesDocumentItemCategoryID] 
, dimSDIC.[SalesDocumentItemCategory]
, dimPDT.[PurchasingDocumentTypeID]                                           AS [PurchaseOrderTypeID]
, dimPDT.[PurchasingDocumentTypeName]                                         AS [PurchaseOrderType]
FROM [base_s4h_cax].[I_MaterialDocumentItem] MDI
LEFT JOIN [base_s4h_cax].[I_MaterialDocumentHeader] MDH
  ON 
  MDI.[MaterialDocumentYear]=MDH.[MaterialDocumentYear]
    AND
  MDI.[MaterialDocument]=MDH.[MaterialDocument]
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
    [edw].[dim_SalesDocumentItemCategory] dimSDIC
        ON SDI.[SalesDocumentItemCategoryID] = dimSDIC.[SalesDocumentItemCategoryID]
LEFT JOIN 
    [edw].[fact_PurchasingDocument] dimPD 
        ON 
            MDI.[PurchaseOrder] COLLATE Latin1_General_100_BIN2 = dimPD.[PurchasingDocument] 
LEFT JOIN  
    [edw].[dim_PurchasingDocumentType] dimPDT 
        ON  
            dimPDT.[PurchasingDocumentTypeID]  = dimPD.[PurchasingDocumentTypeID] 
            AND
            dimPDT.[PurchasingDocumentCategoryID]  = dimPD.[PurchasingDocumentCategoryID]
-- WHERE MDI.[MANDT] = 200 MPS 2021/11/01: commented out due to different client values between dev,qas, and prod