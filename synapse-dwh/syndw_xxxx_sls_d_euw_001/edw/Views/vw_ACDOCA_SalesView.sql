CREATE VIEW [edw].[vw_ACDOCA_SalesView]
AS
SELECT 
    GLALIRD.[SourceLedger]                           AS [SourceLedgerID],
    GLALIRD.[CompanyCode]                            AS [CompanyCodeID],
    GLALIRD.[FiscalYear],
    GLALIRD.[AccountingDocument],
    GLALIRD.[LedgerGLLineItem],
    GLALIRD.[LedgerFiscalYear],
    GLALIRD.[GLRecordType]                           AS [GLRecordTypeID],
    GLALIRD.[ChartOfAccounts]                        AS [ChartOfAccountsID],
    GLALIRD.[ControllingArea]                        AS [ControllingAreaID],
    GLALIRD.[FinancialTransactionType]               AS [FinancialTransactionTypeID],
    GLALIRD.[BusinessTransactionType]                AS [BusinessTransactionTypeID],
    GLALIRD.[ControllingBusTransacType]              AS [ControllingBusTransacTypeID],
    GLALIRD.[ReferenceDocumentType]                  AS [ReferenceDocumentTypeID],
    GLALIRD.[ReferenceDocumentContext]               AS [ReferenceDocumentContextID],
    GLALIRD.[ReferenceDocument],
    GLALIRD.[ReferenceDocumentItem],
    GLALIRD.[ReferenceDocumentItemGroup]             AS [ReferenceDocumentItemGroupID],
    GLALIRD.[IsReversal],
    GLALIRD.[IsReversed],
    GLALIRD.[PredecessorReferenceDocType]            AS [PredecessorReferenceDocTypeID],
    GLALIRD.[ReversalReferenceDocumentCntxt]         AS [ReversalReferenceDocumentCntxtID],
    GLALIRD.[ReversalReferenceDocument],
    GLALIRD.[IsSettlement],
    GLALIRD.[IsSettled],
    GLALIRD.[PredecessorReferenceDocument],
    GLALIRD.[PredecessorReferenceDocItem],
    GLALIRD.[SourceReferenceDocumentType]            AS [SourceReferenceDocumentTypeID],
    GLALIRD.[SourceReferenceDocument],
    GLALIRD.[SourceReferenceDocumentItem],
    GLALIRD.[IsCommitment],
    GLALIRD.[JrnlEntryItemObsoleteReason]            AS [JrnlEntryItemObsoleteReasonID],
    GLALIRD.[GLAccount]                              AS [GLAccountID],
    GLALIRD.[CostCenter]                             AS [CostCenterID],
    GLALIRD.[ProfitCenter]                           AS [ProfitCenterID],
    GLALIRD.[FunctionalArea]                         AS [FunctionalAreaID],
    GLALIRD.[BusinessArea]                           AS [BusinessAreaID],          
    GLALIRD.[Segment]                                AS [SegmentID],
    GLALIRD.[PartnerCostCenter]                      AS [PartnerCostCenterID],
    GLALIRD.[PartnerProfitCenter]                    AS [PartnerProfitCenterID],
    GLALIRD.[PartnerFunctionalArea]                  AS [PartnerFunctionalAreaID],
    GLALIRD.[PartnerBusinessArea]                    AS [PartnerBusinessAreaID],
    GLALIRD.[PartnerCompany]                         AS [PartnerCompanyID],
    GLALIRD.[PartnerSegment]                         AS [PartnerSegmentID],
    GLALIRD.[BalanceTransactionCurrency],
    GLALIRD.[AmountInBalanceTransacCrcy],
    GLALIRD.[TransactionCurrency],
    GLALIRD.[AmountInTransactionCurrency],
    GLALIRD.[CompanyCodeCurrency],
    GLALIRD.[AmountInCompanyCodeCurrency],
    GLALIRD.[GlobalCurrency],
    GLALIRD.[AmountInGlobalCurrency],
    GLALIRD.[FreeDefinedCurrency1],
    GLALIRD.[AmountInFreeDefinedCurrency1],
    GLALIRD.[FreeDefinedCurrency2],
    GLALIRD.[AmountInFreeDefinedCurrency2],
    GLALIRD.[BaseUnit],
    GLALIRD.[Quantity],
    GLALIRD.[DebitCreditCode]                        AS [DebitCreditID], 
    GLALIRD.[FiscalPeriod], 
    GLALIRD.[FiscalYearVariant],
    GLALIRD.[FiscalYearPeriod],
    GLALIRD.[PostingDate],
    GLALIRD.[DocumentDate],
    GLALIRD.[AccountingDocumentType]                 AS [AccountingDocumentTypeID],
    GLALIRD.[AccountingDocumentItem],
    GLALIRD.[AssignmentReference],
    GLALIRD.[AccountingDocumentCategory]             AS [AccountingDocumentCategoryID],
    GLALIRD.[PostingKey]                             AS [PostingKeyID],
    GLALIRD.[TransactionTypeDetermination]           AS [TransactionTypeDeterminationID],
    GLALIRD.[SubLedgerAcctLineItemType]              AS [SubLedgerAcctLineItemTypeID],
    GLALIRD.[AccountingDocCreatedByUser]             AS [AccountingDocCreatedByUserID],
    GLALIRD.[LastChangeDateTime],
    GLALIRD.[CreationDateTime],
    GLALIRD.[CreationDate],
    GLALIRD.[OriginObjectType]                       AS [OriginObjectTypeID],
    GLALIRD.[GLAccountType] AS [GLAccountTypeID],
    GLALIRD.[InvoiceReference],
    GLALIRD.[InvoiceReferenceFiscalYear],
    GLALIRD.[InvoiceItemReference],
    GLALIRD.[ReferencePurchaseOrderCategory]         AS [ReferencePurchaseOrderCategoryID],
    GLALIRD.[PurchasingDocument],
    GLALIRD.[PurchasingDocumentItem],
    GLALIRD.[AccountAssignmentNumber],
    GLALIRD.[DocumentItemText],
    GLALIRD.[SalesDocument]                          AS [SalesDocumentID],          
    GLALIRD.[SalesDocumentItem]                      AS [SalesDocumentItemID],
    GLALIRD.[Product]                                AS [ProductID],
    GLALIRD.[Plant]                                  AS [PlantID],
    GLALIRD.[Supplier]                               AS [SupplierID],
    GLALIRD.[Customer]                               AS [CustomerID],
    GLALIRD.[ExchangeRateDate],                    
    GLALIRD.[FinancialAccountType]                   AS [FinancialAccountTypeID],
    GLALIRD.[SpecialGLCode]                          AS [SpecialGLCodeID],
    GLALIRD.[TaxCode]                                AS [TaxCodeID],
    GLALIRD.[ClearingDate],
    GLALIRD.[ClearingAccountingDocument],
    GLALIRD.[ClearingDocFiscalYear],
    GLALIRD.[LineItemIsCompleted],
    GLALIRD.[PersonnelNumber],
    GLALIRD.[PartnerCompanyCode]                     AS [PartnerCompanyCodeID],
    GLALIRD.[OriginProfitCenter]                     AS [OriginProfitCenterID],
    GLALIRD.[OriginCostCenter]                       AS [OriginCostCenterID],
    GLALIRD.[AccountAssignment]                      AS [AccountAssignmentID],
    GLALIRD.[AccountAssignmentType]                  AS [AccountAssignmentTypeID],
    GLALIRD.[CostCtrActivityType]                    AS [CostCtrActivityTypeID],
    GLALIRD.[OrderID],
    GLALIRD.[OrderCategory]                          AS [OrderCategoryID],
    GLALIRD.[WBSElement]                             AS [WBSElementID],
    GLALIRD.[ProjectInternalID],
    GLALIRD.[Project]                                AS [ProjectID],
    GLALIRD.[OperatingConcern]                       AS [OperatingConcernID],
    GLALIRD.[BusinessProcess]                        AS [BusinessProcessID],
    GLALIRD.[CostObject]                             AS [CostObjectID],
    GLALIRD.[BillableControl]                        AS [BillableControlID],
    
    GLALIRD.[ServiceDocumentType]                    AS [ServiceDocumentTypeID],
    GLALIRD.[ServiceDocument],
    GLALIRD.[ServiceDocumentItem],
    CASE
        WHEN GLALIRD.[BillingDocumentType] = ''
            THEN 'MA-Dummy'
        ELSE GLALIRD.[BillingDocumentType]
    END                                                 AS [BillingDocumentTypeID],
    CASE
        WHEN GLALIRD.[BillingDocumentType] = ''
            AND COALESCE (GLALIRD.[SalesOrganization], '') = ''
            THEN 'MA-Dummy'
        ELSE GLALIRD.[SalesOrganization]
    END                                                 AS [SalesOrganizationID],
    GLALIRD.[DistributionChannel]                    AS [DistributionChannelID],
    CASE
        WHEN GLALIRD.[BillingDocumentType] = ''
        AND COALESCE (GLALIRD.[SalesDistrict], '') = ''
            THEN 'MA-Dummy'
        ELSE GLALIRD.[SalesDistrict]
    END                                                 AS [SalesDistrictID],
    GLALIRD.[BillToParty]                            AS [BillToPartyID],
    GLALIRD.[ShipToParty],
    CASE 
        WHEN GLALIRD.[BillingDocumentType] = '' THEN    1
        ELSE                                            0
    END                                             AS [ManualAdjustment],
    CASE
        WHEN GLALIRD.[GLAccount] = '0049000109' THEN    1
        ELSE                                            0
    END                                             AS [TPAdjustment],
    CASE
        WHEN GLALIRD.[BillingDocumentType] = ''
        AND COALESCE (PSD.FirstSalesSpecProductGroup, '') = ''
            THEN 'MA-Dummy'
        ELSE PSD.FirstSalesSpecProductGroup
    END                                                 AS [Brand],
    CASE 
        WHEN GLALIRD.[BillingDocumentType] = '' THEN    'MA'
        WHEN LEFT(GLALIRD.[Customer],2) IN ('IC','IP')  THEN 'I'
        ELSE                                            'O'
    END                                             AS [InOutID],
    CSA.[CustomerGroup],
    GLALIRD.[t_applicationId],
    GLALIRD.[t_extractionDtm]
