CREATE TABLE [base_s4h_cax].[I_SupplierInvoiceItemGLAcct]
-- Supplier Invoice Item GL Account Acct Assignment
(
    [MANDT]                     nchar(3) collate Latin1_General_100_BIN2     NOT NULL,
    [SupplierInvoice]           nvarchar(10) NOT NULL -- collate Latin1_General_100_BIN2 NOT NULL,
    [FiscalYear]                char(4) collate Latin1_General_100_BIN2      NOT NULL,
    [OrdinalNumber]             char(4) collate Latin1_General_100_BIN2      NOT NULL,
    [CostCenter]                nvarchar(10) -- collate Latin1_General_100_BIN2,
    [ControllingArea]           nvarchar(4) -- collate Latin1_General_100_BIN2,
    [BusinessArea]              nvarchar(4) -- collate Latin1_General_100_BIN2,
    [ProfitCenter]              nvarchar(10) -- collate Latin1_General_100_BIN2,
    [FunctionalArea]            nvarchar(16) -- collate Latin1_General_100_BIN2,
    [GLAccount]                 nvarchar(10) -- collate Latin1_General_100_BIN2,
    [SalesOrder]                nvarchar(10) -- collate Latin1_General_100_BIN2,
    [SalesOrderItem]            char(6) -- collate Latin1_General_100_BIN2,
    [ProjectNetworkInternalID]  char(10) -- collate Latin1_General_100_BIN2,
    [NetworkActivityInternalID] char(10) -- collate Latin1_General_100_BIN2,
    [ProjectNetwork]            nvarchar(12) -- collate Latin1_General_100_BIN2,
    [NetworkActivity]           nvarchar(4) -- collate Latin1_General_100_BIN2,
    [CostObject]                nvarchar(12) -- collate Latin1_General_100_BIN2,
    [CostCtrActivityType]       nvarchar(6) -- collate Latin1_General_100_BIN2,
    [BusinessProcess]           nvarchar(12) -- collate Latin1_General_100_BIN2,
    [WBSElementInternalID]      char(8) -- collate Latin1_General_100_BIN2,
    [DocumentCurrency]          nchar(5) -- collate Latin1_General_100_BIN2,
    [SupplierInvoiceItemAmount] decimal(13, 2),
    [TaxCode]                   nvarchar(2) -- collate Latin1_General_100_BIN2,
    [PersonnelNumber]           char(8) -- collate Latin1_General_100_BIN2,
    [WorkItem]                  nvarchar(10) -- collate Latin1_General_100_BIN2,
    [DebitCreditCode]           nvarchar(1) -- collate Latin1_General_100_BIN2,
    [TaxJurisdiction]           nvarchar(15) -- collate Latin1_General_100_BIN2,
    [SupplierInvoiceItemText]   nvarchar(50) -- collate Latin1_General_100_BIN2,
    [AssignmentReference]       nvarchar(18) -- collate Latin1_General_100_BIN2,
    [IsNotCashDiscountLiable]   nvarchar(1) -- collate Latin1_General_100_BIN2,
    [InternalOrder]             nvarchar(12) -- collate Latin1_General_100_BIN2,
    [CommitmentItem]            nvarchar(14) -- collate Latin1_General_100_BIN2,
    [FundsCenter]               nvarchar(16) -- collate Latin1_General_100_BIN2,
    [TaxBaseAmountInTransCrcy]  decimal(13, 2),
    [Fund]                      nvarchar(10) -- collate Latin1_General_100_BIN2,
    [GrantID]                   nvarchar(20) -- collate Latin1_General_100_BIN2,
    [QuantityUnit]              nvarchar(3) -- collate Latin1_General_100_BIN2,
    [Quantity]                  decimal(13, 3),
    [PartnerBusinessArea]       nvarchar(4) -- collate Latin1_General_100_BIN2,
    [CompanyCode]               nvarchar(4) -- collate Latin1_General_100_BIN2,
    [t_applicationId]           VARCHAR(32),    
    [t_jobId]                   VARCHAR(36),
    [t_jobDtm]                  DATETIME,
    [t_jobBy]                   NVARCHAR(128),
    [t_extractionDtm]           DATETIME,
    [t_filePath]                NVARCHAR(1024),
    CONSTRAINT [PK_I_SupplierInvoiceItemGLAcct] PRIMARY KEY NONCLUSTERED ([MANDT], [SupplierInvoice], [FiscalYear], [OrdinalNumber]) NOT ENFORCED
)
WITH (HEAP)