CREATE VIEW [edw].[vw_ACDOCA]
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
       GLA.[SourceLedgerID],
       GLA.[CompanyCodeID],
       edw.svf_getProductSurrogateKey(VC.[ProductSurrogateKey],GLA.[ProductID],SoldProduct) AS [ProductSurrogateKey],
       GLA.[FiscalYear],
       GLA.[AccountingDocument],
       GLA.[LedgerGLLineItem],
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
       GLA.[GLAccountID],
       GLA.[CostCenterID],
       GLA.[ProfitCenterID],
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
       [AmountInBalanceTransacCrcy],
       [TransactionCurrency],
       [AmountInTransactionCurrency],
       [CompanyCodeCurrency],
       [AmountInCompanyCodeCurrency],
       [GlobalCurrency],
       [AmountInGlobalCurrency],
       [FreeDefinedCurrency1],
       [AmountInFreeDefinedCurrency1],
       [FreeDefinedCurrency2],
       [AmountInFreeDefinedCurrency2],
       GLA.[BaseUnit],
       [Quantity],
       [DebitCreditID], 
       GLA.[FiscalPeriod], 
       GLA.[FiscalYearVariant],
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
       GLA.[CreationDate],
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
       GLA.[SalesDocumentID],          
       GLA.[SalesDocumentItemID],
       GLA.[ProductID],
       GLA.[PlantID],
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
       GLA.[OrderID],
       [OrderCategoryID],
       [WBSElementID],
       [ProjectInternalID],
       GLA.[ProjectID],
       [OperatingConcernID],
       [BusinessProcessID],
       [CostObjectID],
       [BillableControlID],
       [ServiceDocumentTypeID],
       [ServiceDocument],
       [ServiceDocumentItem],
       GLA.[BillingDocumentTypeID],
       GLA.[SalesOrganizationID],
       GLA.[DistributionChannelID],
       GLA.[SalesDistrictID],
       [BillToPartyID],
       [ShipToPartyID], 
       GLA.[SalesOfficeID],
       PA.ICSalesDocumentID,
       PA.ICSalesDocumentItemID,
       [SoldProduct],
       ProfitCenterTypeID,
       edw.[svf_getSalesRefDocCalc] (
              GLA.[SalesDocumentID]
            , GLA.[ReferenceDocumentTypeID]
            , GLA.[PurchasingDocument]
            , PA.[ICSalesDocumentID] 
            , ARSD.[SalesReferenceDocumentCalculated]
       ) AS [SalesReferenceDocumentCalculated],
       edw.[svf_getSalesRefDocItemCalc] (
              GLA.[SalesDocumentID]
            , GLA.[ReferenceDocumentTypeID]
            , GLA.[PurchasingDocument]
            , PA.[ICSalesDocumentItemID] 
            , ARSD.[SalesReferenceDocumentItemCalculated]
       ) AS [SalesReferenceDocumentItemCalculated],
       BDI.[HigherLevelItem],
       GLA.[WWPRNPA] AS ProjectNumber,
       GLA.[t_applicationId],
       GLA.[t_extractionDtm]
FROM [edw].[vw_GLAccountLineItemRawData] AS GLA
LEFT JOIN PA
    ON
        PA.PurchaseOrder  = [PurchasingDocument]
    AND
        PA.PurchaseOrderItem = [PurchasingDocumentItem]
LEFT JOIN [edw].[vw_ProductHierarchyVariantConfigCharacteristic] AS VC
    ON
        VC.SalesDocument = CASE
            WHEN [ReferenceDocumentTypeID] = 'VBRK' AND GLA.SalesDocumentID = ''
            THEN PA.ICSalesDocumentID 
            ELSE GLA.SalesDocumentID
        END
    AND
        VC.SalesDocumentItem = CASE
            WHEN [ReferenceDocumentTypeID] = 'VBRK' AND GLA.SalesDocumentID = ''
            THEN PA.ICSalesDocumentItemID 
            ELSE GLA.SalesDocumentItemID
        END 
LEFT JOIN edw.dim_ProfitCenter PC
    ON 
        GLA.ProfitCenterID=PC.ProfitCenterID
LEFT JOIN [edw].[vw_ACDOCA_ReferenceSalesDocument] AS ARSD
    ON GLA.[SourceLedgerID] = ARSD.[SourceLedgerID] 
       AND GLA.[CompanyCodeID] = ARSD.[CompanyCodeID]
       AND GLA.[FiscalYear] = ARSD.[FiscalYear]
       AND GLA.[AccountingDocument] = ARSD.[AccountingDocument]
       AND GLA.[LedgerGLLineItem] = ARSD.[LedgerGLLineItem]
LEFT JOIN [edw].[fact_BillingDocumentItem] BDI 
    ON GLA.ReferenceDocument = BDI.BillingDocument 
       AND GLA.ReferenceDocumentItem = BDI.BillingDocumentItem
       AND BDI.CurrencyTypeID = '10'

-- WHERE
--     GLAccountLineItemRawData.MANDT = 200 MPS 2021/11/01: commented out due to different client values between dev,qas, and prod

