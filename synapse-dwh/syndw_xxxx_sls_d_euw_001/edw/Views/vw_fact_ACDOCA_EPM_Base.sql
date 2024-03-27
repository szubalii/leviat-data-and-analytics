CREATE VIEW [edw].[vw_fact_ACDOCA_EPM_Base]
AS

WITH orig AS (
SELECT
  GLALIRD.[SourceLedgerID],
  GLALIRD.[CompanyCodeID],
  GLALIRD.[CompanyCodeID] + GLALIRD.[ProfitCenterID] as [SKReportingEntityKey],
  CASE
    WHEN COALESCE (GLALIRD.[ProductSurrogateKey], '') = ''
    THEN CONCAT('(MA)-', GLALIRD.[GLAccountID])
    ELSE GLALIRD.[ProductSurrogateKey]
  END                                             AS [ProductSurrogateKey],
  GLALIRD.[GLAccountID]+GLALIRD.[FunctionalAreaID] AS [nk_ExQLmap],
  GLALIRD.[FiscalYear],
  GLALIRD.[AccountingDocument],
  GLALIRD.[LedgerGLLineItem],
  GLALIRD.[LedgerFiscalYear],
  GLALIRD.[GLRecordTypeID],
  GLALIRD.[ChartOfAccountsID],
  GLALIRD.[ControllingAreaID],
  GLALIRD.[FinancialTransactionTypeID],
  GLALIRD.[BusinessTransactionTypeID],
  GLALIRD.[ControllingBusTransacTypeID],
  GLALIRD.[ReferenceDocumentTypeID],
  GLALIRD.[ReferenceDocumentContextID],
  GLALIRD.[ReferenceDocument],
  GLALIRD.[ReferenceDocumentItem],
  GLALIRD.[ReferenceDocumentItemGroupID],
  GLALIRD.[IsReversal],
  GLALIRD.[IsReversed],
  GLALIRD.[PredecessorReferenceDocTypeID],
  GLALIRD.[ReversalReferenceDocumentCntxtID],
  GLALIRD.[ReversalReferenceDocument],
  GLALIRD.[IsSettlement],
  GLALIRD.[IsSettled],
  GLALIRD.[PredecessorReferenceDocument],
  GLALIRD.[PredecessorReferenceDocItem],
  GLALIRD.[SourceReferenceDocumentTypeID],
  GLALIRD.[SourceReferenceDocument],
  GLALIRD.[SourceReferenceDocumentItem],
  GLALIRD.[IsCommitment],
  GLALIRD.[JrnlEntryItemObsoleteReasonID],
  GLALIRD.[GLAccountID],
  GLALIRD.[CostCenterID],
  GLALIRD.[ProfitCenterID],
  GLALIRD.[FunctionalAreaID],
  GLALIRD.[BusinessAreaID],          
  GLALIRD.[SegmentID],
  GLALIRD.[PartnerCostCenterID],
  GLALIRD.[PartnerProfitCenterID],
  GLALIRD.[PartnerFunctionalAreaID],
  GLALIRD.[PartnerBusinessAreaID],
  GLALIRD.[PartnerCompanyID],
  GLALIRD.[PartnerSegmentID],
  GLALIRD.[BalanceTransactionCurrency],
  -- GLALIRD.[AmountInBalanceTransacCrcy],
  -- GLALIRD.[TransactionCurrency],
  -- GLALIRD.[AmountInTransactionCurrency],
  -- GLALIRD.[CompanyCodeCurrency],
  CASE ZED.Contingency5
    WHEN 'Sales'
    THEN -1 * GLALIRD.[AmountInCompanyCodeCurrency] * ExchangeRate.ExchangeRate
    ELSE null
  END AS [SalesAmount],
  CASE ZED.Contingency5
    WHEN 'COGS'
    THEN -1 * GLALIRD.[AmountInCompanyCodeCurrency] * ExchangeRate.ExchangeRate
    ELSE null
  END AS [COGSActCostAmount],
  CASE
    WHEN ZED.Contingency5 = 'COGS' AND GLALIRD.[AccountingDocumentTypeID] <> 'ML'
    THEN -1 * GLALIRD.[AmountInCompanyCodeCurrency] * ExchangeRate.ExchangeRate
    ELSE null
  END AS [COGSStdCostAmount],
  CASE ZED.Contingency5
    WHEN 'Other CoS'
    THEN -1 * GLALIRD.[AmountInCompanyCodeCurrency] * ExchangeRate.ExchangeRate
    ELSE null
  END AS [OtherCoSAmount],
  CASE ZED.Contingency5
    WHEN 'Opex'
    THEN -1 * GLALIRD.[AmountInCompanyCodeCurrency] * ExchangeRate.ExchangeRate
    ELSE null
  END AS [OpexAmount],
  CASE ZED.Contingency4
    WHEN 'Gross Margin'
    THEN -1 * GLALIRD.[AmountInCompanyCodeCurrency] * ExchangeRate.ExchangeRate
    ELSE null
  END AS [GrossMarginAmount],
  CASE
    WHEN ZED.Contingency5 = 'COGS'
    THEN 'COGSAct'
    WHEN ZED.Contingency5 = 'COGS' AND GLALIRD.[AccountingDocumentTypeID] <> 'ML'    --it's unreachable code at the moment, reserved for future needs
    THEN 'COGSStd'
    ELSE ZED.Contingency5
    
  END AS [AmountCategory],
  -1 * GLALIRD.[AmountInCompanyCodeCurrency] * ExchangeRate.ExchangeRate AS [Amount],
  GLALIRD.[AmountInCompanyCodeCurrency],
  -- GLALIRD.[GlobalCurrency],
  GLALIRD.[AmountInGlobalCurrency],
  GLALIRD.[FreeDefinedCurrency1],
  GLALIRD.[AmountInFreeDefinedCurrency1],
  GLALIRD.[FreeDefinedCurrency2],
  GLALIRD.[AmountInFreeDefinedCurrency2],
  GLALIRD.[BaseUnit],
  GLALIRD.[Quantity],
  GLALIRD.[DebitCreditID],
  GLALIRD.[FiscalPeriod],
  GLALIRD.[FiscalYearVariant],
  GLALIRD.[FiscalYearPeriod],
  GLALIRD.[PostingDate],
  GLALIRD.[DocumentDate],
  GLALIRD.[AccountingDocumentTypeID],
  GLALIRD.[AccountingDocumentItem],
  GLALIRD.[AssignmentReference],
  GLALIRD.[AccountingDocumentCategoryID],
  GLALIRD.[PostingKeyID],
  GLALIRD.[TransactionTypeDeterminationID],
  GLALIRD.[SubLedgerAcctLineItemTypeID],
  GLALIRD.[AccountingDocCreatedByUserID],
  GLALIRD.[LastChangeDateTime],
  GLALIRD.[CreationDateTime],
  GLALIRD.[CreationDate],
  GLALIRD.[OriginObjectTypeID],
  GLALIRD.[GLAccountTypeID],
  GLALIRD.[InvoiceReference],
  GLALIRD.[InvoiceReferenceFiscalYear],
  GLALIRD.[InvoiceItemReference],
  GLALIRD.[ReferencePurchaseOrderCategoryID],
  GLALIRD.[PurchasingDocument],
  GLALIRD.[PurchasingDocumentItem],
  GLALIRD.[AccountAssignmentNumber],
  GLALIRD.[DocumentItemText],
  GLALIRD.[SalesDocumentID],
  GLALIRD.[SalesDocumentItemID],
  CASE
      WHEN COALESCE (GLALIRD.[ProductID], '') = ''
      THEN 
        CASE 
            WHEN COALESCE (GLALIRD.[SDI_MaterialID], '') <> ''
            THEN GLALIRD.[SDI_MaterialID]
            ELSE GLALIRD.[SoldProduct]
        END
      ELSE GLALIRD.[ProductID]
  END                                                                AS [ProductID],
  GLALIRD.[PlantID],
  GLALIRD.[SupplierID],
  CASE
    WHEN COALESCE (GLALIRD.[CustomerID], '') = ''
    THEN GLALIRD.[SDI_SoldToPartyID]
    ELSE GLALIRD.[CustomerID]
  END                                                                AS [CustomerID],
  GLALIRD.[ExchangeRateDate],
  GLALIRD.[FinancialAccountTypeID],
  GLALIRD.[SpecialGLCodeID],
  GLALIRD.[TaxCodeID],
  GLALIRD.[ClearingDate],
  GLALIRD.[ClearingAccountingDocument],
  GLALIRD.[ClearingDocFiscalYear],
  GLALIRD.[LineItemIsCompleted],
  GLALIRD.[PersonnelNumber],
  GLALIRD.[PartnerCompanyCodeID],
  GLALIRD.[OriginProfitCenterID],
  GLALIRD.[OriginCostCenterID],
  GLALIRD.[AccountAssignmentID],
  GLALIRD.[AccountAssignmentTypeID],
  GLALIRD.[CostCtrActivityTypeID],
  GLALIRD.[OrderID],
  GLALIRD.[OrderCategoryID],
  GLALIRD.[WBSElementID],
  GLALIRD.[ProjectInternalID],
  GLALIRD.[ProjectID],
  GLALIRD.[OperatingConcernID],
  GLALIRD.[BusinessProcessID],
  GLALIRD.[CostObjectID],
  GLALIRD.[BillableControlID],    
  GLALIRD.[ServiceDocumentTypeID],
  GLALIRD.[ServiceDocument],
  GLALIRD.[ServiceDocumentItem],
  GLALIRD.[BillingDocumentTypeID],
  CASE 
    WHEN COALESCE (GLALIRD.[SalesOrganizationID], '') = ''
    THEN GLALIRD.[SDI_SalesOrganizationID]
    ELSE GLALIRD.[SalesOrganizationID]
  END                                                                AS [SalesOrganizationID],
  GLALIRD.[DistributionChannelID],
  CASE
    WHEN GLALIRD.[BillingDocumentTypeID] = ''
    AND COALESCE (GLALIRD.[SalesDistrictID], '') = ''
      THEN 'MA-Dummy'
    ELSE GLALIRD.[SalesDistrictID]
  END                                                 AS [SalesDistrictID],
  GLALIRD.[BillToPartyID],
  CASE
    WHEN GLALIRD.[BillingDocumentTypeID] = ''
    AND COALESCE (GLALIRD.[ShipToPartyID], '') = ''
      THEN CONCAT('(MA)-', GLALIRD.[GLAccountID])
    ELSE GLALIRD.[ShipToPartyID]
  END                                             AS [ShipToParty],
  CASE 
    WHEN GLALIRD.[BillingDocumentTypeID] = ''
    THEN 1
    ELSE 0
  END                                             AS [ManualAdjustment],
CASE
    WHEN GLALIRD.[GLAccountID] = '0052300351'
    AND  YEAR(GLALIRD.[PostingDate]) < '2024'
    THEN 1

    WHEN GLALIRD.[GLAccountID] IN (
      '0049000109',
      '0049000150',
      '0052300350',
      '0052300352'
    )
    THEN 1

    WHEN 
    (GLALIRD.[GLAccountID] = '0052300310' AND GLALIRD.[AccountingDocumentTypeID] <> 'ML')
    OR
    (GLALIRD.[GLAccountID] = '0052900635' AND GLALIRD.[AccountingDocumentTypeID] <> 'ML')
    THEN 1

    ELSE 0
  END                                             AS [TPAdjustment],
  CASE
    WHEN GLALIRD.[BillingDocumentTypeID] = ''
    AND COALESCE (PSD.FirstSalesSpecProductGroup, '') = ''
    THEN 'MA-Dummy'
    ELSE PSD.FirstSalesSpecProductGroup
  END                                                 AS [BrandID],
  CASE
    WHEN GLALIRD.[BillingDocumentTypeID] = ''
    AND COALESCE (PSD.FirstSalesSpecProductGroup, '') = ''
    THEN 'MA'
    ELSE DimBrand.Brand
  END                                                 AS [Brand],
  edw.svf_getInOutID_EPM (GLALIRD.CustomerID,GLALIRD.ProfitCenterTypeID )
                                                      AS [InOutID],
  CASE
    WHEN GLALIRD.[BillingDocumentTypeID] = ''
    AND COALESCE (dimBDT.[BillingDocumentType], '') = ''
    THEN 'MA'
    ELSE dimBDT.[BillingDocumentType]
  END                                                AS [BillingDocumentType],
  ExchangeRate.[TargetCurrency]                      AS [CurrencyID],
  ExchangeRate.[CurrencyTypeID],
  CurrType.[CurrencyType],
  GLALIRD.[SalesOfficeID],
  GLALIRD.[SoldProduct],
  CASE
    WHEN GLALIRD.ProfitCenterTypeID = '2' and GLALIRD.CustomerID like '005%' then 'External'
    WHEN GLALIRD.ProfitCenterTypeID = '3' and GLALIRD.CustomerID like '005%' then 'Intracompany'
    WHEN GLALIRD.ProfitCenterTypeID in ('2', '3') and GLALIRD.CustomerID like 'I%' then 'Intercompany'
    ELSE ''
  END AS CustomerCategory,
  GLALIRD.SalesReferenceDocumentCalculated,
  GLALIRD.SalesReferenceDocumentItemCalculated,
  GLALIRD.SalesDocumentItemCategoryID,
  GLALIRD.HigherLevelItem,
  ZED.[GLAccountID] AS EXQL_GLAccountID,
  ZED.[FunctionalAreaID] AS EXQL_FunctionalAreaID,
  GLALIRD.[ProjectNumber],
  -- GLALIRD.[ProjectNumber] AS [ProjectNumberCalculated],
  CASE
    WHEN
      GLALIRD.ProjectNumber IS NULL
      OR
      GLALIRD.ProjectNumber = ''
    THEN
      CASE
        WHEN
          GLALIRD.SalesReferenceDocumentCalculated IS NOT NULL
          AND
          GLALIRD.SalesReferenceDocumentCalculated <> ''
        THEN proj.ProjectID
        ELSE ''
      END
    ELSE GLALIRD.ProjectNumber
  END AS [ProjectNumberCalculated],
  edw.[svf_getManual_JE_KPI](
    GLALIRD.AccountingDocumentTypeID,
    GLALIRD.BusinessTransactionTypeID,
    GLALIRD.ReferenceDocumentTypeID,
    GLALIRD.AmountInCompanyCodeCurrency
  ) * ExchangeRate.ExchangeRate AS [Manual_JE_KPI],
  CASE
    WHEN
      GLALIRD.GLAccountID IN (
        SELECT GLAccountID
        FROM base_ff.IC_ReconciliationGLAccounts
      )
      AND
      GLALIRD.PartnerCompanyID <> ''
    THEN AmountInCompanyCodeCurrency * ExchangeRate.ExchangeRate
  END AS [IC_Balance_KPI],
  edw.[svf_getInventory_Adj_KPI](
    GLALIRD.BusinessTransactionTypeID,
    GLALIRD.TransactionTypeDeterminationID,
    GLALIRD.AmountInCompanyCodeCurrency
  ) * ExchangeRate.ExchangeRate AS [Inventory_Adj_KPI],
  ZED.[Contingency6] AS GMElementL1,
  CASE
    WHEN ZED.[Contingency6] = 'COGS'
    THEN
        CASE WHEN GLALIRD.[AccountingDocumentTypeID] = 'ML'
             THEN 'Material ledger actual costing run'
             ELSE 'Standard COGS' 
        END
    ELSE ZED.[Contingency7] 
  END AS GMElementL2,
  GLALIRD.[SDI_SoldToPartyID] AS SoldToPartyID,
  GLALIRD.[t_applicationId],
  GLALIRD.[t_extractionDtm]
FROM edw.[fact_ACDOCA] GLALIRD
LEFT JOIN [edw].[dim_ZE_EXQLMAP_DT] ZED
  ON GLALIRD.[GLAccountID] = ZED.[GLAccountID]
    AND GLALIRD.[FunctionalAreaID] = ZED.[FunctionalAreaID]
/*INNER JOIN [edw].[dim_FinancialStatementHierarchy] FSH
    ON GLALIRD.[GLAccountID] = FSH.LowerBoundaryAccount                     COLLATE DATABASE_DEFAULT
INNER JOIN [edw].[dim_FinancialStatementItem]   FSI
    ON FSH.[FinancialStatementItem] = FSI.[FinancialStatementItem]          COLLATE DATABASE_DEFAULT*/
LEFT JOIN
  [edw].[dim_BillingDocumentType] dimBDT
  ON
    GLALIRD.BillingDocumentTypeID = dimBDT.[BillingDocumentTypeID]
LEFT JOIN
  [edw].[dim_ProductSalesDelivery] PSD
  ON
    GLALIRD.[ProductID] = PSD.[ProductID]
    AND
    GLALIRD.[SalesOrganizationID] = PSD.[SalesOrganizationID]
    AND
    GLALIRD.[DistributionChannelID] = PSD.[DistributionChannelID]
LEFT JOIN
  [edw].[vw_CurrencyConversionRate] ExchangeRate
  ON
    GLALIRD.[CompanyCodeCurrency] = ExchangeRate.[SourceCurrency]
INNER JOIN
  [dm_sales].[vw_dim_CurrencyType] CurrType
  ON
    ExchangeRate.CurrencyTypeID = CurrType.CurrencyTypeID
LEFT JOIN
  [edw].[dim_Brand] DimBrand
  ON
    PSD.FirstSalesSpecProductGroup = DimBrand.[BrandID]
LEFT JOIN
  [edw].[dim_BillingDocProject] proj
  ON
    GLALIRD.[SalesReferenceDocumentCalculated] = proj.[SDDocument]
WHERE
  ExchangeRate.CurrencyTypeID <> '00'
)

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
  [AmountInCompanyCodeCurrency],
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
  CASE
     WHEN [BillingDocumentTypeID] = ''
      AND COALESCE ([ProductID], '') = ''
     THEN CONCAT('(MA)-', [GLAccountID])
     ELSE [ProductID]
  END                                             AS [ProductID],
  [PlantID],
  [SupplierID],
  CASE
     WHEN [BillingDocumentTypeID] = ''
      AND COALESCE ([CustomerID], '') = ''
     THEN CONCAT('(MA)-',[GLAccountID])
     ELSE [CustomerID]
  END                                             AS [CustomerID],
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
  CASE
    WHEN [BillingDocumentTypeID] = ''
      THEN 'MA'
    ELSE [BillingDocumentTypeID]
  END                                                 AS [BillingDocumentTypeID],
  CASE
     WHEN [BillingDocumentTypeID] = ''
      AND COALESCE ([SalesOrganizationID], '') = ''
     THEN 'MA-Dummy'
     ELSE [SalesOrganizationID]
  END                                                 AS [SalesOrganizationID],
  [DistributionChannelID],
  [SalesDistrictID],
  [BillToPartyID],
  [ShipToParty],
  [ManualAdjustment],
  [TPAdjustment],
  [BrandID],
  [Brand],
  [InOutID],
  CASE
    WHEN [BillingDocumentTypeID] = ''
     AND COALESCE (CSA.[CustomerGroup], '') = ''
    THEN
        CASE 
            WHEN COALESCE ([SoldToPartyID], '') = ''
            THEN 'MA'
            ELSE ''
        END
     ELSE CSA.[CustomerGroup]
  END                                                 AS [CustomerGroupID],
  CASE
    WHEN [BillingDocumentTypeID] = ''
     AND COALESCE (CSA.[CustomerGroup], '') = ''
    THEN 
        CASE 
            WHEN COALESCE ([SoldToPartyID], '') = ''
            THEN 'Manual Adjustment'
            ELSE ''
        END
    ELSE dimCGr.CustomerGroup
  END                                                 AS [CustomerGroup],
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
  [GMElementL1],
  [GMElementL2],
  orig.[t_applicationId],
  orig.[t_extractionDtm]
FROM orig 
LEFT JOIN
  [base_s4h_cax].[I_CustomerSalesArea] CSA
  ON
    orig.[CustomerID] = CSA.[Customer]
    AND
    orig.[SalesOrganizationID] = CSA.[SalesOrganization]
LEFT JOIN
  [edw].[dim_CustomerGroup] dimCGr
  ON
    CSA.CustomerGroup = dimCGr.[CustomerGroupID]