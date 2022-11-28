﻿CREATE TABLE [edw].[fact_MaterialDocumentItem]
(
    [_hash]                           nvarchar(32) NOT NULL,
    [MaterialDocumentYear]            char(4)      NOT NULL,
    [MaterialDocument]                nvarchar(10) NOT NULL,
    [MaterialDocumentItem]            char(10)      NOT NULL,
    [MaterialID]                      nvarchar(40),
    [PlantID]                         nvarchar(8),
    [StorageLocationID]               nvarchar(10),
    [axbi_DataAreaID]                 nvarchar(4),
    [StorageTypeID]                   nvarchar(3),
    [StorageBin]                      nvarchar(10),
    [Batch]                           nvarchar(10),
    [ShelfLifeExpirationDate]         date,
    [ManufactureDate]                 date,
    [SupplierID]                      nvarchar(10),
    [SalesOrder]                      nvarchar(14),
    [SalesOrderItem]                  nvarchar(12),
    [SalesOrderScheduleLine]          char(4),
    [WBSElementInternalID]            char(8),
    [CustomerID]                      nvarchar(10),
    [InventorySpecialStockTypeID]     nvarchar(1),
    [InventoryStockTypeID]            nvarchar(2),
    [StockOwner]                      nvarchar(10),
    [GoodsMovementTypeID]             nvarchar(3),
    [DebitCreditCode]                 nvarchar(1),
    [InventoryUsabilityCode]          nvarchar(1),
    [QuantityInBaseUnit]              decimal(13, 3),
    [MaterialBaseUnitID]              nvarchar(3),
    [QuantityInEntryUnit]             decimal(13, 3),
    [EntryUnitID]                     nvarchar(3),
    [HDR_PostingDate]                 date,
    [DocumentDate]                    date,
    [TotalGoodsMvtAmtInCCCrcy]        decimal(13, 2),
    [CompanyCodeCurrency]             nchar(5),
    [InventoryValuationTypeID]        nvarchar(10),
    [ReservationIsFinallyIssued]      nvarchar(1),
    [PurchaseOrder]                   nvarchar(14),
    [PurchaseOrderItem]               nvarchar(12),
    [ProjectNetwork]                  nvarchar(12),
    [Order]                           nvarchar(14),
    [OrderItem]                       nvarchar(12),
    [SalesDocumentItemCategoryID]     nvarchar(8),
    [SalesDocumentItemCategory]       nvarchar(120),
    [Reservation]                     char(10),
    [ReservationItem]                 char(4),
    [DeliveryDocument]                char(10),
    [DeliveryDocumentItem]            char(6),
    [ReversedMaterialDocumentYear]    char(4),
    [ReversedMaterialDocument]        nvarchar(10),
    [ReversedMaterialDocumentItem]    char(4),
    [RvslOfGoodsReceiptIsAllowed]     nvarchar(1),
    [GoodsRecipientName]              nvarchar(12),
    [UnloadingPointName]              nvarchar(25),
    [CostCenterID]                    nvarchar(10),
    [GLAccountID]                     nvarchar(10),
    [ServicePerformer]                nvarchar(10),
    [EmploymentInternalID]            char(8),
    [AccountAssignmentCategory]       nvarchar(1),
    [WorkItem]                        nvarchar(10),
    [ServicesRenderedDate]            date,
    [IssgOrRcvgMaterial]              nvarchar(40),
    [CompanyCodeID]                   nvarchar(4),
    [GoodsMovementRefDocTypeID]       nvarchar(1),
    [IsAutomaticallyCreated]          nvarchar(1),
    [IsCompletelyDelivered]           nvarchar(50),
    [IssuingOrReceivingPlantID]       nvarchar(4),
    [IssuingOrReceivingStorageLocID]  nvarchar(4),
    [BusinessAreaID]                  nvarchar(4),
    [ControllingAreaID]               nvarchar(4),
    [FiscalYearPeriod]                char(7),
    [FiscalYearVariant]               char(2),
    [IssgOrRcvgBatch]                 nvarchar(10),
    [IssgOrRcvgSpclStockInd]          nvarchar(1),
    [MaterialDocumentItemText]        nvarchar(50),
    [CurrencyTypeID]                  CHAR(2),
    [HDR_AccountingDocumentTypeID]    nvarchar(2),
    [HDR_InventoryTransactionTypeID]  nvarchar(2),
    [HDR_CreatedByUser]               nvarchar(12),
    [HDR_CreationDate]                date,
    [HDR_CreationTime]                time(0),
    [HDR_MaterialDocumentHeaderText]  nvarchar(25),
    [HDR_ReferenceDocument]           nvarchar(16),
    [HDR_BillOfLading]                nvarchar(16),
    [MatlStkChangeQtyInBaseUnit]      decimal(31, 14),
    [ConsumptionQtyICPOInBaseUnit]    decimal(31, 14),
    [ConsumptionQtyOBDProInBaseUnit]  decimal(31, 14),
    [ConsumptionQtySOInBaseUnit]      decimal(31, 14),
    [MatlCnsmpnQtyInMatlBaseUnit]     decimal(31, 14),
    [GoodsReceiptQtyInOrderUnit]      decimal(13, 3),
    [GoodsMovementIsCancelled]        nvarchar(1),
    [GoodsMovementCancellationType]   nvarchar(1),
    [ConsumptionPosting]              nvarchar(1),
    [ManufacturingOrder]              nvarchar(14),
    [ManufacturingOrderItem]          nvarchar(12),
    [IsReversalMovementType]          nvarchar(1),
    [nk_dim_ProductValuationPUP]      nvarchar(54),
    [StockPricePerUnit]               decimal(38,6),
    [StockPricePerUnit_EUR]           decimal(38,6),
    [StockPricePerUnit_USD]           decimal(38,6),
    [SalesDocumentTypeID]             nvarchar(4),
    [SalesDocumentType]               nvarchar(20),
    [PurchaseOrderTypeID]             nvarchar(4),
    [PurchaseOrderType]               nvarchar(20),
    [HDR_DeliveryDocumentTypeID]      nvarchar(4),               
    [GoodsMovementTypeName]           nvarchar(20),
    [MatlStkChangeStandardValue]      decimal(38,6),
    [MatlStkChangeStandardValue_EUR]  decimal(38,6),
    [MatlStkChangeStandardValue_USD]  decimal(38,6),
    [ConsumptionQtyICPOInStandardValue]         decimal(38,6),
    [ConsumptionQtyICPOInStandardValue_EUR]     decimal(38,6),
    [ConsumptionQtyICPOInStandardValue_USD]     decimal(38,6),
    [QuantityInBaseUnitStandardValue]           decimal(38,6),
    [QuantityInBaseUnitStandardValue_EUR]       decimal(38,6),
    [QuantityInBaseUnitStandardValue_USD]       decimal(38,6),
    [ConsumptionQtyOBDProStandardValue]         decimal(38,6),
    [ConsumptionQtyOBDProStandardValue_EUR]     decimal(38,6),
    [ConsumptionQtyOBDProStandardValue_USD]     decimal(38,6),
    [ConsumptionQtySOStandardValue]             decimal(38,6),
    [ConsumptionQtySOStandardValue_EUR]         decimal(38,6),
    [ConsumptionQtySOStandardValue_USD]         decimal(38,6),
    [InventorySpecialStockTypeName]             nvarchar(20),
    [InventoryStockTypeName]                    nvarchar(60),
    [PriceControlIndicatorID]                   nvarchar(1),
    [PriceControlIndicator]                     nvarchar(25),
    [StandardPricePerUnit]                      decimal(38,6),
    [StandardPricePerUnit_EUR]                  decimal(38,6),
    [StandardPricePerUnit_USD]                  decimal(38,6),
    [ConsumptionQty]                            decimal(38,6),
    [LatestPricePerPiece_Local]                 decimal(38,6),
    [LatestPricePerPiece_EUR]                   decimal(38,6),
    [LatestPricePerPiece_USD]                   decimal(38,6),
    [ConsumptionValueByLatestPriceInBaseValue]  decimal(38,6),
    [ConsumptionValueByLatestPrice_EUR]         decimal(38,6),        
    [ConsumptionValueByLatestPrice_USD]         decimal(38,6), 
    [t_applicationId]                           VARCHAR(32),
    [t_extractionDtm]                           DATETIME,
    [t_jobId]                                   VARCHAR(36),
    [t_jobDtm]                                  DATETIME,
    [t_lastActionCd]                            varchar(1),
    [t_jobBy]                                   VARCHAR(128),
    CONSTRAINT [PK_fact_MaterialDocumentItem] PRIMARY KEY NONCLUSTERED (
        [MaterialDocumentYear],
        [MaterialDocument],
        [MaterialDocumentItem]
    ) NOT ENFORCED
)
WITH ( DISTRIBUTION = HASH ([MaterialDocument]), CLUSTERED COLUMNSTORE INDEX )