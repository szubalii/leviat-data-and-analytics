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
    
    [MANDT] CHAR(3) COLLATE DATABASE_DEFAULT NOT NULL  -- Client
  , [MaterialDocumentYear] CHAR(4) COLLATE DATABASE_DEFAULT NOT NULL  -- Material Document Year
  , [MaterialDocument] NVARCHAR(10) COLLATE DATABASE_DEFAULT NOT NULL  -- Number of Material Document
  , [MaterialDocumentItem] CHAR(4) COLLATE DATABASE_DEFAULT NOT NULL  -- Material Document Item
  , [Material] NVARCHAR(40) COLLATE DATABASE_DEFAULT  -- Material Number
  , [Plant] NVARCHAR(4)  COLLATE DATABASE_DEFAULT -- Plant
  , [StorageLocation] NVARCHAR(4)  COLLATE DATABASE_DEFAULT -- Storage Location
  , [StorageType] NVARCHAR(3)  COLLATE DATABASE_DEFAULT -- Storage Type
  , [StorageBin] NVARCHAR(10) COLLATE DATABASE_DEFAULT  -- Storage Bin
  , [Batch] NVARCHAR(10) COLLATE DATABASE_DEFAULT  -- Batch Number
  , [ShelfLifeExpirationDate] DATE  -- Shelf Life Expiration or Best-Before Date
  , [ManufactureDate] DATE  -- Date of Manufacture
  , [Supplier] NVARCHAR(10) COLLATE DATABASE_DEFAULT  -- Vendor's account number
  , [SalesOrder] NVARCHAR(10) COLLATE DATABASE_DEFAULT  -- Sales Order Number
  , [SalesOrderItem] CHAR(6) COLLATE DATABASE_DEFAULT  -- Sales Order Item
  , [SalesOrderScheduleLine] CHAR(4) COLLATE DATABASE_DEFAULT  -- Sales Order Schedule
  , [WBSElementInternalID] CHAR(24) COLLATE DATABASE_DEFAULT   -- WBS Element Internal ID
  , [Customer] NVARCHAR(10) COLLATE DATABASE_DEFAULT  -- Account number of customer
  , [InventorySpecialStockType] NVARCHAR(1)  COLLATE DATABASE_DEFAULT -- Special Stock Type
  , [InventoryStockType] NVARCHAR(2)  COLLATE DATABASE_DEFAULT -- Stock Type of Goods Movement (Stock Identifier)
  , [StockOwner] NVARCHAR(10) COLLATE DATABASE_DEFAULT  -- Additional Supplier for Special Stock
  , [GoodsMovementType] NVARCHAR(3)  COLLATE DATABASE_DEFAULT -- Movement Type (Inventory Management)
  , [DebitCreditCode] NVARCHAR(1)  COLLATE DATABASE_DEFAULT -- Debit/Credit Indicator
  , [InventoryUsabilityCode] NVARCHAR(1)  COLLATE DATABASE_DEFAULT -- Posting Control Stock Type
  , [QuantityInBaseUnit] DECIMAL(13,3)  -- Quantity
  , [MaterialBaseUnit] NVARCHAR(3)  COLLATE DATABASE_DEFAULT -- Base Unit of Measure
  , [QuantityInEntryUnit] DECIMAL(13,3)  -- Quantity in unit of entry
  , [EntryUnit] NVARCHAR(3)  COLLATE DATABASE_DEFAULT -- Unit of entry
  , [PostingDate] DATE  -- Posting Date in the Document
  , [DocumentDate] DATE  -- Document Date in Document
  , [TotalGoodsMvtAmtInCCCrcy] DECIMAL(13,2)  -- Amount in Local Currency
  , [CompanyCodeCurrency] CHAR(5) COLLATE DATABASE_DEFAULT  -- Company Code Currency
  , [InventoryValuationType] NVARCHAR(10) COLLATE DATABASE_DEFAULT  -- Valuation Type
  , [ReservationIsFinallyIssued] NVARCHAR(1)  COLLATE DATABASE_DEFAULT -- Final Issue for Reservation
  , [PurchaseOrder] NVARCHAR(10) COLLATE DATABASE_DEFAULT  -- Purchase order number
  , [PurchaseOrderItem] CHAR(5) COLLATE DATABASE_DEFAULT  -- Item Number of Purchasing Document
  , [ProjectNetwork] NVARCHAR(12) COLLATE DATABASE_DEFAULT  -- Network Number for Account Assignment
  , [OrderID] NVARCHAR(12) COLLATE DATABASE_DEFAULT  -- Order Number
  , [OrderItem] CHAR(4) COLLATE DATABASE_DEFAULT  -- Order Item
  , [Reservation] CHAR(10) COLLATE DATABASE_DEFAULT   -- Number of reservation/dependent requirements
  , [ReservationItem] CHAR(4) COLLATE DATABASE_DEFAULT  -- Item Number of Reservation / Dependent Requirements
  , [DeliveryDocument] NVARCHAR(10) COLLATE DATABASE_DEFAULT  -- Delivery
  , [DeliveryDocumentItem] CHAR(6) COLLATE DATABASE_DEFAULT  -- Delivery Document Item
  , [ReversedMaterialDocumentYear] CHAR(4) COLLATE DATABASE_DEFAULT  -- Reversed Material Document Year
  , [ReversedMaterialDocument] NVARCHAR(10) COLLATE DATABASE_DEFAULT  -- Reversed Material Document
  , [ReversedMaterialDocumentItem] CHAR(4) COLLATE DATABASE_DEFAULT  -- Reversed Material Document Item
  , [RvslOfGoodsReceiptIsAllowed] NVARCHAR(1)  COLLATE DATABASE_DEFAULT -- Reversal of GR allowed for GR-based IV despite invoice
  , [GoodsRecipientName] NVARCHAR(12) COLLATE DATABASE_DEFAULT  -- Goods Recipient
  , [UnloadingPointName] NVARCHAR(25) COLLATE DATABASE_DEFAULT  -- Unloading Point
  , [CostCenter] NVARCHAR(10) COLLATE DATABASE_DEFAULT  -- Cost Center
  , [GLAccount] NVARCHAR(10) COLLATE DATABASE_DEFAULT  -- G/L Account Number
  , [ServicePerformer] NVARCHAR(10) COLLATE DATABASE_DEFAULT  -- Service Performer
  , [EmploymentInternalID] CHAR(8) COLLATE DATABASE_DEFAULT  -- Employment ID (Deprecated)
  , [PersonWorkAgreement] CHAR(8) COLLATE DATABASE_DEFAULT  -- Personnel Number
  , [AccountAssignmentCategory] NVARCHAR(1)  COLLATE DATABASE_DEFAULT -- Account Assignment Category
  , [WorkItem] NVARCHAR(10) COLLATE DATABASE_DEFAULT  -- Work Item ID
  , [ServicesRenderedDate] DATE  -- Date on which services are rendered
  , [IssgOrRcvgMaterial] NVARCHAR(40) COLLATE DATABASE_DEFAULT  -- Transfer Material
  , [IssuingOrReceivingPlant] NVARCHAR(4)  COLLATE DATABASE_DEFAULT -- Transfer Plant
  , [IssuingOrReceivingStorageLoc] NVARCHAR(4)  COLLATE DATABASE_DEFAULT -- Receiving/issuing storage location
  , [IssgOrRcvgBatch] NVARCHAR(10) COLLATE DATABASE_DEFAULT  -- Transfer Batch
  , [IssgOrRcvgSpclStockInd] NVARCHAR(1)  COLLATE DATABASE_DEFAULT -- Special Stock Indicator
  , [CompanyCode] NVARCHAR(4)  COLLATE DATABASE_DEFAULT -- Company Code
  , [BusinessArea] NVARCHAR(4)  COLLATE DATABASE_DEFAULT -- Business Area
  , [ControllingArea] NVARCHAR(4)  COLLATE DATABASE_DEFAULT -- Controlling Area
  , [FiscalYearPeriod] CHAR(7) COLLATE DATABASE_DEFAULT  -- Period Year
  , [FiscalYearVariant] NVARCHAR(2)  COLLATE DATABASE_DEFAULT -- Fiscal Year Variant
  , [GoodsMovementRefDocType] NVARCHAR(1)  COLLATE DATABASE_DEFAULT -- Goods movement ref doc type
  , [IsCompletelyDelivered] NVARCHAR(1)  COLLATE DATABASE_DEFAULT -- "Delivery Completed" Indicator
  , [MaterialDocumentItemText] NVARCHAR(50) COLLATE DATABASE_DEFAULT  -- Item Text
  , [IsAutomaticallyCreated] NVARCHAR(1)  COLLATE DATABASE_DEFAULT -- Item Automatically Created Indicator
  , [GoodsReceiptType] NVARCHAR(1)  COLLATE DATABASE_DEFAULT -- Receipt Indicator
  , [ConsumptionPosting] NVARCHAR(1)  COLLATE DATABASE_DEFAULT -- Consumption posting
  , [MultiAcctAssgmtOriglMatlDocItm] CHAR(4) COLLATE DATABASE_DEFAULT  -- Original Line for Account Assignment Item in Material Doc.
  , [HasMultipleAccountAssignment] NVARCHAR(1)  COLLATE DATABASE_DEFAULT -- Multiple Account Assignment
  , [MatlStkChangeQtyInBaseUnit] DECIMAL(31,14)  -- Stock Quantity
  , [MatlCnsmpnQtyInMatlBaseUnit] DECIMAL(31,14)  -- Consumption Quantity
  , [GoodsReceiptQtyInOrderUnit] DECIMAL(13,3)  -- Goods receipt quantity in order unit
  , [GoodsMovementIsCancelled] NVARCHAR(1)  COLLATE DATABASE_DEFAULT -- Item has been Cancelled
  , [GoodsMovementCancellationType] NVARCHAR(1)  COLLATE DATABASE_DEFAULT -- Relevance for Analytics
  , [ManufacturingOrder] NVARCHAR(12) COLLATE DATABASE_DEFAULT  -- Manufacturing Order
  , [ManufacturingOrderItem] CHAR(4) COLLATE DATABASE_DEFAULT  -- Manufacturing Order Item
  , [IsReversalMovementType] NVARCHAR(1)  COLLATE DATABASE_DEFAULT -- Has Reversal Movement Type
  , [MaterialDocumentRecordType] NVARCHAR(9)  COLLATE DATABASE_DEFAULT--Material Document Type Indicator
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
