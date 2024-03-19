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
    [MANDT]                         nchar(3) collate Latin1_General_100_BIN2     NOT NULL,
    [MaterialDocumentYear]          char(4) collate Latin1_General_100_BIN2      NOT NULL,
    [MaterialDocument]              nvarchar(10) collate Latin1_General_100_BIN2 NOT NULL,
    [MaterialDocumentItem]          char(4) collate Latin1_General_100_BIN2      NOT NULL,
    [Material]                      nvarchar(40) collate Latin1_General_100_BIN2,
    [Plant]                         nvarchar(4) collate Latin1_General_100_BIN2,
    [StorageLocation]               nvarchar(4) collate Latin1_General_100_BIN2,
    [StorageType]                   nvarchar(3) collate Latin1_General_100_BIN2,
    [StorageBin]                    nvarchar(10) collate Latin1_General_100_BIN2,
    [Batch]                         nvarchar(10) collate Latin1_General_100_BIN2,
    [ShelfLifeExpirationDate]       date,
    [ManufactureDate]               date,
    [Supplier]                      nvarchar(10) collate Latin1_General_100_BIN2,
    [SalesOrder]                    nvarchar(10) collate Latin1_General_100_BIN2,
    [SalesOrderItem]                char(6) collate Latin1_General_100_BIN2,
    [SalesOrderScheduleLine]        char(4) collate Latin1_General_100_BIN2,
    [WBSElementInternalID]          char(8) collate Latin1_General_100_BIN2,
    [Customer]                      nvarchar(10) collate Latin1_General_100_BIN2,
    [InventorySpecialStockType]     nvarchar(1) collate Latin1_General_100_BIN2,
    [InventoryStockType]            nvarchar(2) collate Latin1_General_100_BIN2,
    [StockOwner]                    nvarchar(10) collate Latin1_General_100_BIN2,
    [GoodsMovementType]             nvarchar(3) collate Latin1_General_100_BIN2,
    [DebitCreditCode]               nvarchar(1) collate Latin1_General_100_BIN2,
    [InventoryUsabilityCode]        nvarchar(1) collate Latin1_General_100_BIN2,
    [QuantityInBaseUnit]            decimal(13, 3),
    [MaterialBaseUnit]              nvarchar(3) collate Latin1_General_100_BIN2,
    [QuantityInEntryUnit]           decimal(13, 3),
    [EntryUnit]                     nvarchar(3) collate Latin1_General_100_BIN2,
    [PostingDate]                   date,
    [DocumentDate]                  date,
    [TotalGoodsMvtAmtInCCCrcy]      decimal(13, 2),
    [CompanyCodeCurrency]           nchar(5) collate Latin1_General_100_BIN2,
    [InventoryValuationType]        nvarchar(10) collate Latin1_General_100_BIN2,
    [ReservationIsFinallyIssued]    nvarchar(1) collate Latin1_General_100_BIN2,
    [PurchaseOrder]                 nvarchar(10) collate Latin1_General_100_BIN2,
    [PurchaseOrderItem]             char(5) collate Latin1_General_100_BIN2,
    [ProjectNetwork]                nvarchar(12) collate Latin1_General_100_BIN2,
    [OrderID]                       nvarchar(12) collate Latin1_General_100_BIN2,
    [OrderItem]                     char(4) collate Latin1_General_100_BIN2,
    [Reservation]                   char(10) collate Latin1_General_100_BIN2,
    [ReservationItem]               char(4) collate Latin1_General_100_BIN2,
    [DeliveryDocument]              nvarchar(10) collate Latin1_General_100_BIN2,
    [DeliveryDocumentItem]          char(6) collate Latin1_General_100_BIN2,
    [ReversedMaterialDocumentYear]  char(4) collate Latin1_General_100_BIN2,
    [ReversedMaterialDocument]      nvarchar(10) collate Latin1_General_100_BIN2,
    [ReversedMaterialDocumentItem]  char(4) collate Latin1_General_100_BIN2,
    [RvslOfGoodsReceiptIsAllowed]   nvarchar(1) collate Latin1_General_100_BIN2,
    [GoodsRecipientName]            nvarchar(12) collate Latin1_General_100_BIN2,
    [UnloadingPointName]            nvarchar(25) collate Latin1_General_100_BIN2,
    [CostCenter]                    nvarchar(10) collate Latin1_General_100_BIN2,
    [GLAccount]                     nvarchar(10) collate Latin1_General_100_BIN2,
    [ServicePerformer]              nvarchar(10) collate Latin1_General_100_BIN2,
    [EmploymentInternalID]          char(8) collate Latin1_General_100_BIN2,
    [AccountAssignmentCategory]     nvarchar(1) collate Latin1_General_100_BIN2,
    [WorkItem]                      nvarchar(10) collate Latin1_General_100_BIN2,
    [ServicesRenderedDate]          date,
    [IssgOrRcvgMaterial]            nvarchar(40) collate Latin1_General_100_BIN2,
    [IssuingOrReceivingPlant]       nvarchar(4) collate Latin1_General_100_BIN2,
    [IssuingOrReceivingStorageLoc]  nvarchar(4) collate Latin1_General_100_BIN2,
    [IssgOrRcvgBatch]               nvarchar(10) collate Latin1_General_100_BIN2,
    [IssgOrRcvgSpclStockInd]        nvarchar(1) collate Latin1_General_100_BIN2,
    [CompanyCode]                   nvarchar(4) collate Latin1_General_100_BIN2,
    [BusinessArea]                  nvarchar(4) collate Latin1_General_100_BIN2,
    [ControllingArea]               nvarchar(4) collate Latin1_General_100_BIN2,
    [FiscalYearPeriod]              char(7) collate Latin1_General_100_BIN2,
    [FiscalYearVariant]             nvarchar(2) collate Latin1_General_100_BIN2,
    [GoodsMovementRefDocType]       nvarchar(1) collate Latin1_General_100_BIN2,
    [IsCompletelyDelivered]         nvarchar(1) collate Latin1_General_100_BIN2,
    [MaterialDocumentItemText]      nvarchar(50) collate Latin1_General_100_BIN2,
    [IsAutomaticallyCreated]        nvarchar(1) collate Latin1_General_100_BIN2,
    [MatlStkChangeQtyInBaseUnit]    decimal(31, 14),
    [MatlCnsmpnQtyInMatlBaseUnit]   decimal(31, 14),
    [GoodsReceiptQtyInOrderUnit]    decimal(13, 3),
    [GoodsMovementIsCancelled]      nvarchar(1) collate Latin1_General_100_BIN2,
    [GoodsMovementCancellationType] nvarchar(1) collate Latin1_General_100_BIN2,
    [ConsumptionPosting]            nvarchar(1) collate Latin1_General_100_BIN2,
    [ManufacturingOrder]            char(12) collate Latin1_General_100_BIN2,
    [ManufacturingOrderItem]        nvarchar(4) collate Latin1_General_100_BIN2,
    [IsReversalMovementType]        nvarchar(1) collate Latin1_General_100_BIN2,
    [MaterialDocumentRecordType]    nvarchar(9) collate Latin1_General_100_BIN2,
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
