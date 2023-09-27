CREATE VIEW [dm_finance].[vw_fact_ACDOCA_FinanceKPI]
AS
SELECT
  [SourceLedgerID],
  [CompanyCodeID],
  [SKReportingEntityKey],
  [ProductSurrogateKey],
  [nk_ExQLmap],
  [FiscalYear],
  [AccountingDocument],
  [LedgerGLLineItem],
  [LedgerFiscalYear],
  [GLRecordTypeID],
  [ChartOfAccountsID],
  [ControllingAreaID],
  [FinancialTransactionTypeID],
  [BusinessTransactionTypeID],
  [ControllingBusTransacTypeID],
  [ReferenceDocumentTypeID],
  [ReferenceDocumentContextID],
  [ReferenceDocument],
  [ReferenceDocumentItem],
  [ReferenceDocumentItemGroupID],
  [IsReversal],
  [IsReversed],
  [PredecessorReferenceDocTypeID],
  [ReversalReferenceDocumentCntxtID],
  [ReversalReferenceDocument],
  [IsSettlement],
  [IsSettled],
  [PredecessorReferenceDocument],
  [PredecessorReferenceDocItem],
  [SourceReferenceDocumentTypeID],
  [SourceReferenceDocument],
  [SourceReferenceDocumentItem],
  [IsCommitment],
  [JrnlEntryItemObsoleteReasonID],
  [GLAccountID],
  [CostCenterID],
  [ProfitCenterID],
  [FunctionalAreaID],
  [BusinessAreaID],          
  [SegmentID],
  [PartnerCostCenterID],
  [PartnerProfitCenterID],
  [PartnerFunctionalAreaID],
  [PartnerBusinessAreaID],
  [PartnerCompanyID],
  [PartnerSegmentID],
  [BalanceTransactionCurrency],
  [SalesAmount],
  [COGSActCostAmount],
  [COGSStdCostAmount],
  [OtherCoSAmount],
  [OpexAmount],
  [GrossMarginAmount],
  [AmountCategory],
  [Amount],
  [AmountInGlobalCurrency],
  [FreeDefinedCurrency1],
  [AmountInFreeDefinedCurrency1],
  [FreeDefinedCurrency2],
  [AmountInFreeDefinedCurrency2],
  [BaseUnit],
  [Quantity],
  [DebitCreditID],
  [FiscalPeriod],
  [FiscalYearVariant],
  [FiscalYearPeriod],
  [PostingDate],
  [DocumentDate],
  [AccountingDocumentTypeID],
  [AccountingDocumentItem],
  [AssignmentReference],
  [AccountingDocumentCategoryID],
  [PostingKeyID],
  [TransactionTypeDeterminationID],
  [SubLedgerAcctLineItemTypeID],
  [AccountingDocCreatedByUserID],
  [LastChangeDateTime],
  [CreationDateTime],
  [CreationDate],
  [OriginObjectTypeID],
  [GLAccountTypeID],
  [InvoiceReference],
  [InvoiceReferenceFiscalYear],
  [InvoiceItemReference],
  [ReferencePurchaseOrderCategoryID],
  [PurchasingDocument],
  [PurchasingDocumentItem],
  [AccountAssignmentNumber],
  [DocumentItemText],
  [SalesDocumentID],
  [SalesDocumentItemID],
  [ProductID],
  [PlantID],
  [SupplierID],
  [CustomerID],
  [ExchangeRateDate],
  [FinancialAccountTypeID],
  [SpecialGLCodeID],
  [TaxCodeID],
  [ClearingDate],
  [ClearingAccountingDocument],
  [ClearingDocFiscalYear],
  [LineItemIsCompleted],
  [PersonnelNumber],
  [PartnerCompanyCodeID],
  [OriginProfitCenterID],
  [OriginCostCenterID],
  [AccountAssignmentID],
  [AccountAssignmentTypeID],
  [CostCtrActivityTypeID],
  [OrderID],
  [OrderCategoryID],
  [WBSElementID],
  [ProjectInternalID],
  [ProjectID],
  [OperatingConcernID],
  [BusinessProcessID],
  [CostObjectID],
  [BillableControlID],    
  [ServiceDocumentTypeID],
  [ServiceDocument],
  [ServiceDocumentItem],
  [BillingDocumentTypeID],
  [SalesOrganizationID],
  [DistributionChannelID],
  [SalesDistrictID],
  [BillToPartyID],
  [ShipToParty],
  [ManualAdjustment],
  [TPAdjustment],
  [BrandID],
  [Brand],
  [InOutID],
  [CustomerGroupID],
  [CustomerGroup],
  [BillingDocumentType],
  [CurrencyID],
  [CurrencyTypeID],
  [CurrencyType],
  [SalesOfficeID],
  [SoldProduct],
  [CustomerCategory],
  [SalesReferenceDocumentCalculated],
  [SalesReferenceDocumentItemCalculated],
  [SalesDocumentItemCategoryID],
  [HigherLevelItem],
  [EXQL_GLAccountID],
  [EXQL_FunctionalAreaID],
  [ProjectNumber],
  [ProjectNumberCalculated],
  [Manual_JE_KPI],
  [IC_Balance_KPI],
  [Inventory_Adj_KPI],
  [t_applicationId],
  [t_extractionDtm]
FROM
  [edw].[vw_fact_ACDOCA_EPM_Base]
WHERE (Manual_JE_KPI IS NOT NULL OR IC_Balance_KPI IS NOT NULL OR Inventory_Adj_KPI IS NOT NULL) AND SourceLedgerID IN ('0L','OC')