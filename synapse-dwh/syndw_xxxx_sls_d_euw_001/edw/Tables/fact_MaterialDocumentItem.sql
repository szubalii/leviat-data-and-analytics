CREATE TABLE [edw].[fact_MaterialDocumentItem]
( [MaterialDocumentYear] char(4) collate Latin1_General_100_BIN2 NOT NULL
, [MaterialDocument] nvarchar(10) collate Latin1_General_100_BIN2 NOT NULL
, [MaterialDocumentItem] char(4) collate Latin1_General_100_BIN2 NOT NULL
, [MaterialID] nvarchar(40) collate Latin1_General_100_BIN2
, [PlantID] nvarchar(4) collate Latin1_General_100_BIN2
, [StorageLocationID] nvarchar(4) collate Latin1_General_100_BIN2
, [StorageTypeID] nvarchar(3) collate Latin1_General_100_BIN2
, [StorageBin] nvarchar(10) collate Latin1_General_100_BIN2
, [Batch] nvarchar(10) collate Latin1_General_100_BIN2
, [ShelfLifeExpirationDate] date
, [ManufactureDate] date
, [SupplierID] nvarchar(10) collate Latin1_General_100_BIN2
, [SalesOrder] nvarchar(10) collate Latin1_General_100_BIN2
, [SalesOrderItem] char(6) collate Latin1_General_100_BIN2
, [SalesOrderScheduleLine] char(4) collate Latin1_General_100_BIN2
, [WBSElementInternal] char(8) collate Latin1_General_100_BIN2
, [CustomerID] nvarchar(10) collate Latin1_General_100_BIN2
, [InventorySpecialStockTypeID] nvarchar(1) collate Latin1_General_100_BIN2
, [InventoryStockTypeID] nvarchar(2) collate Latin1_General_100_BIN2
, [StockOwner] nvarchar(10) collate Latin1_General_100_BIN2
, [GoodsMovementTypeID] nvarchar(3) collate Latin1_General_100_BIN2
, [DebitCreditCode] nvarchar(1) collate Latin1_General_100_BIN2
, [InventoryUsabilityCode] nvarchar(1) collate Latin1_General_100_BIN2
, [QuantityInBaseUnit] decimal(13,3)
, [MaterialBaseUnitID] nvarchar(3) collate Latin1_General_100_BIN2
, [QuantityInEntryUnit] decimal(13,3)
, [EntryUnitID] nvarchar(3) collate Latin1_General_100_BIN2
, [HDR_PostingDate] date
, [DocumentDate] date
, [TotalGoodsMvtAmtInCCCrcy] decimal(13,2)
, [CompanyCodeCurrency] nchar(5) collate Latin1_General_100_BIN2
, [InventoryValuationTypeID] nvarchar(10) collate Latin1_General_100_BIN2
, [ReservationIsFinallyIssued] nvarchar(1) collate Latin1_General_100_BIN2
, [PurchaseOrder] nvarchar(10) collate Latin1_General_100_BIN2
, [PurchaseOrderItem] char(5) collate Latin1_General_100_BIN2
, [ProjectNetwork] nvarchar(12) collate Latin1_General_100_BIN2
, [Order] nvarchar(12) collate Latin1_General_100_BIN2
, [OrderItem] char(4) collate Latin1_General_100_BIN2
, [Reservation] char(10) collate Latin1_General_100_BIN2
, [ReservationItem] char(4) collate Latin1_General_100_BIN2
, [DeliveryDocument] char(10) collate Latin1_General_100_BIN2
, [DeliveryDocumentItem] char(6) collate Latin1_General_100_BIN2
, [ReversedMaterialDocumentYear] char(4) collate Latin1_General_100_BIN2
, [ReversedMaterialDocument] nvarchar(10) collate Latin1_General_100_BIN2
, [ReversedMaterialDocumentItem] char(4) collate Latin1_General_100_BIN2
, [RvslOfGoodsReceiptIsAllowed] nvarchar(1) collate Latin1_General_100_BIN2
, [GoodsRecipientName] nvarchar(12) collate Latin1_General_100_BIN2
, [UnloadingPointName] nvarchar(25) collate Latin1_General_100_BIN2
, [CostCenterID] nvarchar(10) collate Latin1_General_100_BIN2
, [GLAccountID] nvarchar(10) collate Latin1_General_100_BIN2
, [ServicePerformer] nvarchar(10) collate Latin1_General_100_BIN2
, [EmploymentInternal] char(8) collate Latin1_General_100_BIN2
, [AccountAssignmentCategory] nvarchar(1) collate Latin1_General_100_BIN2
, [WorkItem] nvarchar(10) collate Latin1_General_100_BIN2
, [ServicesRenderedDate] date
, [IssgOrRcvgMaterial] nvarchar(40) collate Latin1_General_100_BIN2
, [CompanyCodeID] nvarchar(4) collate Latin1_General_100_BIN2
, [GoodsMovementRefDocTypeID] nvarchar(1) collate Latin1_General_100_BIN2
, [IsAutomaticallyCreated] nvarchar(1) collate Latin1_General_100_BIN2
, [IsCompletelyDelivered] nvarchar(50) collate Latin1_General_100_BIN2
, [IssuingOrReceivingPlantID] nvarchar(4) collate Latin1_General_100_BIN2
, [IssuingOrReceivingStorageLocID] nvarchar(4) collate Latin1_General_100_BIN2
, [BusinessAreaID] nvarchar(4) collate Latin1_General_100_BIN2
, [ControllingAreaID] nvarchar(4) collate Latin1_General_100_BIN2
, [FiscalYearPeriod] char(7) collate Latin1_General_100_BIN2
, [FiscalYearVariant] char(2) collate Latin1_General_100_BIN2
, [IssgOrRcvgBatch] nvarchar(10) collate Latin1_General_100_BIN2
, [IssgOrRcvgSpclStockInd] nvarchar(1) collate Latin1_General_100_BIN2
, [MaterialDocumentItemText]  nvarchar(50) collate Latin1_General_100_BIN2
, [CurrencyTypeID] CHAR(2) 
, [HDR_AccountingDocumentTypeID] nvarchar(2) collate Latin1_General_100_BIN2
, [HDR_InventoryTransactionType] nvarchar(2) collate Latin1_General_100_BIN2
, [HDR_CreatedByUser] nvarchar(12) collate Latin1_General_100_BIN2
, [HDR_CreationDate] date
, [HDR_CreationTime] time(0)
, [HDR_MaterialDocumentHeaderText] nvarchar(25) collate Latin1_General_100_BIN2
, [HDR_ReferenceDocument] nvarchar(16) collate Latin1_General_100_BIN2
, [HDR_BillOfLading] nvarchar(16) collate Latin1_General_100_BIN2
, [t_applicationId]       VARCHAR (32)
, [t_extractionDtm]       VARCHAR (128)
, [t_jobId]               VARCHAR (36)
, [t_jobDtm]              DATETIME
, [t_lastActionCd]        varchar(1)
, [t_jobBy]               VARCHAR (128)
, CONSTRAINT [PK_fact_MaterialDocumentItem] PRIMARY KEY NONCLUSTERED ([MaterialDocumentYear], [MaterialDocument], [MaterialDocumentItem])  NOT ENFORCED
)
WITH (
    DISTRIBUTION = HASH ([MaterialDocument]), CLUSTERED COLUMNSTORE INDEX
)