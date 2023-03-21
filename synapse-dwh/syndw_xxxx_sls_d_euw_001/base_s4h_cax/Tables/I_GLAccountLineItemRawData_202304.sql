CREATE TABLE [base_s4h_cax].[I_GLAccountLineItemRawData_202304](
    [MANDT]                          char(3) collate Latin1_General_100_BIN2 NOT NULL,
    [SourceLedger]                   nvarchar(2)                             NOT NULL,
    [CompanyCode]                    nvarchar(4)                             NOT NULL,
    [FiscalYear]                     char(4) collate Latin1_General_100_BIN2 NOT NULL,
    [AccountingDocument]             nvarchar(10)                            NOT NULL,
    [LedgerGLLineItem]               nvarchar(6)                             NOT NULL,
    [LedgerFiscalYear]               char(4) collate Latin1_General_100_BIN2,
    [GLRecordType]                   nvarchar(1),
    [ChartOfAccounts]                nvarchar(4),
    [ControllingArea]                nvarchar(4),
    [FinancialTransactionType]       nvarchar(3),
    [BusinessTransactionType]        nvarchar(4),
    [ControllingBusTransacType]      nvarchar(4),
    [ReferenceDocumentType]          nvarchar(5),
    [LogicalSystem]                  nvarchar(10),
    [ReferenceDocumentContext]       nvarchar(10),
    [ReferenceDocument]              nvarchar(10),
    [ReferenceDocumentItem]          char(6) collate Latin1_General_100_BIN2,
    [ReferenceDocumentItemGroup]     char(6) collate Latin1_General_100_BIN2,
    [IsReversal]                     nvarchar(1),
    [IsReversed]                     nvarchar(1),
    [ReversalReferenceDocumentCntxt] nvarchar(10),
    [ReversalReferenceDocument]      nvarchar(10),
    [IsSettlement]                   nvarchar(1),
    [IsSettled]                      nvarchar(1),
    [PredecessorReferenceDocType]    nvarchar(5),
    [PredecessorReferenceDocCntxt]   nvarchar(10),
    [PredecessorReferenceDocument]   nvarchar(10),
    [PredecessorReferenceDocItem]    char(6) collate Latin1_General_100_BIN2,
    [SourceReferenceDocumentType]    nvarchar(5),
    [SourceLogicalSystem]            nvarchar(10),
    [SourceReferenceDocumentCntxt]   nvarchar(10),
    [SourceReferenceDocument]        nvarchar(10),
    [SourceReferenceDocumentItem]    char(6) collate Latin1_General_100_BIN2,
    [SourceReferenceDocSubitem]      char(6) collate Latin1_General_100_BIN2,
    [IsCommitment]                   nvarchar(1),
    [JrnlEntryItemObsoleteReason]    nvarchar(1),
    [GLAccount]                      nvarchar(10),
    [CostCenter]                     nvarchar(10),
    [ProfitCenter]                   nvarchar(10),
    [FunctionalArea]                 nvarchar(16),
    [BusinessArea]                   nvarchar(4),
    [Segment]                        nvarchar(10),
    [PartnerCostCenter]              nvarchar(10),
    [PartnerProfitCenter]            nvarchar(10),
    [PartnerFunctionalArea]          nvarchar(16),
    [PartnerBusinessArea]            nvarchar(4),
    [PartnerCompany]                 nvarchar(6),
    [PartnerSegment]                 nvarchar(10),
    [BalanceTransactionCurrency]     char(5) collate Latin1_General_100_BIN2,
    [AmountInBalanceTransacCrcy]     decimal(23, 2),
    [TransactionCurrency]            char(5) collate Latin1_General_100_BIN2,
    [AmountInTransactionCurrency]    decimal(23, 2),
    [CompanyCodeCurrency]            char(5) collate Latin1_General_100_BIN2,
    [AmountInCompanyCodeCurrency]    decimal(23, 2),
    [GlobalCurrency]                 char(5) collate Latin1_General_100_BIN2,
    [AmountInGlobalCurrency]         decimal(23, 2),
    [FreeDefinedCurrency1]           char(5) collate Latin1_General_100_BIN2,
    [AmountInFreeDefinedCurrency1]   decimal(23, 2),
    [FreeDefinedCurrency2]           char(5) collate Latin1_General_100_BIN2,
    [AmountInFreeDefinedCurrency2]   decimal(23, 2),
    [FreeDefinedCurrency3]           char(5) collate Latin1_General_100_BIN2,
    [AmountInFreeDefinedCurrency3]   decimal(23, 2),
    [FreeDefinedCurrency4]           char(5) collate Latin1_General_100_BIN2,
    [AmountInFreeDefinedCurrency4]   decimal(23, 2),
    [FreeDefinedCurrency5]           char(5) collate Latin1_General_100_BIN2,
    [AmountInFreeDefinedCurrency5]   decimal(23, 2),
    [FreeDefinedCurrency6]           char(5) collate Latin1_General_100_BIN2,
    [AmountInFreeDefinedCurrency6]   decimal(23, 2),
    [FreeDefinedCurrency7]           char(5) collate Latin1_General_100_BIN2,
    [AmountInFreeDefinedCurrency7]   decimal(23, 2),
    [FreeDefinedCurrency8]           char(5) collate Latin1_General_100_BIN2,
    [AmountInFreeDefinedCurrency8]   decimal(23, 2),
    [FixedAmountInGlobalCrcy]        decimal(23, 2),
    [GrpValnFixedAmtInGlobCrcy]      decimal(23, 2),
    [PrftCtrValnFxdAmtInGlobCrcy]    decimal(23, 2),
    [FixedAmountInCoCoDeCrcy]        decimal(23, 2),
    [TotalPriceVarcInGlobalCrcy]     decimal(23, 2),
    [GrpValnTotPrcVarcInGlobCrcy]    decimal(23, 2),
    [PrftCtrValnTotPrcVarcInGlbCrcy] decimal(23, 2),
    [FixedPriceVarcInGlobalCrcy]     decimal(23, 2),
    [GrpValnFixedPrcVarcInGlobCrcy]  decimal(23, 2),
    [PrftCtrValnFxdPrcVarcInGlbCrcy] decimal(23, 2),
    [ControllingObjectCurrency]      char(5) collate Latin1_General_100_BIN2,
    [AmountInObjectCurrency]         decimal(23, 2),
    [BaseUnit]                       nvarchar(3) collate Latin1_General_100_BIN2,
    [Quantity]                       decimal(23, 3),
    [FixedQuantity]                  decimal(23, 3),
    [CostSourceUnit]                 nvarchar(3) collate Latin1_General_100_BIN2,
    [ValuationQuantity]              decimal(23, 3),
    [ValuationFixedQuantity]         decimal(23, 3),
    [AdditionalQuantity1Unit]        nvarchar(3) collate Latin1_General_100_BIN2,
    [AdditionalQuantity1]            decimal(23, 3),
    [AdditionalQuantity2Unit]        nvarchar(3) collate Latin1_General_100_BIN2,
    [AdditionalQuantity2]            decimal(23, 3),
    [AdditionalQuantity3Unit]        nvarchar(3) collate Latin1_General_100_BIN2,
    [AdditionalQuantity3]            decimal(23, 3),
    [DebitCreditCode]                nvarchar(1),
    [FiscalPeriod]                   char(3) collate Latin1_General_100_BIN2,
    [FiscalYearVariant]              nvarchar(2),
    [FiscalYearPeriod]               char(7) collate Latin1_General_100_BIN2,
    [PostingDate]                    date,
    [DocumentDate]                   date,
    [AccountingDocumentType]         nvarchar(2),
    [AccountingDocumentItem]         char(3) collate Latin1_General_100_BIN2,
    [AssignmentReference]            nvarchar(18),
    [AccountingDocumentCategory]     nvarchar(1),
    [PostingKey]                     nvarchar(2),
    [TransactionTypeDetermination]   nvarchar(3),
    [SubLedgerAcctLineItemType]      char(5) collate Latin1_General_100_BIN2,
    [AccountingDocCreatedByUser]     nvarchar(12),
    [LastChangeDateTime]             decimal(15),
    [CreationDateTime]               decimal(15),
    [CreationDate]                   date,
    [EliminationProfitCenter]        nvarchar(10),
    [OriginObjectType]               char(2) collate Latin1_General_100_BIN2,
    [GLAccountType]                  nvarchar(1),
    [AlternativeGLAccount]           nvarchar(10),
    [CountryChartOfAccounts]         nvarchar(4),
    [InvoiceReference]               nvarchar(10),
    [InvoiceReferenceFiscalYear]     char(4) collate Latin1_General_100_BIN2,
    [FollowOnDocumentType]           nvarchar(1),
    [InvoiceItemReference]           char(3) collate Latin1_General_100_BIN2,
    [ReferencePurchaseOrderCategory] char(3) collate Latin1_General_100_BIN2,
    [PurchasingDocument]             nvarchar(10),
    [PurchasingDocumentItem]         char(5) collate Latin1_General_100_BIN2,
    [AccountAssignmentNumber]        char(2) collate Latin1_General_100_BIN2,
    [DocumentItemText]               nvarchar(50),
    [SalesDocument]                  nvarchar(10),
    [SalesDocumentItem]              char(6) collate Latin1_General_100_BIN2,
    [Product]                        nvarchar(40),
    [Plant]                          nvarchar(4),
    [Supplier]                       nvarchar(10),
    [Customer]                       nvarchar(10),
    [ServicesRenderedDate]           date,
    [ConditionContract]              nvarchar(10),
    [ExchangeRateDate]               date,
    [FinancialAccountType]           nvarchar(1),
    [SpecialGLCode]                  nvarchar(1),
    [TaxCode]                        nvarchar(2),
    [HouseBank]                      nvarchar(5),
    [HouseBankAccount]               nvarchar(5),
    [IsOpenItemManaged]              nvarchar(1),
    [ClearingDate]                   date,
    [ClearingAccountingDocument]     nvarchar(10),
    [ClearingDocFiscalYear]          char(4) collate Latin1_General_100_BIN2,
    [AssetDepreciationArea]          char(2) collate Latin1_General_100_BIN2,
    [MasterFixedAsset]               nvarchar(12),
    [FixedAsset]                     nvarchar(4),
    [AssetValueDate]                 date,
    [AssetTransactionType]           nvarchar(3),
    [AssetAcctTransClassfctn]        nvarchar(2),
    [DepreciationFiscalPeriod]       char(3) collate Latin1_General_100_BIN2,
    [GroupMasterFixedAsset]          nvarchar(12),
    [GroupFixedAsset]                nvarchar(4),
    [AssetClass]                     nvarchar(8),
    [CostEstimate]                   char(12) collate Latin1_General_100_BIN2,
    [InventorySpecialStockValnType]  nvarchar(1),
    [InventorySpecialStockType]      nvarchar(1),
    [InventorySpclStkSalesDocument]  nvarchar(10),
    [InventorySpclStkSalesDocItm]    char(6) collate Latin1_General_100_BIN2,
    [InvtrySpclStockWBSElmntIntID]   char(8) collate Latin1_General_100_BIN2,
    [InventorySpclStockWBSElement]   nvarchar(24),
    [InventorySpecialStockSupplier]  nvarchar(10),
    [InventoryValuationType]         nvarchar(10),
    [ValuationArea]                  nvarchar(4),
    [SenderCompanyCode]              nvarchar(4),
    [SenderGLAccount]                nvarchar(10),
    [SenderAccountAssignment]        nvarchar(30),
    [SenderAccountAssignmentType]    nvarchar(2),
    [ControllingObject]              nvarchar(22),
    [CostOriginGroup]                nvarchar(4),
    [OriginSenderObject]             nvarchar(22),
    [ControllingDebitCreditCode]     nvarchar(1),
    [ControllingObjectDebitType]     char(1) collate Latin1_General_100_BIN2,
    [QuantityIsIncomplete]           char(1) collate Latin1_General_100_BIN2,
    [OffsettingAccount]              nvarchar(10),
    [OffsettingAccountType]          nvarchar(1),
    [OffsettingChartOfAccounts]      nvarchar(4),
    [LineItemIsCompleted]            nvarchar(1),
    [PersonnelNumber]                char(8) collate Latin1_General_100_BIN2,
    [ControllingObjectClass]         nvarchar(2),
    [PartnerCompanyCode]             nvarchar(4),
    [PartnerControllingObjectClass]  nvarchar(2),
    [OriginCostCenter]               nvarchar(10),
    [OriginProfitCenter]             nvarchar(10),
    [OriginCostCtrActivityType]      nvarchar(6),
    [AccountAssignment]              nvarchar(30),
    [AccountAssignmentType]          nvarchar(2),
    [CostCtrActivityType]            nvarchar(6),
    [OrderID]                        nvarchar(12),
    [OrderCategory]                  char(2) collate Latin1_General_100_BIN2,
    [WBSElementInternalID]           char(8) collate Latin1_General_100_BIN2,
    [WBSElement]                     nvarchar(24),
    [PartnerWBSElementInternalID]    char(8) collate Latin1_General_100_BIN2,
    [PartnerWBSElement]              nvarchar(24),
    [ProjectInternalID]              char(8) collate Latin1_General_100_BIN2,
    [Project]                        nvarchar(24),
    [PartnerProjectInternalID]       char(8) collate Latin1_General_100_BIN2,
    [PartnerProject]                 nvarchar(24),
    [OperatingConcern]               nvarchar(4),
    [ProjectNetwork]                 nvarchar(12),
    [RelatedNetworkActivity]         nvarchar(4),
    [BusinessProcess]                nvarchar(12),
    [CostObject]                     nvarchar(12),
    [BillableControl]                nvarchar(2),
    [CostAnalysisResource]           nvarchar(10),
    [CustomerServiceNotification]    nvarchar(12),
    [ServiceDocumentType]            nvarchar(4),
    [ServiceDocument]                nvarchar(10),
    [ServiceDocumentItem]            char(6) collate Latin1_General_100_BIN2,
    [PartnerServiceDocumentType]     nvarchar(4),
    [PartnerServiceDocument]         nvarchar(10),
    [PartnerServiceDocumentItem]     char(6) collate Latin1_General_100_BIN2,
    [ServiceContractType]            nvarchar(4),
    [ServiceContract]                nvarchar(10),
    [ServiceContractItem]            char(6) collate Latin1_General_100_BIN2,
    [TimeSheetOvertimeCategory]      nvarchar(4),
    [PartnerAccountAssignment]       nvarchar(30),
    [PartnerAccountAssignmentType]   nvarchar(2),
    [WorkPackage]                    nvarchar(50),
    [WorkItem]                       nvarchar(10),
    [PartnerCostCtrActivityType]     nvarchar(6),
    [PartnerOrder]                   nvarchar(12),
    [PartnerOrderCategory]           char(2) collate Latin1_General_100_BIN2,
    [PartnerSalesDocument]           nvarchar(10),
    [PartnerSalesDocumentItem]       char(6) collate Latin1_General_100_BIN2,
    [PartnerProjectNetwork]          nvarchar(12),
    [PartnerProjectNetworkActivity]  nvarchar(4),
    [PartnerBusinessProcess]         nvarchar(12),
    [PartnerCostObject]              nvarchar(12),
    [BillingDocumentType]            nvarchar(4),
    [SalesOrganization]              nvarchar(4),
    [DistributionChannel]            nvarchar(2),
    [OrganizationDivision]           nvarchar(2),
    [SoldProduct]                    nvarchar(40),
    [SoldProductGroup]               nvarchar(9),
    [CustomerGroup]                  nvarchar(2),
    [CustomerSupplierCountry]        nvarchar(3),
    [CustomerSupplierIndustry]       nvarchar(4),
    [SalesDistrict]                  nvarchar(6),
    [BillToParty]                    nvarchar(10),
    [ShipToParty]                    nvarchar(10),
    [CustomerSupplierCorporateGroup] nvarchar(10),
    [CashLedgerCompanyCode]          nvarchar(4),
    [CashLedgerAccount]              nvarchar(10),
    [FinancialManagementArea]        nvarchar(4),
    [FundsCenter]                    nvarchar(16),
    [FundedProgram]                  nvarchar(24),
    [Fund]                           nvarchar(10),
    [GrantID]                        nvarchar(20),
    [BudgetPeriod]                   nvarchar(10),
    [PartnerFund]                    nvarchar(10),
    [PartnerGrant]                   nvarchar(20),
    [PartnerBudgetPeriod]            nvarchar(10),
    [PubSecBudgetAccount]            nvarchar(10),
    [PubSecBudgetAccountCoCode]      nvarchar(4),
    [PubSecBudgetCnsmpnDate]         date,
    [PubSecBudgetCnsmpnFsclPeriod]   char(3) collate Latin1_General_100_BIN2,
    [PubSecBudgetCnsmpnFsclYear]     char(4) collate Latin1_General_100_BIN2,
    [PubSecBudgetIsRelevant]         nvarchar(1),
    [PubSecBudgetCnsmpnType]         nvarchar(2),
    [PubSecBudgetCnsmpnAmtType]      nvarchar(4),
    [JointVenture]                   nvarchar(6),
    [JointVentureEquityGroup]        nvarchar(3),
    [JointVentureCostRecoveryCode]   nvarchar(2),
    [JointVenturePartner]            nvarchar(10),
    [JointVentureBillingType]        nvarchar(2),
    [JointVentureEquityType]         nvarchar(3),
    [JointVentureProductionDate]     date,
    [JointVentureBillingDate]        date,
    [JointVentureOperationalDate]    date,
    [CutbackRun]                     decimal(21, 7),
    [JointVentureAccountingActivity] nvarchar(2),
    [PartnerVenture]                 nvarchar(6),
    [PartnerEquityGroup]             nvarchar(3),
    [SenderCostRecoveryCode]         nvarchar(2),
    [CutbackAccount]                 nvarchar(10),
    [CutbackCostObject]              nvarchar(22),
    [SettlementReferenceDate]        date,
    [AccrualObjectType]              nvarchar(4),
    [AccrualObject]                  nvarchar(32),
    [AccrualSubobject]               nvarchar(32),
    [AccrualItemType]                nvarchar(11),
    [AccrualValueDate]               date,
    [FinancialValuationObjectType]   nvarchar(4),
    [FinancialValuationObject]       nvarchar(32),
    [FinancialValuationSubobject]    nvarchar(32),
    [NetDueDate]                     date,
    [CreditRiskClass]                nvarchar(3),
    [WorkCenterInternalID]           char(8) collate Latin1_General_100_BIN2,
    [OrderOperation]                 nvarchar(4),
    [OrderItem]                      char(4) collate Latin1_General_100_BIN2,
    [OrderSuboperation]              nvarchar(4),
    [Equipment]                      nvarchar(18),
    [FunctionalLocation]             nvarchar(30),
    [Assembly]                       nvarchar(40),
    [MaintenanceActivityType]        nvarchar(3),
    [MaintenanceOrderPlanningCode]   nvarchar(1),
    [MaintPriorityType]              nvarchar(2),
    [MaintPriority]                  nvarchar(1),
    [SuperiorOrder]                  nvarchar(12),
    [ProductGroup]                   nvarchar(9),
    [MaintenanceOrderIsPlanned]      nvarchar(1),
    [KMVKBUPA]                       nvarchar(3),
    [t_applicationId]                VARCHAR(32),
    [t_jobId]                        VARCHAR(36),
    [t_jobDtm]                       DATETIME,
    [t_jobBy]                        NVARCHAR(128),
    [t_extractionDtm]                DATETIME,
    [t_filePath]                     NVARCHAR(1024),
     CONSTRAINT [PK_I_GLAccountLineItemRawData] PRIMARY KEY NONCLUSTERED (
    [MANDT], [SourceLedger], [CompanyCode], [FiscalYear], [AccountingDocument], [LedgerGLLineItem]
  ) NOT ENFORCED
)
WITH (
  HEAP
)
