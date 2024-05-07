CREATE VIEW [edw].[vw_ACDOCA_delta]
AS
WITH PA AS (
  SELECT
    PurchaseOrder,
    PurchaseOrderItem,
    ICSalesDocumentID,
    ICSalesDocumentItemID
  FROM
    [edw].[dim_PurgAccAssignment]
  GROUP BY
    PurchaseOrder,
    PurchaseOrderItem,
    ICSalesDocumentID,
    ICSalesDocumentItemID
)

SELECT
  GLA.[ODQ_CHANGEMODE],
  GLA.[ODQ_ENTITYCNTR],
  GLA.[SourceLedger] AS [SourceLedgerID],
  GLA.[CompanyCode]  AS [CompanyCodeID],
  edw.svf_getProductSurrogateKey(
    VC.[ProductSurrogateKey],
    GLA.[Product],
    SoldProduct
  ) AS [ProductSurrogateKey],
  GLA.[FiscalYear],
  GLA.[AccountingDocument],
  GLA.[LedgerGLLineItem],
  GLA.[LedgerFiscalYear],
  GLA.[GLRecordType] AS [GLRecordTypeID],
  GLA.[ChartOfAccounts] AS [ChartOfAccountsID],
  GLA.[ControllingArea] AS [ControllingAreaID],
  GLA.[FinancialTransactionType] AS [FinancialTransactionTypeID],
  GLA.[BusinessTransactionType] AS [BusinessTransactionTypeID],
  GLA.[ControllingBusTransacType] AS [ControllingBusTransacTypeID],
  GLA.[ReferenceDocumentType] AS [ReferenceDocumentTypeID],
  GLA.[ReferenceDocumentContext] AS [ReferenceDocumentContextID],
  GLA.[ReferenceDocument],
  GLA.[ReferenceDocumentItem],
  GLA.[ReferenceDocumentItemGroup] AS [ReferenceDocumentItemGroupID],
  GLA.[IsReversal],
  GLA.[IsReversed],
  GLA.[PredecessorReferenceDocType] AS [PredecessorReferenceDocTypeID],
  GLA.[ReversalReferenceDocumentCntxt] AS [ReversalReferenceDocumentCntxtID],
  GLA.[ReversalReferenceDocument],
  GLA.[IsSettlement],
  GLA.[IsSettled],
  GLA.[PredecessorReferenceDocument],
  GLA.[PredecessorReferenceDocItem],
  GLA.[SourceReferenceDocumentType] AS [SourceReferenceDocumentTypeID],
  GLA.[SourceReferenceDocument],
  GLA.[SourceReferenceDocumentItem],
  GLA.[IsCommitment],
  GLA.[JrnlEntryItemObsoleteReason] AS [JrnlEntryItemObsoleteReasonID],
  GLA.[GLAccount] AS [GLAccountID],
  GLA.[CostCenter] AS [CostCenterID],
  GLA.[ProfitCenter] AS [ProfitCenterID],
  GLA.[FunctionalArea] AS [FunctionalAreaID],
  GLA.[BusinessArea] AS [BusinessAreaID],          
  GLA.[Segment] AS [SegmentID],
  GLA.[PartnerCostCenter] AS [PartnerCostCenterID],
  GLA.[PartnerProfitCenter] AS [PartnerProfitCenterID],
  GLA.[PartnerFunctionalArea] AS [PartnerFunctionalAreaID],
  GLA.[PartnerBusinessArea] AS [PartnerBusinessAreaID],
  GLA.[PartnerCompany] AS [PartnerCompanyID],
  GLA.[PartnerSegment] AS [PartnerSegmentID],
  GLA.[BalanceTransactionCurrency],
  GLA.[AmountInBalanceTransacCrcy],
  GLA.[TransactionCurrency],
  GLA.[AmountInTransactionCurrency],
  GLA.[CompanyCodeCurrency],
  GLA.[AmountInCompanyCodeCurrency],
  GLA.[GlobalCurrency],
  GLA.[AmountInGlobalCurrency],
  GLA.[FreeDefinedCurrency1],
  GLA.[AmountInFreeDefinedCurrency1],
  GLA.[FreeDefinedCurrency2],
  GLA.[AmountInFreeDefinedCurrency2],
  GLA.[BaseUnit],
  GLA.[Quantity],
  GLA.[DebitCreditCode] AS [DebitCreditID], 
  GLA.[FiscalPeriod], 
  GLA.[FiscalYearVariant],
  GLA.[FiscalYearPeriod],
  GLA.[PostingDate],
  GLA.[DocumentDate],
  GLA.[AccountingDocumentType] AS [AccountingDocumentTypeID],
  GLA.[AccountingDocumentItem],
  GLA.[AssignmentReference],
  GLA.[AccountingDocumentCategory] AS [AccountingDocumentCategoryID],
  GLA.[PostingKey] AS [PostingKeyID],
  GLA.[TransactionTypeDetermination] AS [TransactionTypeDeterminationID],
  GLA.[SubLedgerAcctLineItemType] AS [SubLedgerAcctLineItemTypeID],
  GLA.[AccountingDocCreatedByUser] AS [AccountingDocCreatedByUserID],
  GLA.[LastChangeDateTime],
  GLA.[CreationDateTime],
  GLA.[CreationDate],
  GLA.[OriginObjectType] AS [OriginObjectTypeID],
  GLA.[GLAccountType] AS [GLAccountTypeID],
  GLA.[InvoiceReference],
  GLA.[InvoiceReferenceFiscalYear],
  GLA.[InvoiceItemReference],
  GLA.[ReferencePurchaseOrderCategory] AS [ReferencePurchaseOrderCategoryID],
  GLA.[PurchasingDocument],
  GLA.[PurchasingDocumentItem],
  GLA.[AccountAssignmentNumber],
  GLA.[DocumentItemText],
  GLA.[SalesDocument] AS [SalesDocumentID],          
  GLA.[SalesDocumentItem] AS [SalesDocumentItemID],
  GLA.[Product] AS [ProductID],
  GLA.[Plant] AS [PlantID],
  GLA.[Supplier] AS [SupplierID],
  GLA.[Customer] AS [CustomerID],
  GLA.[ExchangeRateDate],                    
  GLA.[FinancialAccountType] AS [FinancialAccountTypeID],
  GLA.[SpecialGLCode] AS [SpecialGLCodeID],
  GLA.[TaxCode] AS [TaxCodeID],
  GLA.[ClearingDate],
  GLA.[ClearingAccountingDocument],
  GLA.[ClearingDocFiscalYear],
  GLA.[LineItemIsCompleted],
  GLA.[PersonnelNumber],
  GLA.[PartnerCompanyCode] AS [PartnerCompanyCodeID],
  GLA.[OriginProfitCenter] AS [OriginProfitCenterID],
  GLA.[OriginCostCenter] AS [OriginCostCenterID],
  GLA.[AccountAssignment] AS [AccountAssignmentID],
  GLA.[AccountAssignmentType] AS [AccountAssignmentTypeID],
  GLA.[CostCtrActivityType] AS [CostCtrActivityTypeID],
  GLA.[OrderID],
  GLA.[OrderCategory] AS [OrderCategoryID],
  GLA.[WBSElement] AS [WBSElementID],
  GLA.[ProjectInternalID],
  GLA.[Project] AS [ProjectID],
  GLA.[OperatingConcern] AS [OperatingConcernID],
  GLA.[BusinessProcess] AS [BusinessProcessID],
  GLA.[CostObject] AS [CostObjectID],
  GLA.[BillableControl] AS [BillableControlID],
  GLA.[ServiceDocumentType] AS [ServiceDocumentTypeID],
  GLA.[ServiceDocument],
  GLA.[ServiceDocumentItem],
  GLA.[BillingDocumentType] AS [BillingDocumentTypeID],
  GLA.[SalesOrganization] AS [SalesOrganizationID],
  GLA.[DistributionChannel] AS [DistributionChannelID],
  GLA.[SalesDistrict] AS [SalesDistrictID],
  GLA.[BillToParty] AS [BillToPartyID],
  GLA.[ShipToParty] AS [ShipToPartyID], 
  GLA.[KMVKBUPA] AS [SalesOfficeID],
  GLA.[SoldProduct],
  PC.ProfitCenterTypeID,
  edw.[svf_getSalesRefDocCalc] (
    GLA.[SalesDocument]
  , GLA.[ReferenceDocumentType]
  , GLA.[PurchasingDocument]
  , PA.[ICSalesDocumentID] --COLLATE DATABASE_DEFAULT
  , ARSD.[SalesReferenceDocumentCalculated]
  ) AS [SalesReferenceDocumentCalculated],
  edw.[svf_getSalesRefDocItemCalc] (
    GLA.[SalesDocument]
  , GLA.[ReferenceDocumentType]
  , GLA.[PurchasingDocument]
  , PA.[ICSalesDocumentItemID] --COLLATE DATABASE_DEFAULT
  , ARSD.[SalesReferenceDocumentItemCalculated]
  ) AS [SalesReferenceDocumentItemCalculated],
  ARSD.[SalesDocumentItemCategoryID],
  BDI.[HigherLevelItem],
  GLA.[WWPRNPA] AS ProjectNumber,
  ARSD.SDI_SalesOrganizationID,
  ARSD.SDI_SoldToPartyID,
  ARSD.SDI_MaterialID,
  GLA.[t_applicationId],
  GLA.[t_jobId],
  GLA.[t_jobDtm],
  GLA.[t_jobBy],
  GLA.[t_extractionDtm]
