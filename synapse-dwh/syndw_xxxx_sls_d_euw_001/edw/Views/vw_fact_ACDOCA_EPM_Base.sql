CREATE VIEW [edw].[vw_fact_ACDOCA_EPM_Base]

AS

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
  CASE ZED.CONTIGENCY5
    WHEN 'Sales'
    THEN -1 * GLALIRD.[AmountInCompanyCodeCurrency] * ExchangeRate.ExchangeRate
    ELSE null
  END AS [SalesAmount],
  CASE ZED.CONTIGENCY5
    WHEN 'COGS'
    THEN -1 * GLALIRD.[AmountInCompanyCodeCurrency] * ExchangeRate.ExchangeRate
    ELSE null
  END AS [COGSActCostAmount],
  CASE
    WHEN ZED.CONTIGENCY5 = 'COGS' AND GLALIRD.[AccountingDocumentTypeID] <> 'ML'
    THEN -1 * GLALIRD.[AmountInCompanyCodeCurrency] * ExchangeRate.ExchangeRate
    ELSE null
  END AS [COGSStdCostAmount],
  CASE ZED.CONTIGENCY5
    WHEN 'Other CoS'
    THEN -1 * GLALIRD.[AmountInCompanyCodeCurrency] * ExchangeRate.ExchangeRate
    ELSE null
  END AS [OtherCoSAmount],
  CASE ZED.CONTIGENCY5
    WHEN 'Opex'
    THEN -1 * GLALIRD.[AmountInCompanyCodeCurrency] * ExchangeRate.ExchangeRate
    ELSE null
  END AS [OpexAmount],
  CASE ZED.CONTIGENCY4
    WHEN 'Gross Margin'
    THEN -1 * GLALIRD.[AmountInCompanyCodeCurrency] * ExchangeRate.ExchangeRate
    ELSE null
  END AS [GrossMarginAmount],
  CASE
    WHEN ZED.CONTIGENCY5 = 'COGS'
    THEN 'COGSAct'
    WHEN ZED.CONTIGENCY5 = 'COGS' AND GLALIRD.[AccountingDocumentTypeID] <> 'ML'    --it's unreachable code at the moment, reserved for future needs
    THEN 'COGSStd'
    ELSE ZED.CONTIGENCY5
  END AS [AmountCategory],
  -1 * GLALIRD.[AmountInCompanyCodeCurrency] * ExchangeRate.ExchangeRate AS [Amount],
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
    WHEN GLALIRD.[BillingDocumentTypeID] = ''
    AND COALESCE (GLALIRD.[ProductID], '') = ''
      THEN CONCAT('(MA)-', GLALIRD.[GLAccountID])
    ELSE GLALIRD.[ProductID]
  END                                             AS [ProductID],
  GLALIRD.[PlantID],
  GLALIRD.[SupplierID],
  CASE
    WHEN GLALIRD.[BillingDocumentTypeID] = ''
    AND COALESCE (GLALIRD.[CustomerID], '') = ''
      THEN CONCAT('(MA)-', GLALIRD.[GLAccountID])
    ELSE GLALIRD.[CustomerID]
  END                                             AS [CustomerID],
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
  CASE
    WHEN GLALIRD.[BillingDocumentTypeID] = ''
      THEN 'MA'
    ELSE GLALIRD.[BillingDocumentTypeID]
  END                                                 AS [BillingDocumentTypeID],
  CASE
    WHEN GLALIRD.[BillingDocumentTypeID] = ''
      AND COALESCE (GLALIRD.[SalesOrganizationID], '') = ''
      THEN 'MA-Dummy'
    ELSE GLALIRD.[SalesOrganizationID]
  END                                                 AS [SalesOrganizationID],
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
    WHEN GLALIRD.[GLAccountID] IN (
      '0049000109',
      '0049000150',
      '0052300310',
      '0052300350',
      '0052900635',
      '0052300351'
    )
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
    AND COALESCE (CSA.[CustomerGroup], '') = ''
    THEN 'MA'
    ELSE CSA.[CustomerGroup]
  END                                                 AS [CustomerGroupID],
  CASE
    WHEN GLALIRD.[BillingDocumentTypeID] = ''
    AND COALESCE (CSA.[CustomerGroup], '') = ''
    THEN 'Manual Adjustment'
    ELSE dimCGr.CustomerGroup
  END                                                 AS [CustomerGroup],
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
  CASE 
      WHEN GLALIRD.ProjectNumber IS NULL OR GLALIRD.ProjectNumber = '' THEN 
        CASE 
          WHEN GLALIRD.SalesReferenceDocumentCalculated IS NOT NULL OR GLALIRD.SalesReferenceDocumentCalculated <> ''
          THEN SDI.ProjectID
          ELSE ''
        END
      ELSE GLALIRD.ProjectNumber
  END AS [ProjectNumberCalculated],
  GLALIRD.[t_applicationId],
  GLALIRD.[t_extractionDtm]
