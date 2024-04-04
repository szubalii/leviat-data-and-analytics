CREATE VIEW [edw].[vw_MaterialDocumentItem_MDOC_CP]
AS
WITH MatDocMDOC AS
(
--Get the Material Document Items from I_MaterialDocumentItem with DocumentType MDOC.
SELECT 
    [MANDT]    
  , [MaterialDocumentYear]    
  , [MaterialDocument]    
  , [MaterialDocumentItem]    
  , edw.svf_get3PartNaturalKey (MaterialDocumentYear, MaterialDocument, MaterialDocumentItem) AS [nk_MaterialDocumentItem]
  , [Material]   
  , [Plant]  
  , [StorageLocation]  
  , [StorageType]  
  , [StorageBin]   
  , [Batch]   
  , [ShelfLifeExpirationDate]  
  , [ManufactureDate]  
  , [Supplier]   
  , [SalesOrder]   
  , [SalesOrderItem]   
  , [SalesOrderScheduleLine]   
  , [WBSElementInternalID]   
  , [Customer]   
  , [InventorySpecialStockType]  
  , [InventoryStockType]  
  , [StockOwner]   
  , [GoodsMovementType]  
  , [DebitCreditCode]  
  , [InventoryUsabilityCode]  
  , [QuantityInBaseUnit]   
  , [MaterialBaseUnit]  
  , [QuantityInEntryUnit]   
  , [EntryUnit]  
  , [PostingDate]  
  , [DocumentDate]  
  , [TotalGoodsMvtAmtInCCCrcy]   
  , [CompanyCodeCurrency]   
  , [InventoryValuationType]   
  , [ReservationIsFinallyIssued]  
  , [PurchaseOrder]   
  , [PurchaseOrderItem]   
  , [ProjectNetwork]   
  , [OrderID]   
  , [OrderItem]   
  , [Reservation]   
  , [ReservationItem]   
  , [DeliveryDocument]   
  , [DeliveryDocumentItem]   
  , [ReversedMaterialDocumentYear]   
  , [ReversedMaterialDocument]   
  , [ReversedMaterialDocumentItem]   
  , [RvslOfGoodsReceiptIsAllowed]  
  , [GoodsRecipientName]   
  , [UnloadingPointName]   
  , [CostCenter]   
  , [GLAccount]   
  , [ServicePerformer]   
  , [EmploymentInternalID]     
  , [AccountAssignmentCategory]  
  , [WorkItem]   
  , [ServicesRenderedDate]  
  , [IssgOrRcvgMaterial]   
  , [IssuingOrReceivingPlant]  
  , [IssuingOrReceivingStorageLoc]  
  , [IssgOrRcvgBatch]   
  , [IssgOrRcvgSpclStockInd]  
  , [CompanyCode]  
  , [BusinessArea]  
  , [ControllingArea]  
  , [FiscalYearPeriod]   
  , [FiscalYearVariant]  
  , [GoodsMovementRefDocType]  
  , [IsCompletelyDelivered]  
  , [MaterialDocumentItemText]   
  , [IsAutomaticallyCreated]  
  , [ConsumptionPosting]  
  , [MatlStkChangeQtyInBaseUnit]   
  , [MatlCnsmpnQtyInMatlBaseUnit]   
  , [GoodsReceiptQtyInOrderUnit]   
  , [GoodsMovementIsCancelled]  
  , [GoodsMovementCancellationType]  
  , [ManufacturingOrder]   
  , [ManufacturingOrderItem]   
  , [IsReversalMovementType]  
  , 'MDOC' [MaterialDocumentRecordType] 
  , [t_applicationId]   
  , [t_jobId]   
  , [t_jobDtm]  
  , [t_jobBy]   
  , [t_extractionDtm]  
  , [t_filePath]   

FROM [base_s4h_cax].[I_MaterialDocumentItem]
),

MatDocMDOC_CP AS(
--Get the Material Document Items from Z_I_MaterialDocumentItem with DocumentType MDOC_CP.

SELECT 
    [MANDT]    
  , [MaterialDocumentYear]    
  , [MaterialDocument]    
  , [MaterialDocumentItem]    
  , edw.svf_get3PartNaturalKey (MaterialDocumentYear, MaterialDocument, MaterialDocumentItem) AS [nk_MaterialDocumentItem]
  , [Material]   
  , [Plant]  
  , [StorageLocation]  
  , [StorageType]  
  , [StorageBin]   
  , [Batch]   
  , [ShelfLifeExpirationDate]  
  , [ManufactureDate]  
  , [Supplier]   
  , [SalesOrder]   
  , [SalesOrderItem]   
  , [SalesOrderScheduleLine]   
  , [WBSElementInternalID]   
  , [Customer]   
  , [InventorySpecialStockType]  
  , [InventoryStockType]  
  , [StockOwner]   
  , [GoodsMovementType]  
  , [DebitCreditCode]  
  , [InventoryUsabilityCode]  
  , [QuantityInBaseUnit]   
  , [MaterialBaseUnit]  
  , [QuantityInEntryUnit]   
  , [EntryUnit]  
  , [PostingDate]  
  , [DocumentDate]  
  , [TotalGoodsMvtAmtInCCCrcy]   
  , [CompanyCodeCurrency]   
  , [InventoryValuationType]   
  , [ReservationIsFinallyIssued]  
  , [PurchaseOrder]   
  , [PurchaseOrderItem]   
  , [ProjectNetwork]   
  , [OrderID]   
  , [OrderItem]   
  , [Reservation]   
  , [ReservationItem]   
  , [DeliveryDocument]   
  , [DeliveryDocumentItem]   
  , [ReversedMaterialDocumentYear]   
  , [ReversedMaterialDocument]   
  , [ReversedMaterialDocumentItem]   
  , [RvslOfGoodsReceiptIsAllowed]  
  , [GoodsRecipientName]   
  , [UnloadingPointName]   
  , [CostCenter]   
  , [GLAccount]   
  , [ServicePerformer]   
  , [EmploymentInternalID]   
  , [AccountAssignmentCategory]  
  , [WorkItem]   
  , [ServicesRenderedDate]  
  , [IssgOrRcvgMaterial]   
  , [IssuingOrReceivingPlant]  
  , [IssuingOrReceivingStorageLoc]  
  , [IssgOrRcvgBatch]   
  , [IssgOrRcvgSpclStockInd]  
  , [CompanyCode]  
  , [BusinessArea]  
  , [ControllingArea]  
  , [FiscalYearPeriod]   
  , [FiscalYearVariant]  
  , [GoodsMovementRefDocType]  
  , [IsCompletelyDelivered]  
  , [MaterialDocumentItemText]   
  , [IsAutomaticallyCreated]  
  , [ConsumptionPosting]   
  , [MatlStkChangeQtyInBaseUnit]   
  , [MatlCnsmpnQtyInMatlBaseUnit]   
  , [GoodsReceiptQtyInOrderUnit]   
  , [GoodsMovementIsCancelled]  
  , [GoodsMovementCancellationType]  
  , [ManufacturingOrder]   
  , [ManufacturingOrderItem]   
  , [IsReversalMovementType]  
  , [MaterialDocumentRecordType] 
  , [t_applicationId]   
  , [t_jobId]   
  , [t_jobDtm]  
  , [t_jobBy]   
  , [t_extractionDtm]  
  , [t_filePath]   

FROM [base_s4h_cax].[Z_I_MaterialDocumentItem_MDOC_CP]    
)

SELECT *

FROM MatDocMDOC

UNION ALL

SELECT *

FROM MatDocMDOC_CP

