﻿CREATE TABLE [edw].[fact_ACDOCA]
(
    [SourceLedgerID]                        nvarchar(4) NOT NULL,
    [CompanyCodeID]                         nvarchar(8) NOT NULL,
    [FiscalYear]                            char(4) NOT NULL, -- collate Latin1_General_100_BIN2  NOT NULL,
    [AccountingDocument]                    nvarchar(20)  NOT NULL,
    [LedgerGLLineItem]                      nvarchar(12)  NOT NULL,
    [ProductSurrogateKey]                   nvarchar(117),
    [LedgerFiscalYear]                      char(4), -- collate Latin1_General_100_BIN2,
    [GLRecordTypeID]                        nvarchar(2),
    [ChartOfAccountsID]                     nvarchar(8),
    [ControllingAreaID]                     nvarchar(8),
    [FinancialTransactionTypeID]            nvarchar(6),
    [BusinessTransactionTypeID]             nvarchar(8),
    [ControllingBusTransacTypeID]           nvarchar(8),
    [ReferenceDocumentTypeID]               nvarchar(10),
    [ReferenceDocumentContextID]            nvarchar(20),
    [ReferenceDocument]                     nvarchar(20),
    [ReferenceDocumentItem]                 char(6), -- collate Latin1_General_100_BIN2,
    [ReferenceDocumentItemGroupID]          char(6), -- collate Latin1_General_100_BIN2,
    [IsReversal]                            nvarchar(2),
    [IsReversed]                            nvarchar(2),
    [PredecessorReferenceDocTypeID]         nvarchar(5),
    [ReversalReferenceDocumentCntxtID]      nvarchar(20),
    [ReversalReferenceDocument]             nvarchar(20),
    [IsSettlement]                          nvarchar(2),
    [IsSettled]                             nvarchar(2),
    [PredecessorReferenceDocument]          nvarchar(20),
    [PredecessorReferenceDocItem]           char(6), -- collate Latin1_General_100_BIN2,
    [SourceReferenceDocumentTypeID]         nvarchar(10),
    [SourceReferenceDocument]               nvarchar(20),
    [SourceReferenceDocumentItem]           char(6), -- collate Latin1_General_100_BIN2,
    [IsCommitment]                          nvarchar(2),
    [JrnlEntryItemObsoleteReasonID]         nvarchar(2),
    [GLAccountID]                           nvarchar(20),
    [CostCenterID]                          nvarchar(20),
    [ProfitCenterID]                        nvarchar(20),
    [FunctionalAreaID]                      nvarchar(32),
    [BusinessAreaID]                        nvarchar(4),
    [SegmentID]                             nvarchar(20),
    [PartnerCostCenterID]                   nvarchar(20),
    [PartnerProfitCenterID]                 nvarchar(20),
    [PartnerFunctionalAreaID]               nvarchar(32),
    [PartnerBusinessAreaID]                 nvarchar(8),
    [PartnerCompanyID]                      nvarchar(12),
    [PartnerSegmentID]                      nvarchar(20),
    [BalanceTransactionCurrency]            char(5), -- collate Latin1_General_100_BIN2,
    [AmountInBalanceTransacCrcy]            decimal(23, 2),
    [TransactionCurrency]                   char(5), -- collate Latin1_General_100_BIN2,
    [AmountInTransactionCurrency]           decimal(23, 2),
    [CompanyCodeCurrency]                   char(5), -- collate Latin1_General_100_BIN2,
    [AmountInCompanyCodeCurrency]           decimal(23, 2),
    [GlobalCurrency]                        char(5), -- collate Latin1_General_100_BIN2,
    [AmountInGlobalCurrency]                decimal(23, 2),
    [FreeDefinedCurrency1]                  char(5), -- collate Latin1_General_100_BIN2,
    [AmountInFreeDefinedCurrency1]          decimal(23, 2),
    [FreeDefinedCurrency2]                  char(5), -- collate Latin1_General_100_BIN2,
    [AmountInFreeDefinedCurrency2]          decimal(23, 2),
    [BaseUnit]                              nvarchar(6), -- collate Latin1_General_100_BIN2,
    [Quantity]                              decimal(23, 3),
    [DebitCreditID]                         nvarchar(1),
    [FiscalPeriod]                          char(3), -- collate Latin1_General_100_BIN2,
    [FiscalYearVariant]                     nvarchar(4),
    [FiscalYearPeriod]                      char(7), -- collate Latin1_General_100_BIN2,
    [PostingDate]                           date,
    [DocumentDate]                          date,
    [AccountingDocumentTypeID]              nvarchar(4),
    [AccountingDocumentItem]                char(3), -- collate Latin1_General_100_BIN2,
    [AssignmentReference]                   nvarchar(36),
    [AccountingDocumentCategoryID]          nvarchar(2),
    [PostingKeyID]                          nvarchar(4),
    [TransactionTypeDeterminationID]        nvarchar(6),
    [SubLedgerAcctLineItemTypeID]           char(5), -- collate Latin1_General_100_BIN2,
    [AccountingDocCreatedByUserID]          nvarchar(24),
    [LastChangeDateTime]                    decimal(15),
    [CreationDateTime]                      decimal(15),
    [CreationDate]                          date,
    [OriginObjectTypeID]                    char(2), -- collate Latin1_General_100_BIN2,
    [GLAccountTypeID]                       nvarchar(2),
    [InvoiceReference]                      nvarchar(20),
    [InvoiceReferenceFiscalYear]            char(4), -- collate Latin1_General_100_BIN2,
    [InvoiceItemReference]                  char(3), -- collate Latin1_General_100_BIN2,
    [ReferencePurchaseOrderCategoryID]      char(3), -- collate Latin1_General_100_BIN2,
    [PurchasingDocument]                    nvarchar(20),
    [PurchasingDocumentItem]                char(5), -- collate Latin1_General_100_BIN2,
    [AccountAssignmentNumber]               char(2), -- collate Latin1_General_100_BIN2,
    [DocumentItemText]                      nvarchar(100),
    [SalesDocumentID]                       nvarchar(10),
    [SalesDocumentItemID]                   char(6), -- collate Latin1_General_100_BIN2,
    [ProductID]                             nvarchar(80),
    [PlantID]                               nvarchar(8),
    [SupplierID]                            nvarchar(20),
    [CustomerID]                            nvarchar(20),
    [ExchangeRateDate]                      date,
    [FinancialAccountTypeID]                nvarchar(2),
    [SpecialGLCodeID]                       nvarchar(2),
    [TaxCodeID]                             nvarchar(4),
    [ClearingDate]                          date,
    [ClearingAccountingDocument]            nvarchar(20),
    [ClearingDocFiscalYear]                 char(4), -- collate Latin1_General_100_BIN2,
    [LineItemIsCompleted]                   nvarchar(2),
    [PersonnelNumber]                       char(8), -- collate Latin1_General_100_BIN2,
    [PartnerCompanyCodeID]                  nvarchar(8),
    [OriginProfitCenterID]                  nvarchar(20),
    [OriginCostCenterID]                    nvarchar(20),
    [AccountAssignmentID]                   nvarchar(60),
    [AccountAssignmentTypeID]               nvarchar(4),
    [CostCtrActivityTypeID]                 nvarchar(12),
    [OrderID]                               nvarchar(24),
    [OrderCategoryID]                       char(2), -- collate Latin1_General_100_BIN2,
    [WBSElementID]                          nvarchar(48),
    [ProjectInternalID]                     char(8), -- collate Latin1_General_100_BIN2,
    [ProjectID]                             nvarchar(48),
    [OperatingConcernID]                    nvarchar(8),
    [BusinessProcessID]                     nvarchar(24),
    [CostObjectID]                          nvarchar(24),
    [BillableControlID]                     nvarchar(4),
    [ServiceDocumentTypeID]                 nvarchar(8),
    [ServiceDocument]                       nvarchar(20),
    [ServiceDocumentItem]                   char(6), -- collate Latin1_General_100_BIN2,
    [BillingDocumentTypeID]                 nvarchar(8),
    [SalesOrganizationID]                   nvarchar(8),
    [DistributionChannelID]                 nvarchar(4),
    [SalesDistrictID]                       nvarchar(12),
    [BillToPartyID]                         nvarchar(20),
    [ShipToPartyID]                         nvarchar(20),
    [SalesOfficeID]                         nvarchar(4),
    [SoldProduct]                           nvarchar(40),
    [ProfitCenterTypeID]                    char(1),
    [SalesReferenceDocumentCalculated]      nvarchar(10),
    [SalesReferenceDocumentItemCalculated]  char(6), -- collate Latin1_General_100_BIN2,
    [SalesDocumentItemCategoryID]           nvarchar(8),
    [HigherLevelItem]                       char(6), -- collate Latin1_General_100_BIN2,
    [ProjectNumber]                         nvarchar(10),
    [t_applicationId]                       VARCHAR(32),
    [t_extractionDtm]                       DATETIME,
    [t_jobId]                               VARCHAR(36),
    [t_jobDtm]                              DATETIME,
    [t_lastActionCd]                        VARCHAR(1),
    [t_jobBy]                               NVARCHAR(128),
    CONSTRAINT [PK_fact_ACDOCA] PRIMARY KEY NONCLUSTERED ([SourceLedgerID], [CompanyCodeID], [FiscalYear],
                                                          [AccountingDocument], [LedgerGLLineItem]) NOT ENFORCED
)
    WITH
        (
        DISTRIBUTION = HASH ([AccountingDocument]), CLUSTERED COLUMNSTORE INDEX
)
GO