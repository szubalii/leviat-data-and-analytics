-- =============================================
-- Schema         : base_s4h_cax
-- CDS View       : Z_I_MaterialDocumentItem
-- System Version : SAP S/4HANA 2022, SP 0001
-- Description    : Data from table ZIMATDOCITEM
-- Source:        : S/4HANA
-- Extraction_Mode: Full
-- Source Type    : Table
-- Source Name    : CAACLNT200

-- =============================================

CREATE TABLE [base_s4h_cax].[Z_I_MaterialDocumentItem_MDOC_CP] (
    [MANDT]                         nchar(3) NOT NULL,
    [MaterialDocumentYear]          char(4) NOT NULL,
    [MaterialDocument]              nvarchar(10) NOT NULL,
    [MaterialDocumentItem]          char(4) NOT NULL,
    [Material]                      nvarchar(40),
    [Plant]                         nvarchar(4),
    [StorageLocation]               nvarchar(4),
    [StorageType]                   nvarchar(3),
    [StorageBin]                    nvarchar(10),
    [Batch]                         nvarchar(10),
    [ShelfLifeExpirationDate]       date,
    [ManufactureDate]               date,
    [Supplier]                      nvarchar(10),
    [SalesOrder]                    nvarchar(10),
    [SalesOrderItem]                char(6),
    [SalesOrderScheduleLine]        char(4),
    [WBSElementInternalID]          char(8),
    [Customer]                      nvarchar(10),
    [InventorySpecialStockType]     nvarchar(1),
    [InventoryStockType]            nvarchar(2),
    [StockOwner]                    nvarchar(10),
    [GoodsMovementType]             nvarchar(3),
    [DebitCreditCode]               nvarchar(1),
    [InventoryUsabilityCode]        nvarchar(1),
    [QuantityInBaseUnit]            decimal(13, 3),
    [MaterialBaseUnit]              nvarchar(3),
    [QuantityInEntryUnit]           decimal(13, 3),
    [EntryUnit]                     nvarchar(3),
    [PostingDate]                   date,
    [DocumentDate]                  date,
    [TotalGoodsMvtAmtInCCCrcy]      decimal(13, 2),
    [CompanyCodeCurrency]           nchar(5),
    [InventoryValuationType]        nvarchar(10),
    [ReservationIsFinallyIssued]    nvarchar(1),
    [PurchaseOrder]                 nvarchar(10),
    [PurchaseOrderItem]             char(5),
    [ProjectNetwork]                nvarchar(12),
    [OrderID]                       nvarchar(12),
    [OrderItem]                     char(4),
    [Reservation]                   char(10),
    [ReservationItem]               char(4),
    [DeliveryDocument]              nvarchar(10),
    [DeliveryDocumentItem]          char(6),
    [ReversedMaterialDocumentYear]  char(4),
    [ReversedMaterialDocument]      nvarchar(10),
    [ReversedMaterialDocumentItem]  char(4),
    [RvslOfGoodsReceiptIsAllowed]   nvarchar(1),
    [GoodsRecipientName]            nvarchar(12),
    [UnloadingPointName]            nvarchar(25),
    [CostCenter]                    nvarchar(10),
    [GLAccount]                     nvarchar(10),
    [ServicePerformer]              nvarchar(10),
    [EmploymentInternalID]          char(8),
    [AccountAssignmentCategory]     nvarchar(1),
    [WorkItem]                      nvarchar(10),
    [ServicesRenderedDate]          date,
    [IssgOrRcvgMaterial]            nvarchar(40),
    [IssuingOrReceivingPlant]       nvarchar(4),
    [IssuingOrReceivingStorageLoc]  nvarchar(4),
    [IssgOrRcvgBatch]               nvarchar(10),
    [IssgOrRcvgSpclStockInd]        nvarchar(1),
    [CompanyCode]                   nvarchar(4),
    [BusinessArea]                  nvarchar(4),
    [ControllingArea]               nvarchar(4),
    [FiscalYearPeriod]              char(7),
    [FiscalYearVariant]             nvarchar(2),
    [GoodsMovementRefDocType]       nvarchar(1),
    [IsCompletelyDelivered]         nvarchar(1),
    [MaterialDocumentItemText]      nvarchar(50),
    [IsAutomaticallyCreated]        nvarchar(1),
    [MatlStkChangeQtyInBaseUnit]    decimal(31, 14),
    [MatlCnsmpnQtyInMatlBaseUnit]   decimal(31, 14),
    [GoodsReceiptQtyInOrderUnit]    decimal(13, 3),
    [GoodsMovementIsCancelled]      nvarchar(1),
    [GoodsMovementCancellationType] nvarchar(1),
    [ConsumptionPosting]            nvarchar(1),
    [ManufacturingOrder]            char(12),
    [ManufacturingOrderItem]        nvarchar(4),
    [IsReversalMovementType]        nvarchar(1),
    [MaterialDocumentRecordType]    nvarchar(9),
    [t_applicationId]               VARCHAR(32),
    [t_jobId]                       VARCHAR(36),
    [t_jobDtm]                      DATETIME,
    [t_jobBy]                       VARCHAR(128),
    [t_extractionDtm]               DATETIME,
    [t_filePath]                    NVARCHAR(1024)
  , CONSTRAINT [PK_Z_I_MaterialDocumentItem_MDOC_CP] PRIMARY KEY NONCLUSTERED(
      [MANDT]
    , [MaterialDocumentYear]
    , [MaterialDocument]
    , [MaterialDocumentItem]
  ) NOT ENFORCED
) WITH (
  HEAP
)
