CREATE TABLE [edw].[fact_MaterialDocumentItem_temp]
(
	  [MaterialDocumentYear] [char](4) NOT NULL,
	  [MaterialDocument] [nvarchar](10) NOT NULL,
	  [MaterialDocumentItem] [bigint] NOT NULL,
	  [MaterialID] [nvarchar](40) NULL,
	  [PlantID] [nvarchar](5) NULL,
	  [StorageLocationID] [nvarchar](10) NULL,
	  [StorageTypeID] [nvarchar](3) NULL,
	  [StorageBin] [nvarchar](10) NULL,
	  [Batch] [nvarchar](10) NULL,
	  [ShelfLifeExpirationDate] [date] NULL,
	  [ManufactureDate] [date] NULL,
	  [SupplierID] [nvarchar](10) NULL,
	  [SalesOrder] [nvarchar](13) NULL,
	  [SalesOrderItem] [char](12) NULL,
	  [SalesOrderScheduleLine] [char](4) NULL,
	  [WBSElementInternalID] [char](8) NULL,
	  [CustomerID] [nvarchar](10) NULL,
	  [InventorySpecialStockTypeID] [nvarchar](1) NULL,
	  [InventorySpecialStockTypeName] [nvarchar](20) NULL,
	  [InventoryStockTypeID] [nvarchar](2) NULL,
	  [InventoryStockTypeName] [nvarchar](60) NULL,
	  [StockOwner] [nvarchar](10) NULL,
	  [GoodsMovementTypeID] [nvarchar](3) NULL,
	  [GoodsMovementTypeName] [nvarchar](1999) NULL,
	  [DebitCreditCode] [nvarchar](1) NULL,
	  [InventoryUsabilityCode] [nvarchar](1) NULL,
	  [QuantityInBaseUnit] [decimal](13, 3) NULL,
	  [MaterialBaseUnitID] [nvarchar](4) NULL,
	  [QuantityInEntryUnit] [decimal](13, 3) NULL,
	  [EntryUnitID] [nvarchar](3) NULL,
	  [HDR_PostingDate] [date] NULL,
	  [DocumentDate] [date] NULL,
	  [TotalGoodsMvtAmtInCCCrcy] [decimal](13, 2) NULL,
	  [CompanyCodeCurrency] [nchar](5) NULL,
	  [InventoryValuationTypeID] [nvarchar](10) NULL,
	  [ReservationIsFinallyIssued] [nvarchar](1) NULL,
	  [PurchaseOrder] [nvarchar](12) NULL,
	  [PurchaseOrderItem] [nvarchar](12) NULL,
	  [ProjectNetwork] [nvarchar](12) NULL,
	  [Order] [nvarchar](13) NULL,
	  [OrderItem] [nvarchar](12) NULL,
	  [Reservation] [char](10) NULL,
	  [ReservationItem] [char](4) NULL,
	  [DeliveryDocument] [char](10) NULL,
	  [DeliveryDocumentItem] [char](6) NULL,
	  [ReversedMaterialDocumentYear] [char](4) NULL,
	  [ReversedMaterialDocument] [nvarchar](10) NULL,
	  [ReversedMaterialDocumentItem] [char](4) NULL,
	  [RvslOfGoodsReceiptIsAllowed] [nvarchar](1) NULL,
	  [GoodsRecipientName] [nvarchar](12) NULL,
	  [UnloadingPointName] [nvarchar](25) NULL,
	  [CostCenterID] [nvarchar](10) NULL,
	  [GLAccountID] [nvarchar](10) NULL,
	  [ServicePerformer] [nvarchar](10) NULL,
	  [EmploymentInternalID] [char](8) NULL,
	  [AccountAssignmentCategory] [nvarchar](1) NULL,
	  [WorkItem] [nvarchar](10) NULL,
	  [ServicesRenderedDate] [date] NULL,
	  [IssgOrRcvgMaterial] [nvarchar](40) NULL,
	  [CompanyCodeID] [nvarchar](4) NULL,
	  [GoodsMovementRefDocTypeID] [nvarchar](1) NULL,
	  [IsAutomaticallyCreated] [nvarchar](1) NULL,
	  [IsCompletelyDelivered] [nvarchar](50) NULL,
	  [IssuingOrReceivingPlantID] [nvarchar](4) NULL,
	  [IssuingOrReceivingStorageLocID] [nvarchar](4) NULL,
	  [BusinessAreaID] [nvarchar](4) NULL,
	  [ControllingAreaID] [nvarchar](4) NULL,
	  [FiscalYearPeriod] [char](7) NULL,
	  [FiscalYearVariant] [char](2) NULL,
	  [IssgOrRcvgBatch] [nvarchar](10) NULL,
	  [IssgOrRcvgSpclStockInd] [nvarchar](1) NULL,
	  [MaterialDocumentItemText] [nvarchar](50) NULL,
	  [CurrencyTypeID] [char](2) NULL,
	  [HDR_AccountingDocumentTypeID] [nvarchar](2) NULL,
	  [HDR_InventoryTransactionTypeID] [nvarchar](2) NULL,
	  [HDR_CreatedByUser] [nvarchar](12) NULL,
	  [HDR_CreationDate] [date] NULL,
	  [HDR_CreationTime] [time](0) NULL,
	  [HDR_MaterialDocumentHeaderText] [nvarchar](25) NULL,
	  [HDR_ReferenceDocument] [nvarchar](16) NULL,
	  [HDR_BillOfLading] [nvarchar](16) NULL,
	  [SalesDocumentTypeID] [nvarchar](4) NULL,
	  [SalesDocumentType] [nvarchar](20) NULL,
	  [SalesDocumentItemCategoryID] [nvarchar](8) NULL,
	  [SalesDocumentItemCategory] [nvarchar](120) NULL,
	  [HDR_DeliveryDocumentTypeID] [nvarchar](4) NULL,
	  [MatlStkChangeQtyInBaseUnit] [decimal](31, 14) NULL,
	  [ConsumptionQtyICPOInBaseUnit] [decimal](31, 14) NULL,
	  [ConsumptionQtyOBDProInBaseUnit] [decimal](31, 14) NULL,
	  [ConsumptionQtySOInBaseUnit] [decimal](31, 14) NULL,
	  [MatlCnsmpnQtyInMatlBaseUnit] [decimal](31, 14) NULL,
	  [GoodsReceiptQtyInOrderUnit] [decimal](13, 3) NULL,
	  [GoodsMovementIsCancelled] [nvarchar](1) NULL,
	  [GoodsMovementCancellationType] [nvarchar](1) NULL,
	  [ConsumptionPosting] [nvarchar](1) NULL,
	  [ManufacturingOrder] [char](13) NULL,
	  [ManufacturingOrderItem] [nvarchar](12) NULL,
	  [IsReversalMovementType] [nvarchar](1) NULL,
	  [ConsumptionQtySTOInBaseUnit] [decimal](31, 14) NULL,
	  [PurchaseOrderTypeID] [nvarchar](4) NULL,
	  [PurchaseOrderType] [nvarchar](20) NULL,
	  [nk_dim_ProductValuationPUP] [nvarchar](54) NULL,
	  [StockPricePerUnit] [decimal](15, 4) NULL,
	  [StockPricePerUnit_EUR] [decimal](15, 4) NULL,
	  [StockPricePerUnit_USD] [decimal](15, 4) NULL,
	  [ConsumptionQtyICPOInStandardValue] [decimal](38, 9) NULL,
	  [ConsumptionQtyICPOInStandardValue_EUR] [decimal](38, 9) NULL,
	  [ConsumptionQtyICPOInStandardValue_USD] [decimal](38, 9) NULL,
	  [ConsumptionQtyOBDProStandardValue] [decimal](38, 9) NULL,
	  [ConsumptionQtyOBDProStandardValue_EUR] [decimal](38, 9) NULL,
	  [ConsumptionQtyOBDProStandardValue_USD] [decimal](38, 9) NULL,
	  [ConsumptionQtySOStandardValue] [decimal](38, 9) NULL,
	  [ConsumptionQtySOStandardValue_EUR] [decimal](38, 9) NULL,
	  [ConsumptionQtySOStandardValue_USD] [decimal](38, 9) NULL,
	  [MatlStkChangeStandardValue] [decimal](38, 9) NULL,
	  [MatlStkChangeStandardValue_EUR] [decimal](38, 9) NULL,
	  [MatlStkChangeStandardValue_USD] [decimal](38, 9) NULL,
	  [QuantityInBaseUnitStandardValue] [decimal](29, 7) NULL,
	  [QuantityInBaseUnitStandardValue_EUR] [decimal](29, 7) NULL,
	  [QuantityInBaseUnitStandardValue_USD] [decimal](29, 7) NULL,
	  [StandardPricePerUnit] [decimal](38, 16) NULL,
	  [StandardPricePerUnit_EUR] [decimal](38, 16) NULL,
	  [PriceControlIndicatorID] [nvarchar](1) NULL,
	  [PriceControlIndicator] [nvarchar](25) NULL,
      [t_applicationId]                           VARCHAR(32),
      [t_extractionDtm]                           DATETIME,
      [t_jobId]                                   VARCHAR(36),
      [t_jobDtm]                                  DATETIME,
      [t_lastActionCd]                            VARCHAR(1),
      [t_jobBy]                                   VARCHAR(128),
    CONSTRAINT [PK_fact_MaterialDocumentItem_temp] PRIMARY KEY NONCLUSTERED (
        [MaterialDocumentYear],
        [MaterialDocument],
        [MaterialDocumentItem]
    )  NOT ENFORCED
)
    WITH (DISTRIBUTION = HASH ([MaterialDocument]), CLUSTERED COLUMNSTORE INDEX )