FROM
  [base_s4h_cax].[vw_I_GLAccountLineItemRawData_delta] AS GLA
LEFT JOIN
  PA
  ON
    PA.PurchaseOrder COLLATE DATABASE_DEFAULT = GLA.[PurchasingDocument]
    AND
    PA.PurchaseOrderItem = GLA.[PurchasingDocumentItem]
LEFT JOIN
  [edw].[vw_ProductHierarchyVariantConfigCharacteristic] AS VC
  ON
    VC.SalesDocument = CASE
      WHEN GLA.[ReferenceDocumentType] = 'VBRK' AND GLA.SalesDocument = ''
      THEN PA.ICSalesDocumentID COLLATE DATABASE_DEFAULT
      ELSE GLA.SalesDocument
    END
    AND
    VC.SalesDocumentItem = CASE
      WHEN GLA.[ReferenceDocumentType] = 'VBRK' AND GLA.SalesDocument = ''
      THEN PA.ICSalesDocumentItemID COLLATE DATABASE_DEFAULT
      ELSE GLA.SalesDocumentItem
    END 
LEFT JOIN
  edw.dim_ProfitCenter PC
  ON 
    GLA.ProfitCenter = PC.ProfitCenterID
LEFT JOIN
  [edw].[vw_ACDOCA_ReferenceSalesDocument_delta] AS ARSD
  ON
    GLA.[SourceLedger] = ARSD.[SourceLedger] 
    AND
    GLA.[CompanyCode] = ARSD.[CompanyCode]
    AND
    GLA.[FiscalYear] = ARSD.[FiscalYear]
    AND
    GLA.[AccountingDocument] = ARSD.[AccountingDocument]
    AND
    GLA.[LedgerGLLineItem] = ARSD.[LedgerGLLineItem]
LEFT JOIN
  [edw].[fact_BillingDocumentItem] BDI 
  ON
    GLA.ReferenceDocument = BDI.BillingDocument 
    AND
    GLA.ReferenceDocumentItem = BDI.BillingDocumentItem
    AND
    BDI.CurrencyTypeID = '10'

-- WHERE
--     GLAccountLineItemRawData.MANDT = 200 MPS 2021/11/01: commented out due to different client values between dev,qas, and prod