FROM [base_s4h_cax].[I_GLAccountLineItemRawData] GLALIRD
INNER JOIN [edw].[dim_FinancialStatementHierarchy] FSH
    ON GLALIRD.[GLAccount] = FSH.LowerBoundaryAccount               COLLATE DATABASE_DEFAULT
INNER JOIN [edw].[dim_FinancialStatementItem]   FSI
    ON FSH.[FinancialStatementItem] = FSI.[FinancialStatementItem]  COLLATE DATABASE_DEFAULT
LEFT JOIN [edw].[dim_BillingDocumentType] dimBDT 
    ON GLALIRD.BillingDocumentType = dimBDT.[BillingDocumentTypeID] COLLATE DATABASE_DEFAULT
LEFT JOIN [base_s4h_cax].[I_ProductSalesDelivery] PSD
    ON GLALIRD.[Product] = PSD.[Product]                            COLLATE DATABASE_DEFAULT
        AND GLALIRD.[SalesOrganization] = PSD.[ProductSalesOrg]     COLLATE DATABASE_DEFAULT
LEFT JOIN [base_s4h_cax].[I_CustomerSalesArea] CSA
    ON GLALIRD.[Customer] = CSA.[Customer]                          COLLATE DATABASE_DEFAULT
        AND GLALIRD.[SalesOrganization] = CSA.[SalesOrganization]   COLLATE DATABASE_DEFAULT
WHERE 
    --FSI.[ParentNode] = '000570'               -- works only with PROD
    FSI.[ParentNode] = '001005'                 -- for DEV