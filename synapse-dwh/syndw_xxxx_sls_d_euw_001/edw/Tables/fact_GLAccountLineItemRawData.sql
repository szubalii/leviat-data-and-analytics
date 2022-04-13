CREATE TABLE [edw].[fact_GLAccountLineItemRawData] (
-- Raw Data of G/L Account Line Item
--   [TS_SEQUENCE_NUMBER] INTEGER NOT NULL
-- , [ODQ_CHANGEMODE] CHAR(1)
-- , [ODQ_ENTITYCNTR] NUMERIC(19,0)
  [SourceLedger] nvarchar(4) NOT NULL
, [CompanyCodeID] nvarchar(8) NOT NULL --renamed (ex CompanyCode)
, [FiscalYear] char(4) collate Latin1_General_100_BIN2 NOT NULL
, [AccountingDocument] nvarchar(20) NOT NULL
, [LedgerGLLineItem] nvarchar(12) NOT NULL
, [LedgerFiscalYear] char(4) collate Latin1_General_100_BIN2
, [GLRecordTypeID] nvarchar(2) --renamed (ex GLRecordType)
, [ChartOfAccounts] nvarchar(8)
, [ControllingArea] nvarchar(8)
, [FinancialTransactionTypeID] nvarchar(6) --renamed (ex FinancialTransactionType)
, [BusinessTransactionTypeID] nvarchar(8) --renamed (BusinessTransactionType) 
, [ControllingBusTransacType] nvarchar(8)
, [ReferenceDocumentType] nvarchar(10)
, [LogicalSystem] nvarchar(20)
, [ReferenceDocumentContext] nvarchar(20)
, [ReferenceDocument] nvarchar(20)
, [ReferenceDocumentItem] char(6) collate Latin1_General_100_BIN2
, [ReferenceDocumentItemGroup] char(6) collate Latin1_General_100_BIN2
--, [TransactionSubitem] char(6) collate Latin1_General_100_BIN2
, [IsReversal] nvarchar(2)
, [IsReversed] nvarchar(2)
, [ReversalReferenceDocumentCntxt] nvarchar(20)
, [ReversalReferenceDocument] nvarchar(20)
, [IsSettlement] nvarchar(2)
, [IsSettled] nvarchar(2)
, [PredecessorReferenceDocType] nvarchar(10)
, [PredecessorReferenceDocCntxt] nvarchar(20)
, [PredecessorReferenceDocument] nvarchar(20)
, [PredecessorReferenceDocItem] char(6) collate Latin1_General_100_BIN2
--, [PrdcssrJournalEntryCompanyCode] nvarchar(8)
--, [PrdcssrJournalEntryFiscalYear] char(4) collate Latin1_General_100_BIN2
--, [PredecessorJournalEntry] nvarchar(20)
--, [PredecessorJournalEntryItem] nvarchar(12)
, [SourceReferenceDocumentType] nvarchar(10)
, [SourceLogicalSystem] nvarchar(20)
, [SourceReferenceDocumentCntxt] nvarchar(20)
, [SourceReferenceDocument] nvarchar(20)
, [SourceReferenceDocumentItem] char(6) collate Latin1_General_100_BIN2
, [SourceReferenceDocSubitem] char(6) collate Latin1_General_100_BIN2
, [IsCommitment] nvarchar(2)
, [JrnlEntryItemObsoleteReason] nvarchar(2)
--, [JrnlPeriodEndClosingRunLogUUID] binary(16)
--, [OrganizationalChange] nvarchar(20)
, [GLAccountID] nvarchar(20) --renamed (GLAccount)
, [CostCenterID] nvarchar(20) --renamed (CostCenter)
, [ProfitCenterID] nvarchar(20) --renamed (ProfitCenter)
, [FunctionalAreaID] nvarchar(32) --renamed (FunctionalArea)
, [BusinessArea] nvarchar(8)
, [Segment] nvarchar(20)
, [PartnerCostCenter] nvarchar(20)
, [PartnerProfitCenter] nvarchar(20)
, [PartnerFunctionalArea] nvarchar(32)
, [PartnerBusinessArea] nvarchar(8)
, [PartnerCompany] nvarchar(12)
, [PartnerSegment] nvarchar(20)
, [BalanceTransactionCurrency] char(5) collate Latin1_General_100_BIN2
, [AmountInBalanceTransacCrcy] decimal(23,2)
, [TransactionCurrency] char(5) collate Latin1_General_100_BIN2
, [AmountInTransactionCurrency] decimal(23,2)
, [CompanyCodeCurrency] char(5) collate Latin1_General_100_BIN2
, [AmountInCompanyCodeCurrency] decimal(23,2)
, [GlobalCurrency] char(5) collate Latin1_General_100_BIN2
, [AmountInGlobalCurrency] decimal(23,2)
, [FreeDefinedCurrency1] char(5) collate Latin1_General_100_BIN2
, [AmountInFreeDefinedCurrency1] decimal(23,2)
, [FreeDefinedCurrency2] char(5) collate Latin1_General_100_BIN2
, [AmountInFreeDefinedCurrency2] decimal(23,2)
, [FreeDefinedCurrency3] char(5) collate Latin1_General_100_BIN2
, [AmountInFreeDefinedCurrency3] decimal(23,2)
, [FreeDefinedCurrency4] char(5) collate Latin1_General_100_BIN2
, [AmountInFreeDefinedCurrency4] decimal(23,2)
, [FreeDefinedCurrency5] char(5) collate Latin1_General_100_BIN2
, [AmountInFreeDefinedCurrency5] decimal(23,2)
, [FreeDefinedCurrency6] char(5) collate Latin1_General_100_BIN2
, [AmountInFreeDefinedCurrency6] decimal(23,2)
, [FreeDefinedCurrency7] char(5) collate Latin1_General_100_BIN2
, [AmountInFreeDefinedCurrency7] decimal(23,2)
, [FreeDefinedCurrency8] char(5) collate Latin1_General_100_BIN2
, [AmountInFreeDefinedCurrency8] decimal(23,2)
, [FixedAmountInGlobalCrcy] decimal(23,2)
, [GrpValnFixedAmtInGlobCrcy] decimal(23,2)
, [PrftCtrValnFxdAmtInGlobCrcy] decimal(23,2)
, [FixedAmountInCoCodeCrcy] decimal(23,2)
, [TotalPriceVarcInGlobalCrcy] decimal(23,2)
, [GrpValnTotPrcVarcInGlobCrcy] decimal(23,2)
, [PrftCtrValnTotPrcVarcInGlbCrcy] decimal(23,2)
, [FixedPriceVarcInGlobalCrcy] decimal(23,2)
, [GrpValnFixedPrcVarcInGlobCrcy] decimal(23,2)
, [PrftCtrValnFxdPrcVarcInGlbCrcy] decimal(23,2)
, [ControllingObjectCurrency] char(5) collate Latin1_General_100_BIN2
, [AmountInObjectCurrency] decimal(23,2)
--, [GrantCurrency] char(5) collate Latin1_General_100_BIN2
--, [AmountInGrantCurrency] decimal(23,2)
, [BaseUnit] nvarchar(6) collate Latin1_General_100_BIN2
, [Quantity] decimal(23,3)
, [FixedQuantity] decimal(23,3)
, [CostSourceUnit] nvarchar(6) collate Latin1_General_100_BIN2
, [ValuationQuantity] decimal(23,3)
, [ValuationFixedQuantity] decimal(23,3)
--, [ReferenceQuantityUnit] nvarchar(6) collate Latin1_General_100_BIN2
--, [ReferenceQuantity] decimal(23,3)
, [AdditionalQuantity1Unit] nvarchar(6) collate Latin1_General_100_BIN2
, [AdditionalQuantity1] decimal(23,3)
, [AdditionalQuantity2Unit] nvarchar(6) collate Latin1_General_100_BIN2
, [AdditionalQuantity2] decimal(23,3)
, [AdditionalQuantity3Unit] nvarchar(6) collate Latin1_General_100_BIN2
, [AdditionalQuantity3] decimal(23,3)
, [DebitCreditCodeID] nvarchar(2) --renamed (DebitCreditCode)
, [FiscalPeriod] char(3) collate Latin1_General_100_BIN2
, [FiscalYearVariant] nvarchar(4)
, [FiscalYearPeriod] char(7) collate Latin1_General_100_BIN2
, [PostingDate] date
, [DocumentDate] date
, [AccountingDocumentTypeID] nvarchar(4) --renamed (AccountingDocumentType)
, [AccountingDocumentItem] char(3) collate Latin1_General_100_BIN2
, [AssignmentReference] nvarchar(36)
, [AccountingDocumentCategoryID] nvarchar(2) --renamed (AccountingDocumentCategory)
, [PostingKeyID] nvarchar(4) --renamed (PostingKey)
, [TransactionTypeDetermination] nvarchar(6)
, [SubLedgerAcctLineItemType] char(5) collate Latin1_General_100_BIN2
, [AccountingDocCreatedByUser] nvarchar(24)
, [LastChangeDateTime] decimal(15)
, [CreationDateTime] decimal(15)
, [CreationDate] date
, [EliminationProfitCenter] nvarchar(20)
, [OriginObjectType] char(2) collate Latin1_General_100_BIN2
, [GLAccountTypeID] nvarchar(2) --renamed (GLAccountType)
, [AlternativeGLAccount] nvarchar(20)
, [CountryChartOfAccounts] nvarchar(8)
, [ItemIsSplit] nvarchar(2)
, [InvoiceReference] nvarchar(20)
, [InvoiceReferenceFiscalYear] char(4) collate Latin1_General_100_BIN2
, [FollowOnDocumentType] nvarchar(2)
, [InvoiceItemReference] char(3) collate Latin1_General_100_BIN2
, [ReferencePurchaseOrderCategory] char(3) collate Latin1_General_100_BIN2
, [PurchasingDocument] nvarchar(20)
, [PurchasingDocumentItem] char(5) collate Latin1_General_100_BIN2
, [AccountAssignmentNumber] char(2) collate Latin1_General_100_BIN2
, [DocumentItemText] nvarchar(100)
, [SalesDocument] nvarchar(20)
, [SalesDocumentItem] char(6) collate Latin1_General_100_BIN2
, [Product] nvarchar(80)
, [Plant] nvarchar(8)
, [Supplier] nvarchar(20)
, [Customer] nvarchar(20)
, [ServicesRenderedDate] date
--, [PerformancePeriodStartDate] date
--, [PerformancePeriodEndDate] date
, [ConditionContract] nvarchar(20)
, [ExchangeRateDate] date
, [FinancialAccountType] nvarchar(2)
, [SpecialGLCode] nvarchar(2)
, [TaxCode] nvarchar(4)
--, [TaxCountry] nvarchar(6)
, [HouseBank] nvarchar(10)
, [HouseBankAccount] nvarchar(10)
, [IsOpenItemManaged] nvarchar(2)
, [ClearingDate] date
, [ClearingAccountingDocument] nvarchar(20)
, [ClearingDocFiscalYear] char(4) collate Latin1_General_100_BIN2
--, [ValueDate] date
, [AssetDepreciationArea] char(2) collate Latin1_General_100_BIN2
, [MasterFixedAsset] nvarchar(24)
, [FixedAsset] nvarchar(8)
, [AssetValueDate] date
, [AssetTransactionType] nvarchar(6)
, [AssetAcctTransClassfctn] nvarchar(4)
, [DepreciationFiscalPeriod] char(3) collate Latin1_General_100_BIN2
, [GroupMasterFixedAsset] nvarchar(24)
, [GroupFixedAsset] nvarchar(8)
, [AssetClass] nvarchar(16)
, [CostEstimate] char(12) collate Latin1_General_100_BIN2
, [InventorySpecialStockValnType] nvarchar(2)
, [InventorySpecialStockType] nvarchar(2)
, [InventorySpclStkSalesDocument] nvarchar(20)
, [InventorySpclStkSalesDocItm] char(6) collate Latin1_General_100_BIN2
, [InvtrySpclStockWBSElmntIntID] char(8) collate Latin1_General_100_BIN2
, [InventorySpclStockWBSElement] nvarchar(48)
, [InventorySpecialStockSupplier] nvarchar(20)
, [InventoryValuationType] nvarchar(20)
, [ValuationArea] nvarchar(8)
, [SenderCompanyCode] nvarchar(8)
, [SenderGLAccount] nvarchar(20)
, [SenderAccountAssignment] nvarchar(60)
, [SenderAccountAssignmentType] nvarchar(4)
, [ControllingObject] nvarchar(44)
, [CostOriginGroup] nvarchar(8)
, [OriginSenderObject] nvarchar(44)
, [ControllingDebitCreditCode] nvarchar(2)
--, [OriginCtrlgDebitCreditCode] nvarchar(2)
, [ControllingObjectDebitType] char(1) collate Latin1_General_100_BIN2
, [QuantityIsIncomplete] char(1) collate Latin1_General_100_BIN2
, [OffsettingAccount] nvarchar(20)
, [OffsettingAccountType] nvarchar(2)
, [OffsettingChartOfAccounts] nvarchar(8)
, [LineItemIsCompleted] nvarchar(2)
, [PersonnelNumber] char(8) collate Latin1_General_100_BIN2
, [ControllingObjectClass] nvarchar(4)
, [PartnerCompanyCode] nvarchar(8)
, [PartnerControllingObjectClass] nvarchar(4)
, [OriginProfitCenter] nvarchar(20)
, [OriginCostCtrActivityType] nvarchar(12)
, [OriginCostCenter] nvarchar(20)
--, [OriginProduct] nvarchar(80)
--, [VarianceOriginGLAccount] nvarchar(20)
, [AccountAssignment] nvarchar(60)
, [AccountAssignmentType] nvarchar(4)
, [CostCtrActivityType] nvarchar(12)
, [OrderID] nvarchar(24)
, [OrderCategory] char(2) collate Latin1_General_100_BIN2
, [WBSElementInternalID] char(8) collate Latin1_General_100_BIN2
, [WBSElement] nvarchar(48)
, [PartnerWBSElementInternalID] char(8) collate Latin1_General_100_BIN2
, [PartnerWBSElement] nvarchar(48)
, [ProjectInternalID] char(8) collate Latin1_General_100_BIN2
, [Project] nvarchar(48)
, [PartnerProjectInternalID] char(8) collate Latin1_General_100_BIN2
, [PartnerProject] nvarchar(48)
, [OperatingConcern] nvarchar(8)
, [ProjectNetwork] nvarchar(24)
, [RelatedNetworkActivity] nvarchar(8)
, [BusinessProcess] nvarchar(24)
, [CostObject] nvarchar(24)
, [BillableControl] nvarchar(4)
, [CostAnalysisResource] nvarchar(20)
, [CustomerServiceNotification] nvarchar(24)
, [ServiceDocumentType] nvarchar(8)
, [ServiceDocument] nvarchar(20)
, [ServiceDocumentItem] char(6) collate Latin1_General_100_BIN2
, [PartnerServiceDocumentType] nvarchar(8)
, [PartnerServiceDocument] nvarchar(20)
, [PartnerServiceDocumentItem] char(6) collate Latin1_General_100_BIN2
, [ServiceContractType] nvarchar(8)
, [ServiceContract] nvarchar(20)
, [ServiceContractItem] char(6) collate Latin1_General_100_BIN2
--, [BusinessSolutionOrder] nvarchar(20)
--, [BusinessSolutionOrderItem] char(6) collate Latin1_General_100_BIN2
, [TimeSheetOvertimeCategory] nvarchar(8)
, [PartnerAccountAssignment] nvarchar(60)
, [PartnerAccountAssignmentType] nvarchar(4)
, [WorkPackage] nvarchar(48)
, [WorkItem] nvarchar(20)
, [PartnerCostCtrActivityType] nvarchar(12)
, [PartnerOrder] nvarchar(24)
, [PartnerOrderCategory] char(2) collate Latin1_General_100_BIN2
, [PartnerSalesDocument] nvarchar(20)
, [PartnerSalesDocumentItem] char(6) collate Latin1_General_100_BIN2
, [PartnerProjectNetwork] nvarchar(24)
, [PartnerProjectNetworkActivity] nvarchar(8)
, [PartnerBusinessProcess] nvarchar(24)
, [PartnerCostObject] nvarchar(24)
--, [ControllingDocumentItem] char(3) collate Latin1_General_100_BIN2
, [BillingDocumentType] nvarchar(8)
, [SalesOrganizationID] nvarchar(8) --renamed (SalesOrganization)
, [DistributionChannelID] nvarchar(4) --renamed (DistributionChannel)
, [OrganizationDivision] nvarchar(4)
, [SoldProduct] nvarchar(80)
, [SoldProductGroup] nvarchar(18)
, [CustomerGroup] nvarchar(4)
, [CustomerSupplierCountry] nvarchar(6)
, [CustomerSupplierIndustry] nvarchar(8)
, [SalesDistrictID] nvarchar(12) --renamed (SalesDistrict)
, [BillToParty] nvarchar(20)
, [ShipToParty] nvarchar(20)
, [CustomerSupplierCorporateGroup] nvarchar(20)
, [CashLedgerCompanyCode] nvarchar(8)
, [CashLedgerAccount] nvarchar(20)
, [FinancialManagementArea] nvarchar(8)
, [FundsCenter] nvarchar(32)
, [FundedProgram] nvarchar(48)
, [Fund] nvarchar(20)
, [GrantID] nvarchar(40)
, [BudgetPeriod] nvarchar(20)
, [PartnerFund] nvarchar(20)
, [PartnerGrant] nvarchar(40)
, [PartnerBudgetPeriod] nvarchar(20)
, [PubSecBudgetAccount] nvarchar(20)
, [PubSecBudgetAccountCoCode] nvarchar(8)
, [PubSecBudgetCnsmpnDate] date
, [PubSecBudgetCnsmpnFsclPeriod] char(3) collate Latin1_General_100_BIN2
, [PubSecBudgetCnsmpnFsclYear] char(4) collate Latin1_General_100_BIN2
, [PubSecBudgetIsRelevant] nvarchar(2)
, [PubSecBudgetCnsmpnType] nvarchar(4)
, [PubSecBudgetCnsmpnAmtType] nvarchar(8)
--, [SponsoredProgram] nvarchar(40)
--, [SponsoredClass] nvarchar(40)
, [JointVenture] nvarchar(12)
, [JointVentureEquityGroup] nvarchar(6)
, [JointVentureCostRecoveryCode] nvarchar(4)
, [JointVenturePartner] nvarchar(20)
, [JointVentureBillingType] nvarchar(4)
, [JointVentureEquityType] nvarchar(6)
, [JointVentureProductionDate] date
, [JointVentureBillingDate] date
, [JointVentureOperationalDate] date
, [CutbackRun] decimal(21,7)
, [JointVentureAccountingActivity] nvarchar(4)
, [PartnerVenture] nvarchar(12)
, [PartnerEquityGroup] nvarchar(6)
, [SenderCostRecoveryCode] nvarchar(4)
, [CutbackAccount] nvarchar(20)
, [CutbackCostObject] nvarchar(44)
-- , [REBusinessEntity] nvarchar(16)
-- , [RealEstateBuilding] nvarchar(16)
-- , [RealEstateProperty] nvarchar(16)
-- , [RERentalObject] nvarchar(16)
-- , [RealEstateContract] nvarchar(26)
-- , [REServiceChargeKey] nvarchar(8)
-- , [RESettlementUnitID] nvarchar(10)
, [SettlementReferenceDate] date
-- , [REPartnerBusinessEntity] nvarchar(16)
-- , [RealEstatePartnerBuilding] nvarchar(16)
-- , [RealEstatePartnerProperty] nvarchar(16)
-- , [REPartnerRentalObject] nvarchar(16)
-- , [RealEstatePartnerContract] nvarchar(26)
-- , [REPartnerServiceChargeKey] nvarchar(8)
-- , [REPartnerSettlementUnitID] nvarchar(10)
-- , [PartnerSettlementReferenceDate] date
, [AccrualObjectType] nvarchar(8)
, [AccrualObject] nvarchar(64)
, [AccrualSubobject] nvarchar(64)
, [AccrualItemType] nvarchar(22)
, [AccrualValueDate] date
, [FinancialValuationObjectType] nvarchar(8)
, [FinancialValuationObject] nvarchar(64)
, [FinancialValuationSubobject] nvarchar(64)
, [NetDueDate] date
, [CreditRiskClass] nvarchar(6)
, [WorkCenterInternalID] char(8) collate Latin1_General_100_BIN2
, [OrderOperation] nvarchar(8)
, [OrderItem] char(4) collate Latin1_General_100_BIN2
--, [PartnerOrderItem] char(4) collate Latin1_General_100_BIN2
, [OrderSuboperation] nvarchar(8)
, [Equipment] nvarchar(36)
, [FunctionalLocation] nvarchar(60)
, [Assembly] nvarchar(80)
, [MaintenanceActivityType] nvarchar(6)
, [MaintenanceOrderPlanningCode] nvarchar(2)
, [MaintPriorityType] nvarchar(4)
, [MaintPriority] nvarchar(2)
, [SuperiorOrder] nvarchar(24)
, [ProductGroup] nvarchar(18)
, [MaintenanceOrderIsPlanned] nvarchar(2)
, [t_applicationId]       VARCHAR (32)
, [t_jobId]               VARCHAR (36)
, [t_jobDtm]              DATETIME
, [t_lastActionCd]        VARCHAR(1)
, [t_jobBy]               NVARCHAR(128)
, CONSTRAINT [PK_I_GLAccountLineItemRawData] PRIMARY KEY NONCLUSTERED ([SourceLedger],[CompanyCodeID],[FiscalYear],[AccountingDocument],[LedgerGLLineItem]) NOT ENFORCED
)
WITH
(
    DISTRIBUTION = HASH ([AccountingDocument]),
    CLUSTERED COLUMNSTORE INDEX
)
GO
