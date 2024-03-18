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

CREATE TABLE [base_s4h_cax].[Z_I_MaterialDocumentItem] (
    
    [MANDT] CHAR(3) collate Latin1_General_100_BIN2 NOT NULL  -- Client
  , [MaterialDocumentYear] CHAR(4) collate Latin1_General_100_BIN2 NOT NULL  -- Material Document Year
  , [MaterialDocument] NVARCHAR(10) collate Latin1_General_100_BIN2 NOT NULL  -- Number of Material Document
  , [MaterialDocumentItem] CHAR(4) collate Latin1_General_100_BIN2 NOT NULL  -- Material Document Item
  , [Material] NVARCHAR(40) collate Latin1_General_100_BIN2  -- Material Number
  , [Plant] NVARCHAR(4)  collate Latin1_General_100_BIN2 -- Plant
  , [StorageLocation] NVARCHAR(4)  collate Latin1_General_100_BIN2 -- Storage Location
  , [StorageType] NVARCHAR(3)  collate Latin1_General_100_BIN2 -- Storage Type
  , [StorageBin] NVARCHAR(10) collate Latin1_General_100_BIN2  -- Storage Bin
  , [Batch] NVARCHAR(10) collate Latin1_General_100_BIN2  -- Batch Number
  , [ShelfLifeExpirationDate] DATE  -- Shelf Life Expiration or Best-Before Date
  , [ManufactureDate] DATE  -- Date of Manufacture
  , [Supplier] NVARCHAR(10) collate Latin1_General_100_BIN2  -- Vendor's account number
  , [SalesOrder] NVARCHAR(10) collate Latin1_General_100_BIN2  -- Sales Order Number
  , [SalesOrderItem] CHAR(6) collate Latin1_General_100_BIN2  -- Sales Order Item
  , [SalesOrderScheduleLine] CHAR(4) collate Latin1_General_100_BIN2  -- Sales Order Schedule
  , [WBSElementInternalID] CHAR(24) collate Latin1_General_100_BIN2   -- WBS Element Internal ID
  , [Customer] NVARCHAR(10) collate Latin1_General_100_BIN2  -- Account number of customer
  , [InventorySpecialStockType] NVARCHAR(1)  collate Latin1_General_100_BIN2 -- Special Stock Type
  , [InventoryStockType] NVARCHAR(2)  collate Latin1_General_100_BIN2 -- Stock Type of Goods Movement (Stock Identifier)
  , [StockOwner] NVARCHAR(10) collate Latin1_General_100_BIN2  -- Additional Supplier for Special Stock
  , [GoodsMovementType] NVARCHAR(3)  collate Latin1_General_100_BIN2 -- Movement Type (Inventory Management)
  , [DebitCreditCode] NVARCHAR(1)  collate Latin1_General_100_BIN2 -- Debit/Credit Indicator
  , [InventoryUsabilityCode] NVARCHAR(1)  collate Latin1_General_100_BIN2 -- Posting Control Stock Type
  , [QuantityInBaseUnit] DECIMAL(13,3)  -- Quantity
  , [MaterialBaseUnit] NVARCHAR(3)  collate Latin1_General_100_BIN2 -- Base Unit of Measure
  , [QuantityInEntryUnit] DECIMAL(13,3)  -- Quantity in unit of entry
  , [EntryUnit] NVARCHAR(3)  collate Latin1_General_100_BIN2 -- Unit of entry
  , [PostingDate] DATE  -- Posting Date in the Document
  , [DocumentDate] DATE  -- Document Date in Document
  , [TotalGoodsMvtAmtInCCCrcy] DECIMAL(13,2)  -- Amount in Local Currency
  , [CompanyCodeCurrency] CHAR(5) collate Latin1_General_100_BIN2  -- Company Code Currency
  , [InventoryValuationType] NVARCHAR(10) collate Latin1_General_100_BIN2  -- Valuation Type
  , [ReservationIsFinallyIssued] NVARCHAR(1)  collate Latin1_General_100_BIN2 -- Final Issue for Reservation
  , [PurchaseOrder] NVARCHAR(10) collate Latin1_General_100_BIN2  -- Purchase order number
  , [PurchaseOrderItem] CHAR(5) collate Latin1_General_100_BIN2  -- Item Number of Purchasing Document
  , [ProjectNetwork] NVARCHAR(12) collate Latin1_General_100_BIN2  -- Network Number for Account Assignment
  , [OrderID] NVARCHAR(12) collate Latin1_General_100_BIN2  -- Order Number
  , [OrderItem] CHAR(4) collate Latin1_General_100_BIN2  -- Order Item
  , [Reservation] CHAR(10) collate Latin1_General_100_BIN2   -- Number of reservation/dependent requirements
  , [ReservationItem] CHAR(4) collate Latin1_General_100_BIN2  -- Item Number of Reservation / Dependent Requirements
  , [DeliveryDocument] NVARCHAR(10) collate Latin1_General_100_BIN2  -- Delivery
  , [DeliveryDocumentItem] CHAR(6) collate Latin1_General_100_BIN2  -- Delivery Document Item
  , [ReversedMaterialDocumentYear] CHAR(4) collate Latin1_General_100_BIN2  -- Reversed Material Document Year
  , [ReversedMaterialDocument] NVARCHAR(10) collate Latin1_General_100_BIN2  -- Reversed Material Document
  , [ReversedMaterialDocumentItem] CHAR(4) collate Latin1_General_100_BIN2  -- Reversed Material Document Item
  , [RvslOfGoodsReceiptIsAllowed] NVARCHAR(1)  collate Latin1_General_100_BIN2 -- Reversal of GR allowed for GR-based IV despite invoice
  , [GoodsRecipientName] NVARCHAR(12) collate Latin1_General_100_BIN2  -- Goods Recipient
  , [UnloadingPointName] NVARCHAR(25) collate Latin1_General_100_BIN2  -- Unloading Point
  , [CostCenter] NVARCHAR(10) collate Latin1_General_100_BIN2  -- Cost Center
  , [GLAccount] NVARCHAR(10) collate Latin1_General_100_BIN2  -- G/L Account Number
  , [ServicePerformer] NVARCHAR(10) collate Latin1_General_100_BIN2  -- Service Performer
  , [EmploymentInternalID] CHAR(8) collate Latin1_General_100_BIN2  -- Employment ID (Deprecated)
  , [PersonWorkAgreement] CHAR(8) collate Latin1_General_100_BIN2  -- Personnel Number
  , [AccountAssignmentCategory] NVARCHAR(1)  collate Latin1_General_100_BIN2 -- Account Assignment Category
  , [WorkItem] NVARCHAR(10) collate Latin1_General_100_BIN2  -- Work Item ID
  , [ServicesRenderedDate] DATE  -- Date on which services are rendered
  , [IssgOrRcvgMaterial] NVARCHAR(40) collate Latin1_General_100_BIN2  -- Transfer Material
  , [IssuingOrReceivingPlant] NVARCHAR(4)  collate Latin1_General_100_BIN2 -- Transfer Plant
  , [IssuingOrReceivingStorageLoc] NVARCHAR(4)  collate Latin1_General_100_BIN2 -- Receiving/issuing storage location
  , [IssgOrRcvgBatch] NVARCHAR(10) collate Latin1_General_100_BIN2  -- Transfer Batch
  , [IssgOrRcvgSpclStockInd] NVARCHAR(1)  collate Latin1_General_100_BIN2 -- Special Stock Indicator
  , [CompanyCode] NVARCHAR(4)  collate Latin1_General_100_BIN2 -- Company Code
  , [BusinessArea] NVARCHAR(4)  collate Latin1_General_100_BIN2 -- Business Area
  , [ControllingArea] NVARCHAR(4)  collate Latin1_General_100_BIN2 -- Controlling Area
  , [FiscalYearPeriod] CHAR(7) collate Latin1_General_100_BIN2  -- Period Year
  , [FiscalYearVariant] NVARCHAR(2)  collate Latin1_General_100_BIN2 -- Fiscal Year Variant
  , [GoodsMovementRefDocType] NVARCHAR(1)  collate Latin1_General_100_BIN2 -- Goods movement ref doc type
  , [IsCompletelyDelivered] NVARCHAR(1)  collate Latin1_General_100_BIN2 -- "Delivery Completed" Indicator
  , [MaterialDocumentItemText] NVARCHAR(50) collate Latin1_General_100_BIN2  -- Item Text
  , [IsAutomaticallyCreated] NVARCHAR(1)  collate Latin1_General_100_BIN2 -- Item Automatically Created Indicator
  , [GoodsReceiptType] NVARCHAR(1)  collate Latin1_General_100_BIN2 -- Receipt Indicator
  , [ConsumptionPosting] NVARCHAR(1)  collate Latin1_General_100_BIN2 -- Consumption posting
  , [MultiAcctAssgmtOriglMatlDocItm] CHAR(4) collate Latin1_General_100_BIN2  -- Original Line for Account Assignment Item in Material Doc.
  , [HasMultipleAccountAssignment] NVARCHAR(1)  collate Latin1_General_100_BIN2 -- Multiple Account Assignment
  , [MatlStkChangeQtyInBaseUnit] DECIMAL(31,14)  -- Stock Quantity
  , [MatlCnsmpnQtyInMatlBaseUnit] DECIMAL(31,14)  -- Consumption Quantity
  , [GoodsReceiptQtyInOrderUnit] DECIMAL(13,3)  -- Goods receipt quantity in order unit
  , [GoodsMovementIsCancelled] NVARCHAR(1)  collate Latin1_General_100_BIN2 -- Item has been Cancelled
  , [GoodsMovementCancellationType] NVARCHAR(1)  collate Latin1_General_100_BIN2 -- Relevance for Analytics
  , [ManufacturingOrder] NVARCHAR(12) collate Latin1_General_100_BIN2  -- Manufacturing Order
  , [ManufacturingOrderItem] CHAR(4) collate Latin1_General_100_BIN2  -- Manufacturing Order Item
  , [IsReversalMovementType] NVARCHAR(1)  collate Latin1_General_100_BIN2 -- Has Reversal Movement Type
  , [MaterialDocumentRecordType] NVARCHAR(9)  collate Latin1_General_100_BIN2--Material Document Type Indicator
  , [t_applicationId] VARCHAR (32)  -- Application ID
  , [t_jobId] VARCHAR (36)  -- Job ID
  , [t_jobDtm] DATETIME  -- Job Date Time
  , [t_jobBy] VARCHAR (128)  -- Job executed by
  , [t_extractionDtm] DATETIME  -- Extraction Date Time
  , [t_filePath] NVARCHAR (1024)  -- Filepath
  , CONSTRAINT [PK_Z_I_MaterialDocumentItem] PRIMARY KEY NONCLUSTERED(
      [MANDT]
    , [MaterialDocumentYear]
    , [MaterialDocument]
    , [MaterialDocumentItem]
    , [MaterialDocumentRecordType]
  ) NOT ENFORCED
) WITH (
  HEAP
)
