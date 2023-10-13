-- This fact table contains approved and posted vendor invoices only
-- This fact table contains the following document types only:
-- 'PO_S4','ZPO_S4','NPO_S4','ZNPO_S4'

CREATE TABLE [edw].[fact_VendorInvoice_ApprovedAndPosted] (
  MANDT NVARCHAR(3) NOT NULL
, DocumentLedgerID NVARCHAR(12) NOT NULL
, DocumentItemID NVARCHAR(5) NOT NULL
, CompanyCodeID NVARCHAR(4)
, PurchasingDocument NVARCHAR(10)
, PurchasingDocumentItem NVARCHAR(5)
, MaterialID NVARCHAR(40)
, Quantity DECIMAL(13, 3)
, OrderUnit NVARCHAR(3)
, OrderPriceUnit NVARCHAR(3)
, NetAmount DECIMAL(23, 2)
, PlantID NVARCHAR(4)
, DebitCreditIndicator NVARCHAR(1)
, ConditionType NVARCHAR(4)
, NetOrderPrice DECIMAL(11, 2)
, CostCenterID NVARCHAR(10)
, FinalInvoice NVARCHAR(1)
, GLAccountID NVARCHAR(10)
, OrderNumber NVARCHAR(12)
, LineItemText NVARCHAR(50)
, ControllingAreaID NVARCHAR(4)
, ProfitCenterID NVARCHAR(10)
, SalesDocument NVARCHAR(10)
, SalesDocumentItem NVARCHAR(6)
, ScheduleLineNumber NVARCHAR(4)
, TaxCode NVARCHAR(2)
, MaterialDocument NVARCHAR(10)
, MaterialDocumentYear NVARCHAR(4)
, MaterialDocumentItem NVARCHAR(4)
, ValuationAreaID NVARCHAR(4)
, QuantityOrdered DECIMAL(13, 3)
, QuantityInvoiced DECIMAL(13, 3)
, QuantityOfGoodsReceived DECIMAL(13, 3)
, HDR1_ObjectType NVARCHAR(10)
, HDR1_DocumentStatus NVARCHAR(2)
, HDR1_NotFirstPass NVARCHAR(1)
, HDR1_FiscalYear NVARCHAR(4)
, HDR1_AccountingDocumentTypeID NVARCHAR(2)
, HDR1_DocumentDate DATE
, HDR1_PostingDate DATE
, HDR1_ReferenceID NVARCHAR(16)
, HDR1_CurrencyID NVARCHAR(5)
, HDR1_SupplierID NVARCHAR(10)
, HDR1_HeaderText NVARCHAR(25)
, HDR1_CountryID NVARCHAR(3)
, HDR2_SupplierInvoiceID NVARCHAR(10)
, HDR2_AccountingDocument NVARCHAR(10)
, HDR2_PostingUser NVARCHAR(12)
, [t_applicationId]VARCHAR(32)
, [t_extractionDtm]DATETIME
, [t_jobId]        VARCHAR(36)
, [t_jobDtm]       DATETIME
, [t_lastActionCd] varchar(1)
, [t_jobBy]        VARCHAR(128)
, CONSTRAINT [PK_fact_VendorInvoice_ApprovedAndPosted] PRIMARY KEY NONCLUSTERED (
    [MANDT], [DocumentLedgerID], [DocumentItemID]
  ) NOT ENFORCED
)
WITH ( 
  DISTRIBUTION = REPLICATE
)