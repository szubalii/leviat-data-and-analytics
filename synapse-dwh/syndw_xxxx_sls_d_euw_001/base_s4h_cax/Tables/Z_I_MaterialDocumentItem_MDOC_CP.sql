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
    
    [MANDT] CHAR(3) NOT NULL  -- Client
  , [MaterialDocumentYear] CHAR(4) NOT NULL  -- Material Document Year
  , [MaterialDocument] NVARCHAR(10) NOT NULL  -- Number of Material Document
  , [MaterialDocumentItem] CHAR(4) NOT NULL  -- Material Document Item
  , [Material] NVARCHAR(40)  -- Material Number
  , [Plant] NVARCHAR(4)  -- Plant
  , [StorageLocation] NVARCHAR(4)  -- Storage Location
  , [StorageType] NVARCHAR(3)  -- Storage Type
  , [StorageBin] NVARCHAR(10)  -- Storage Bin
  , [Batch] NVARCHAR(10)  -- Batch Number
  , [ShelfLifeExpirationDate] DATE  -- Shelf Life Expiration or Best-Before Date
  , [ManufactureDate] DATE  -- Date of Manufacture
  , [Supplier] NVARCHAR(10)  -- Vendor's account number
  , [SalesOrder] NVARCHAR(10)  -- Sales Order Number
  , [SalesOrderItem] CHAR(6)  -- Sales Order Item
  , [SalesOrderScheduleLine] CHAR(4)  -- Sales Order Schedule
  , [WBSElementInternalID] CHAR(24)   -- WBS Element Internal ID
  , [Customer] NVARCHAR(10)  -- Account number of customer
  , [InventorySpecialStockType] NVARCHAR(1)  -- Special Stock Type
  , [InventoryStockType] NVARCHAR(2)  -- Stock Type of Goods Movement (Stock Identifier)
  , [StockOwner] NVARCHAR(10)  -- Additional Supplier for Special Stock
  , [GoodsMovementType] NVARCHAR(3)  -- Movement Type (Inventory Management)
  , [DebitCreditCode] NVARCHAR(1)  -- Debit/Credit Indicator
  , [InventoryUsabilityCode] NVARCHAR(1)  -- Posting Control Stock Type
  , [QuantityInBaseUnit] DECIMAL(13,3)  -- Quantity
  , [MaterialBaseUnit] NVARCHAR(3)  -- Base Unit of Measure
  , [QuantityInEntryUnit] DECIMAL(13,3)  -- Quantity in unit of entry
  , [EntryUnit] NVARCHAR(3)  -- Unit of entry
  , [PostingDate] DATE  -- Posting Date in the Document
  , [DocumentDate] DATE  -- Document Date in Document
  , [TotalGoodsMvtAmtInCCCrcy] DECIMAL(13,2)  -- Amount in Local Currency
  , [CompanyCodeCurrency] CHAR(5)  -- Company Code Currency
  , [InventoryValuationType] NVARCHAR(10)  -- Valuation Type
  , [ReservationIsFinallyIssued] NVARCHAR(1)  -- Final Issue for Reservation
  , [PurchaseOrder] NVARCHAR(10)  -- Purchase order number
  , [PurchaseOrderItem] CHAR(5)  -- Item Number of Purchasing Document
  , [ProjectNetwork] NVARCHAR(12)  -- Network Number for Account Assignment
  , [OrderID] NVARCHAR(12)  -- Order Number
  , [OrderItem] CHAR(4)  -- Order Item
  , [Reservation] CHAR(10)   -- Number of reservation/dependent requirements
  , [ReservationItem] CHAR(4)  -- Item Number of Reservation / Dependent Requirements
  , [DeliveryDocument] NVARCHAR(10)  -- Delivery
  , [DeliveryDocumentItem] CHAR(6)  -- Delivery Document Item
  , [ReversedMaterialDocumentYear] CHAR(4)  -- Reversed Material Document Year
  , [ReversedMaterialDocument] NVARCHAR(10)  -- Reversed Material Document
  , [ReversedMaterialDocumentItem] CHAR(4)  -- Reversed Material Document Item
  , [RvslOfGoodsReceiptIsAllowed] NVARCHAR(1)  -- Reversal of GR allowed for GR-based IV despite invoice
  , [GoodsRecipientName] NVARCHAR(12)  -- Goods Recipient
  , [UnloadingPointName] NVARCHAR(25)  -- Unloading Point
  , [CostCenter] NVARCHAR(10)  -- Cost Center
  , [GLAccount] NVARCHAR(10)  -- G/L Account Number
  , [ServicePerformer] NVARCHAR(10)  -- Service Performer
  , [EmploymentInternalID] CHAR(8)  -- Employment ID (Deprecated)
  , [PersonWorkAgreement] CHAR(8)  -- Personnel Number
  , [AccountAssignmentCategory] NVARCHAR(1)  -- Account Assignment Category
  , [WorkItem] NVARCHAR(10)  -- Work Item ID
  , [ServicesRenderedDate] DATE  -- Date on which services are rendered
  , [IssgOrRcvgMaterial] NVARCHAR(40)  -- Transfer Material
  , [IssuingOrReceivingPlant] NVARCHAR(4)  -- Transfer Plant
  , [IssuingOrReceivingStorageLoc] NVARCHAR(4)  -- Receiving/issuing storage location
  , [IssgOrRcvgBatch] NVARCHAR(10)  -- Transfer Batch
  , [IssgOrRcvgSpclStockInd] NVARCHAR(1)  -- Special Stock Indicator
  , [CompanyCode] NVARCHAR(4)  -- Company Code
  , [BusinessArea] NVARCHAR(4)  -- Business Area
  , [ControllingArea] NVARCHAR(4)  -- Controlling Area
  , [FiscalYearPeriod] CHAR(7)  -- Period Year
  , [FiscalYearVariant] NVARCHAR(2)  -- Fiscal Year Variant
  , [GoodsMovementRefDocType] NVARCHAR(1)  -- Goods movement ref doc type
  , [IsCompletelyDelivered] NVARCHAR(1)  -- "Delivery Completed" Indicator
  , [MaterialDocumentItemText] NVARCHAR(50)  -- Item Text
  , [IsAutomaticallyCreated] NVARCHAR(1)  -- Item Automatically Created Indicator
  , [GoodsReceiptType] NVARCHAR(1)  -- Receipt Indicator
  , [ConsumptionPosting] NVARCHAR(1)  -- Consumption posting
  , [MultiAcctAssgmtOriglMatlDocItm] CHAR(4)  -- Original Line for Account Assignment Item in Material Doc.
  , [HasMultipleAccountAssignment] NVARCHAR(1)  -- Multiple Account Assignment
  , [MatlStkChangeQtyInBaseUnit] DECIMAL(31,14)  -- Stock Quantity
  , [MatlCnsmpnQtyInMatlBaseUnit] DECIMAL(31,14)  -- Consumption Quantity
  , [GoodsReceiptQtyInOrderUnit] DECIMAL(13,3)  -- Goods receipt quantity in order unit
  , [GoodsMovementIsCancelled] NVARCHAR(1)  -- Item has been Cancelled
  , [GoodsMovementCancellationType] NVARCHAR(1)  -- Relevance for Analytics
  , [ManufacturingOrder] NVARCHAR(12)  -- Manufacturing Order
  , [ManufacturingOrderItem] CHAR(4)  -- Manufacturing Order Item
  , [IsReversalMovementType] NVARCHAR(1)  -- Has Reversal Movement Type
  , [MaterialDocumentRecordType] NVARCHAR(9) --Material Document Type Indicator
  , [t_applicationId] VARCHAR (32)  -- Application ID
  , [t_jobId] VARCHAR (36)  -- Job ID
  , [t_jobDtm] DATETIME  -- Job Date Time
  , [t_jobBy] VARCHAR (128)  -- Job executed by
  , [t_extractionDtm] DATETIME  -- Extraction Date Time
  , [t_filePath] NVARCHAR (1024)  -- Filepath
  , CONSTRAINT [PK_Z_I_MaterialDocumentItem_MDOC_CP] PRIMARY KEY NONCLUSTERED(
      [MANDT]
    , [MaterialDocumentYear]
    , [MaterialDocument]
    , [MaterialDocumentItem]
  ) NOT ENFORCED
) WITH (
  HEAP
)
