CREATE TABLE [base_s4h_cax].[C_GRIRAccountReconciliation] (
    [MANDT] CHAR(3) NOT NULL  -- Client
  , [CompanyCode] NVARCHAR(4) NOT NULL  -- Company Code
  , [PurchasingDocument] NVARCHAR(10) NOT NULL  -- Purchasing Document
  , [PurchasingDocumentItem] CHAR(5) NOT NULL  -- Purchasing Document Item
  , [PurchasingDocumentItemUniqueID] NVARCHAR(15)  -- Concatenation of EBELN and EBELP
  , [CompanyCodeCurrency] CHAR(5)  -- Company Code Currency
  , [BalAmtInCompanyCodeCrcy] DECIMAL(23,2)  -- Total Balance Amount in Company Code Currency
  -- , [BalanceAbsoluteAmtInCoCodeCrcy] DECIMAL(23,2)  -- Balance Absolute Amount In Company Code Currency
  -- , [PurgDocOrderQuantityUnit] NVARCHAR(3)  -- Purchase Order Unit of Measure
  , [ReferenceQuantityUnit] NVARCHAR(3)  -- Unit of Measure for Reference Quantity
  , [BalanceQuantityInRefQtyUnit] DECIMAL(23,3)  -- Balance Quantity in Reference Quantity Unit
  -- , [BalanceAbsoluteQtyInRefQtyUnit] DECIMAL(23,3)  -- Absolute Balance Quantity in Reference Quantity Unit
  -- , [GoodsReceiptQtyInRefQtyUnit] DECIMAL(23,3)  -- Quantity of Goods Received in Reference Quantity Unit
  -- , [InvoiceReceiptQtyInRefQtyUnit] DECIMAL(23,3)  -- Invoiced Quantity in Reference Quantity Unit
  -- , [PurchasingDocumentOrderQty] DECIMAL(13,3)  -- Purchase Order Quantity
  , [NumberOfGoodsReceipts] INT  -- Number of Goods Receipts
  , [NumberOfInvoiceReceipts] INT  -- Number of Invoice Receipts
  -- , [LastChangeDateTime] DECIMAL(15)  -- GR/IR Clearing Process Last Change Date Time
  -- , [LastChangedByUser] NVARCHAR(12)  -- User of Last Change in GR/IR Clearing Process
  , [ResponsibleDepartment] NVARCHAR(30)  -- Processing Department of GR/IR Clearing Process
  , [ResponsiblePerson] NVARCHAR(12)  -- Processor of GR/IR Clearing Process
  , [GRIRClearingProcessStatus] NVARCHAR(2)  -- GR/IR Clearing Process Status
  , [GRIRClearingProcessPriority] NVARCHAR(2)  -- Priority of GR/IR Clearing Process
  , [HasNote] NVARCHAR(1)  -- Notes Included in GR/IR Clearing Process
  -- , [GRIRClearingProcessRootCause] NVARCHAR(3)  -- Root Cause for GR/IR Clearing Process
  -- , [LastChangeDate] DATE  -- Changed On
  -- , [LatestPostingIsAfterLastChange] NVARCHAR(1)  -- Latest Posting Date is After Last Changed Date
  -- , [SystemMessageIdentification] NVARCHAR(20)  -- Message identification
  , [SystemMessageType] NVARCHAR(1)  -- Message Type
  , [SystemMessageNumber] NVARCHAR(3)  -- Message number
  -- , [SystemMessageVariable1] NVARCHAR(50)  -- Message variable 01
  -- , [SystemMessageVariable2] NVARCHAR(50)  -- Message variable 02
  -- , [SystemMessageVariable3] NVARCHAR(50)  -- Message variable 03
  -- , [SystemMessageVariable4] NVARCHAR(50)  -- Message variable 04
  -- , [SystemMessageText] NVARCHAR(73)  -- Message Text
  -- , [PrpsdResponsibleDepartment] NVARCHAR(30)  -- Proposed Processing Department of GR/IR Clearing Process
  -- , [ProposedResponsiblePerson] NVARCHAR(12)  -- Proposed Processor of GR/IR Clearing Process
  -- , [GRIRClrgProcessPrpsdStatus] NVARCHAR(2)  -- Proposed Status of GR/IR Clearing Process
  -- , [GRIRClrgProcPrpsdPriority] NVARCHAR(2)  -- Proposed Priority of GR/IR Clearing Process
  -- , [GRIRClrgProcessPrpsdRootCause] NVARCHAR(3)  -- Proposed Root Cause of GR/IR Clearing Process
  -- , [PrpsdRespDeptMaxClProbability] DECIMAL(8,7)  -- Processing Department Proposal Confidence
  -- , [PrpsdRespPersonMaxClassProblty] DECIMAL(8,7)  -- Processor Proposal Confidence
  -- , [GRIRProposedStatusMaxClProblty] DECIMAL(8,7)  -- Status Proposal Confidence
  -- , [GRIRProposedPrioMaxClProblty] DECIMAL(8,7)  -- Priority Proposal Confidence
  -- , [GRIRPrpsdRootCauseMaxClProblty] DECIMAL(8,7)  -- Root Cause Proposal Confidence
  -- , [GRIRProcPrpslLastChangeDteTime] DECIMAL(15)  -- GR/IR Clearing Process Last Change Date Time
  -- , [Plant] NVARCHAR(4)  -- Plant
  -- , [PurchasingOrganization] NVARCHAR(4)  -- Purchasing Organization
  -- , [PurchasingGroup] NVARCHAR(3)  -- Purchasing Group
  -- , [MaterialGroup] NVARCHAR(9)  -- Material Group
  -- , [Material] NVARCHAR(40)  -- Material Number
  -- , [RequisitionerName] NVARCHAR(12)  -- Name of requisitioner/requester
  , [AccountAssignmentCategory] NVARCHAR(1)  -- Account Assignment Category
  -- , [IsFinallyInvoiced] NVARCHAR(1)  -- Final Invoice Indicator
  -- , [PurchasingDocumentDeletionCode] NVARCHAR(1)  -- Deletion Indicator in Purchasing Document
  , [Supplier] NVARCHAR(10)  -- Supplier
  , [SupplierName] NVARCHAR(80)  -- Name of Supplier
  -- , [CreatedByUser] NVARCHAR(12)  -- User of person who created a purchasing document
  -- , [LastChangeDays] INT  -- Number of days until the last change
  , [LatestOpenItemPostingDate] DATE  -- Posting Date of Latest Open Item
  , [OldestOpenItemPostingDate] DATE  -- Posting Date of Oldest Open Item
  -- , [NumberOfOpenItems] INT  -- Number of Open Items
  -- , [PurchasingDocumentItemText] NVARCHAR(40)  -- Short Text
  , [ValuationArea] NVARCHAR(4)  -- Valuation Area
  , [ValuationType] NVARCHAR(10)  -- Valuation Type
  -- , [PurchasingDocumentItemCategory] NVARCHAR(1)  -- Item category in purchasing document
  -- , [NumberOfPurchaseOrderItems] INT  -- Number of Purchasing Document Items
  -- , [PurchasingDocumentCategory] NVARCHAR(1)  -- Purchasing Document Category
  -- , [PurchasingDocumentType] NVARCHAR(4)  -- Purchasing Document Type
  -- , [InvoicingParty] NVARCHAR(10)  -- Different Invoicing Party
  -- , [InvoicingPartyName] NVARCHAR(80)  -- Name of Invoicing Party
  -- , [GoodsReceiptGoodsAmtInCCCrcy] DECIMAL(23,2)  -- Goods Receipt Amount in Company Code Currency (Goods)
  -- , [GdsRcptDelivCostAmtInCCCrcy] DECIMAL(23,2)  -- Goods Receipt Amount in Company Code Currency (Delivery Cost
  -- , [InvoiceRcptGoodsAmtInCCCrcy] DECIMAL(23,2)  -- Invoice Receipt Amount in Company Code Currency (Goods)
  -- , [InvcRcptDelivCostAmtInCCCrcy] DECIMAL(23,2)  -- Invoice Receipt Amount in Company Code Crcy (Delivery Costs)
  -- , [GoodsReceiptGdsQtyInRefQtyUnit] DECIMAL(23,3)  -- Goods Receipt Quantity (Goods) in Reference Quantity Unit
  -- , [GRDelivCostQtyInRefQtyUnit] DECIMAL(23,3)  -- Goods Receipt Quantity (Delivery Costs) in Reference Quantit
  -- , [InvoiceRcptGdsQtyInRefQtyUnit] DECIMAL(23,3)  -- Invoice Receipt Quantity (Goods) in Reference Quantity Unit
  -- , [InvcRcptDelivQtyInRefQtyUnit] DECIMAL(23,3)  -- Invoice Quantity (Delivery Costs) in Reference Quantity Unit
  -- , [GoodsBalanceAmountInCCCrcy] DECIMAL(23,2)  -- Balance Amount in Company Code Currency (Goods)
  -- , [GdsBalanceQuantityInRefQtyUnit] DECIMAL(23,3)  -- Balance Quantity (Goods) in Reference Quantity Unit
  -- , [DeliveryCostBalAmtInCCCrcy] DECIMAL(23,2)  -- Balance Amount in Company Code Currency (Delivery Costs)
  -- , [DelivCostBalQtyInRefQtyUnit] DECIMAL(23,3)  -- Balance Quantity (Delivery Costs) in Reference Quantity Unit
  -- , [GoodsReceiptAmountInCoCodeCrcy] DECIMAL(23,2)  -- Goods Receipt Amount in Company Code Currency
  -- , [InvoiceRcptAmtInCoCodeCrcy] DECIMAL(23,2)  -- Invoice Receipt Amount in Company Code Currency
  -- , [HasNoGoodsReceiptPosted] NVARCHAR(1)  -- There is no goods receipt posted.
  , [HasNoInvoiceReceiptPosted] NVARCHAR(1)  -- There is no invoice receipt posted.
  -- , [GRIRHasNoAmountDifference] NVARCHAR(1)  -- There is no goods receipt posted.
  , [IsGoodsRcptGoodsAmtSurplus] NVARCHAR(1)  -- There is goods amount surplus in goods receipts.
  -- , [IsInvoiceGoodsAmountSurplus] NVARCHAR(1)  -- There is goods amount surplus in invoices.
  , [IsGdsRcptDelivCostAmtSurplus] NVARCHAR(1)  -- There is delivery cost amount surplus in goods receipts.
  -- , [IsInvoiceDelivCostAmtSurplus] NVARCHAR(1)  -- There is delivery cost amount surplus in invoices.
  -- , [IsGoodsRcptGoodsQtySurplus] NVARCHAR(1)  -- There is goods quantity surplus in goods receipts.
  -- , [IsInvoiceGoodsQtySurplus] NVARCHAR(1)  -- There is goods quantity surplus in invoices.
  -- , [IsGdsRcptDelivCostQtySurplus] NVARCHAR(1)  -- There is delivery cost quantity surplus in goods receipts.
  -- , [IsInvoiceDelivCostQtySurplus] NVARCHAR(1)  -- There is delivery cost quantity surplus in invoices.
  , [t_applicationId] VARCHAR (32)  -- Application ID
  , [t_jobId] VARCHAR (36)  -- Job ID
  , [t_jobDtm] DATETIME  -- Job Date Time
  , [t_jobBy] VARCHAR (128)  -- Job executed by
  , [t_extractionDtm] DATETIME  -- Extraction Date Time
  , [t_filePath] NVARCHAR (1024)  -- Filepath
  , CONSTRAINT [PK_C_GRIRAccountReconciliation] PRIMARY KEY NONCLUSTERED(
      
      [MANDT]
    , [CompanyCode]
    , [PurchasingDocument]
    , [PurchasingDocumentItem]
    , [ValuationArea]
  ) NOT ENFORCED
) WITH (
  HEAP
)