FROM [edw].[fact_ACDOCA] GLALIRD
LEFT JOIN [edw].[dim_ZE_EXQLMAP_DT] ZED
  ON GLALIRD.[GLAccountID] = ZED.[GLAccountID]
    AND GLALIRD.[FunctionalAreaID] = ZED.[FunctionalAreaID]
/*INNER JOIN [edw].[dim_FinancialStatementHierarchy] FSH
    ON GLALIRD.[GLAccountID] = FSH.LowerBoundaryAccount                     COLLATE DATABASE_DEFAULT
INNER JOIN [edw].[dim_FinancialStatementItem]   FSI
    ON FSH.[FinancialStatementItem] = FSI.[FinancialStatementItem]          COLLATE DATABASE_DEFAULT*/
LEFT JOIN [edw].[dim_BillingDocumentType] dimBDT
  ON GLALIRD.BillingDocumentTypeID = dimBDT.[BillingDocumentTypeID]       COLLATE DATABASE_DEFAULT
LEFT JOIN [edw].[dim_ProductSalesDelivery] PSD
  ON GLALIRD.[ProductID] = PSD.[ProductID]                                COLLATE DATABASE_DEFAULT
    AND GLALIRD.[SalesOrganizationID] = PSD.[SalesOrganizationID]       COLLATE DATABASE_DEFAULT
    AND GLALIRD.[DistributionChannelID] = PSD.[DistributionChannelID]   COLLATE DATABASE_DEFAULT
LEFT JOIN [base_s4h_cax].[I_CustomerSalesArea] CSA
  ON GLALIRD.[CustomerID] = CSA.[Customer]                                COLLATE DATABASE_DEFAULT
    AND GLALIRD.[SalesOrganizationID] = CSA.[SalesOrganization]         COLLATE DATABASE_DEFAULT
LEFT JOIN [edw].[vw_CurrencyConversionRate] ExchangeRate
  ON GLALIRD.[CompanyCodeCurrency] = ExchangeRate.[SourceCurrency]
INNER JOIN [dm_sales].[vw_dim_CurrencyType]     CurrType
  ON ExchangeRate.CurrencyTypeID = CurrType.CurrencyTypeID
LEFT JOIN [edw].[dim_Brand] DimBrand
  ON PSD.FirstSalesSpecProductGroup = DimBrand.[BrandID]
LEFT JOIN [edw].[dim_CustomerGroup] dimCGr
  ON CSA.CustomerGroup = dimCGr.[CustomerGroupID]
LEFT JOIN  [edw].[fact_SalesDocumentItem] SDI
  ON GLALIRD.[SalesReferenceDocumentCalculated] = SDI.[SalesDocument]
    AND GLALIRD.[SalesReferenceDocumentItemCalculated] = SDI.[SalesDocumentItem]
WHERE ExchangeRate.CurrencyTypeID <> '00'