﻿CREATE VIEW [edw].[vw_ACDOCA]
AS
SELECT 
       [SourceLedger]                           AS [SourceLedgerID],
       [CompanyCode]                            AS [CompanyCodeID],
       COALESCE(VC.[ProductSurrogateKey],GLAccountLineItemRawData.[Product]) AS [ProductSurrogateKey],
       [FiscalYear],
       [AccountingDocument],
       [LedgerGLLineItem],
       [LedgerFiscalYear],
       [GLRecordType]                           AS [GLRecordTypeID],
       [ChartOfAccounts]                        AS [ChartOfAccountsID],
       [ControllingArea]                        AS [ControllingAreaID],
       [FinancialTransactionType]               AS [FinancialTransactionTypeID],
       [BusinessTransactionType]                AS [BusinessTransactionTypeID],
       [ControllingBusTransacType]              AS [ControllingBusTransacTypeID],
       [ReferenceDocumentType]                  AS [ReferenceDocumentTypeID],
       [ReferenceDocumentContext]               AS [ReferenceDocumentContextID],
       [ReferenceDocument],
       [ReferenceDocumentItem],
       [ReferenceDocumentItemGroup]             AS [ReferenceDocumentItemGroupID],
       [IsReversal],
       [IsReversed],
       [PredecessorReferenceDocType]            AS [PredecessorReferenceDocTypeID],
       [ReversalReferenceDocumentCntxt]         AS [ReversalReferenceDocumentCntxtID],
       [ReversalReferenceDocument],
       [IsSettlement],
       [IsSettled],
       [PredecessorReferenceDocument],
       [PredecessorReferenceDocItem],
       [SourceReferenceDocumentType]            AS [SourceReferenceDocumentTypeID],
       [SourceReferenceDocument],
       [SourceReferenceDocumentItem],
       [IsCommitment],
       [JrnlEntryItemObsoleteReason]            AS [JrnlEntryItemObsoleteReasonID],
       [GLAccount]                              AS [GLAccountID],
       [CostCenter]                             AS [CostCenterID],
       [ProfitCenter]                           AS [ProfitCenterID],
       [FunctionalArea]                         AS [FunctionalAreaID],
       [BusinessArea]                           AS [BusinessAreaID],          
       [Segment]                                AS [SegmentID],
       [PartnerCostCenter]                      AS [PartnerCostCenterID],
       [PartnerProfitCenter]                    AS [PartnerProfitCenterID],
       [PartnerFunctionalArea]                  AS [PartnerFunctionalAreaID],
       [PartnerBusinessArea]                    AS [PartnerBusinessAreaID],
       [PartnerCompany]                         AS [PartnerCompanyID],
       [PartnerSegment]                         AS [PartnerSegmentID],
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
       [BaseUnit],
       [Quantity],
       [DebitCreditCode]                        AS [DebitCreditID], 
       [FiscalPeriod], 
       [FiscalYearVariant],
       [FiscalYearPeriod],
       [PostingDate],
       [DocumentDate],
       [AccountingDocumentType]                 AS [AccountingDocumentTypeID],
       [AccountingDocumentItem],
       [AssignmentReference],
       [AccountingDocumentCategory]             AS [AccountingDocumentCategoryID],
       [PostingKey]                             AS [PostingKeyID],
       [TransactionTypeDetermination]           AS [TransactionTypeDeterminationID],
       [SubLedgerAcctLineItemType]              AS [SubLedgerAcctLineItemTypeID],
       [AccountingDocCreatedByUser]             AS [AccountingDocCreatedByUserID],
       [LastChangeDateTime],
       [CreationDateTime],
       [CreationDate],
       [OriginObjectType]                       AS [OriginObjectTypeID],
       GLAccountLineItemRawData.[GLAccountType] AS [GLAccountTypeID],
       [InvoiceReference],
       [InvoiceReferenceFiscalYear],
       [InvoiceItemReference],
       [ReferencePurchaseOrderCategory]         AS [ReferencePurchaseOrderCategoryID],
       [PurchasingDocument],
       [PurchasingDocumentItem],
       [AccountAssignmentNumber],
       [DocumentItemText],
       GLAccountLineItemRawData.[SalesDocument]                          AS [SalesDocumentID],          
       GLAccountLineItemRawData.[SalesDocumentItem]                      AS [SalesDocumentItemID],
       [Product]                                AS [ProductID],
       [Plant]                                  AS [PlantID],
       [Supplier]                               AS [SupplierID],
       [Customer]                               AS [CustomerID],
       [ExchangeRateDate],                    
       [FinancialAccountType]                   AS [FinancialAccountTypeID],
       [SpecialGLCode]                          AS [SpecialGLCodeID],
       [TaxCode]                                AS [TaxCodeID],
       [ClearingDate],
       [ClearingAccountingDocument],
       [ClearingDocFiscalYear],
       [LineItemIsCompleted],
       [PersonnelNumber],
       [PartnerCompanyCode]                     AS [PartnerCompanyCodeID],
       [OriginProfitCenter]                     AS [OriginProfitCenterID],
       [OriginCostCenter]                       AS [OriginCostCenterID],
       [AccountAssignment]                      AS [AccountAssignmentID],
       [AccountAssignmentType]                  AS [AccountAssignmentTypeID],
       [CostCtrActivityType]                    AS [CostCtrActivityTypeID],
       [OrderID],
       [OrderCategory]                          AS [OrderCategoryID],
       [WBSElement]                             AS [WBSElementID],
       [ProjectInternalID],
       [Project]                                AS [ProjectID],
       [OperatingConcern]                       AS [OperatingConcernID],
       [BusinessProcess]                        AS [BusinessProcessID],
       [CostObject]                             AS [CostObjectID],
       [BillableControl]                        AS [BillableControlID],
       [ServiceDocumentType]                    AS [ServiceDocumentTypeID],
       [ServiceDocument],
       [ServiceDocumentItem],
       [BillingDocumentType]                    AS [BillingDocumentTypeID],
       [SalesOrganization]                      AS [SalesOrganizationID],
       [DistributionChannel]                    AS [DistributionChannelID],
       GLAccountLineItemRawData.[SalesDistrict] AS [SalesDistrictID],
       [BillToParty]                            AS [BillToPartyID],
       [ShipToParty]                            AS [ShipToPartyID], 
       [KMVKBUPA]                               AS [SalesOfficeID],
       PA.VBELN as ICSalesDocumentID,
       PA.VBELP as ICSalesDocumentItemID,
       GLAccountLineItemRawData.[t_applicationId],
       GLAccountLineItemRawData.[t_extractionDtm]
--FROM [base_s4h_cax].[I_GLAccountLineItemRawData] GLAccountLineItemRawData 
FROM [base_s4h_cax].[I_GLAccountLineItemRawData_upto2022] GLAccountLineItemRawData 
LEFT JOIN  [edw].[dim_PurgAccAssignment] PA
    ON [PurchasingDocument] = PA.EBELN                              COLLATE DATABASE_DEFAULT
        AND [PurchasingDocumentItem] = PA.EBELP 
LEFT JOIN [edw].[fact_ProductHierarchyVariantConfigCharacteristic_active] as VC
    ON VC.SalesDocument =
            CASE
               WHEN [ReferenceDocumentType]= 'VBRK' and  GLAccountLineItemRawData.SalesDocument =''
                   THEN  PA.VBELN                  COLLATE DATABASE_DEFAULT
                   ELSE GLAccountLineItemRawData.SalesDocument 
               END 
        and VC.SalesDocumentItem =
            CASE
               WHEN [ReferenceDocumentType]= 'VBRK' and  GLAccountLineItemRawData.SalesDocument =''
                   THEN  PA.VBELP                  COLLATE DATABASE_DEFAULT
               ELSE GLAccountLineItemRawData.SalesDocumentItem 
               END 

       UNION ALL
SELECT 
       [SourceLedger],
       [CompanyCode],
       COALESCE(VC.[ProductSurrogateKey],GLAccountLineItemRawData.[Product]) AS [ProductSurrogateKey],
       [FiscalYear],
       [AccountingDocument],
       [LedgerGLLineItem],
       [LedgerFiscalYear],
       [GLRecordType],
       [ChartOfAccounts],
       [ControllingArea],
       [FinancialTransactionType],
       [BusinessTransactionType],
       [ControllingBusTransacType],
       [ReferenceDocumentType],
       [ReferenceDocumentContext],
       [ReferenceDocument],
       [ReferenceDocumentItem],
       [ReferenceDocumentItemGroup],
       [IsReversal],
       [IsReversed],
       [PredecessorReferenceDocType],
       [ReversalReferenceDocumentCntxt],
       [ReversalReferenceDocument],
       [IsSettlement],
       [IsSettled],
       [PredecessorReferenceDocument],
       [PredecessorReferenceDocItem],
       [SourceReferenceDocumentType],
       [SourceReferenceDocument],
       [SourceReferenceDocumentItem],
       [IsCommitment],
       [JrnlEntryItemObsoleteReason],
       [GLAccount],
       [CostCenter],
       [ProfitCenter],
       [FunctionalArea],
       [BusinessArea],
       [Segment],
       [PartnerCostCenter],
       [PartnerProfitCenter],
       [PartnerFunctionalArea],
       [PartnerBusinessArea],
       [PartnerCompany],
       [PartnerSegment],
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
       [BaseUnit],
       [Quantity],
       [DebitCreditCode],
       [FiscalPeriod], 
       [FiscalYearVariant],
       [FiscalYearPeriod],
       [PostingDate],
       [DocumentDate],
       [AccountingDocumentType],
       [AccountingDocumentItem],
       [AssignmentReference],
       [AccountingDocumentCategory],
       [PostingKey],
       [TransactionTypeDetermination],
       [SubLedgerAcctLineItemType],
       [AccountingDocCreatedByUser],
       [LastChangeDateTime],
       [CreationDateTime],
       [CreationDate],
       [OriginObjectType],
       GLAccountLineItemRawData.[GLAccountType],
       [InvoiceReference],
       [InvoiceReferenceFiscalYear],
       [InvoiceItemReference],
       [ReferencePurchaseOrderCategory],
       [PurchasingDocument],
       [PurchasingDocumentItem],
       [AccountAssignmentNumber],
       [DocumentItemText],
       GLAccountLineItemRawData.[SalesDocument],                                 
       GLAccountLineItemRawData.[SalesDocumentItem],
       [Product],
       [Plant],
       [Supplier],
       [Customer],
       [ExchangeRateDate],                    
       [FinancialAccountType],
       [SpecialGLCode],
       [TaxCode],
       [ClearingDate],
       [ClearingAccountingDocument],
       [ClearingDocFiscalYear],
       [LineItemIsCompleted],
       [PersonnelNumber],
       [PartnerCompanyCode],
       [OriginProfitCenter],
       [OriginCostCenter],
       [AccountAssignment],
       [AccountAssignmentType],
       [CostCtrActivityType],
       [OrderID],
       [OrderCategory],
       [WBSElement],
       [ProjectInternalID],
       [Project],
       [OperatingConcern],
       [BusinessProcess],
       [CostObject],
       [BillableControl],
       [ServiceDocumentType],
       [ServiceDocument],
       [ServiceDocumentItem],
       [BillingDocumentType],
       [SalesOrganization],
       [DistributionChannel],
       GLAccountLineItemRawData.[SalesDistrict],
       [BillToParty],
       [ShipToParty],
       [KMVKBUPA],
       PA.VBELN as ICSalesDocumentID,
       PA.VBELP as ICSalesDocumentItemID,
       GLAccountLineItemRawData.[t_applicationId],
       GLAccountLineItemRawData.[t_extractionDtm]
FROM [base_s4h_cax].[I_GLAccountLineItemRawData_202301] GLAccountLineItemRawData
LEFT JOIN  [edw].[dim_PurgAccAssignment] PA
    ON [PurchasingDocument] = PA.EBELN                              COLLATE DATABASE_DEFAULT
        AND [PurchasingDocumentItem] = PA.EBELP 
LEFT JOIN [edw].[fact_ProductHierarchyVariantConfigCharacteristic_active] as VC
    ON VC.SalesDocument =
            CASE
               WHEN [ReferenceDocumentType]= 'VBRK' and  GLAccountLineItemRawData.SalesDocument =''
                   THEN  PA.VBELN                  COLLATE DATABASE_DEFAULT
                   ELSE GLAccountLineItemRawData.SalesDocument 
               END 
        and VC.SalesDocumentItem =
            CASE
               WHEN [ReferenceDocumentType]= 'VBRK' and  GLAccountLineItemRawData.SalesDocument =''
                   THEN  PA.VBELP                  COLLATE DATABASE_DEFAULT
               ELSE GLAccountLineItemRawData.SalesDocumentItem 
               END 
       UNION ALL
SELECT 
       [SourceLedger],
       [CompanyCode],
       COALESCE(VC.[ProductSurrogateKey],GLAccountLineItemRawData.[Product]) AS [ProductSurrogateKey],
       [FiscalYear],
       [AccountingDocument],
       [LedgerGLLineItem],
       [LedgerFiscalYear],
       [GLRecordType],
       [ChartOfAccounts],
       [ControllingArea],
       [FinancialTransactionType],
       [BusinessTransactionType],
       [ControllingBusTransacType],
       [ReferenceDocumentType],
       [ReferenceDocumentContext],
       [ReferenceDocument],
       [ReferenceDocumentItem],
       [ReferenceDocumentItemGroup],
       [IsReversal],
       [IsReversed],
       [PredecessorReferenceDocType],
       [ReversalReferenceDocumentCntxt],
       [ReversalReferenceDocument],
       [IsSettlement],
       [IsSettled],
       [PredecessorReferenceDocument],
       [PredecessorReferenceDocItem],
       [SourceReferenceDocumentType],
       [SourceReferenceDocument],
       [SourceReferenceDocumentItem],
       [IsCommitment],
       [JrnlEntryItemObsoleteReason],
       [GLAccount],
       [CostCenter],
       [ProfitCenter],
       [FunctionalArea],
       [BusinessArea],
       [Segment],
       [PartnerCostCenter],
       [PartnerProfitCenter],
       [PartnerFunctionalArea],
       [PartnerBusinessArea],
       [PartnerCompany],
       [PartnerSegment],
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
       [BaseUnit],
       [Quantity],
       [DebitCreditCode],
       [FiscalPeriod], 
       [FiscalYearVariant],
       [FiscalYearPeriod],
       [PostingDate],
       [DocumentDate],
       [AccountingDocumentType],
       [AccountingDocumentItem],
       [AssignmentReference],
       [AccountingDocumentCategory],
       [PostingKey],
       [TransactionTypeDetermination],
       [SubLedgerAcctLineItemType],
       [AccountingDocCreatedByUser],
       [LastChangeDateTime],
       [CreationDateTime],
       [CreationDate],
       [OriginObjectType],
       GLAccountLineItemRawData.[GLAccountType],
       [InvoiceReference],
       [InvoiceReferenceFiscalYear],
       [InvoiceItemReference],
       [ReferencePurchaseOrderCategory],
       [PurchasingDocument],
       [PurchasingDocumentItem],
       [AccountAssignmentNumber],
       [DocumentItemText],
       GLAccountLineItemRawData.[SalesDocument],                                 
       GLAccountLineItemRawData.[SalesDocumentItem],
       [Product],
       [Plant],
       [Supplier],
       [Customer],
       [ExchangeRateDate],                    
       [FinancialAccountType],
       [SpecialGLCode],
       [TaxCode],
       [ClearingDate],
       [ClearingAccountingDocument],
       [ClearingDocFiscalYear],
       [LineItemIsCompleted],
       [PersonnelNumber],
       [PartnerCompanyCode],
       [OriginProfitCenter],
       [OriginCostCenter],
       [AccountAssignment],
       [AccountAssignmentType],
       [CostCtrActivityType],
       [OrderID],
       [OrderCategory],
       [WBSElement],
       [ProjectInternalID],
       [Project],
       [OperatingConcern],
       [BusinessProcess],
       [CostObject],
       [BillableControl],
       [ServiceDocumentType],
       [ServiceDocument],
       [ServiceDocumentItem],
       [BillingDocumentType],
       [SalesOrganization],
       [DistributionChannel],
       GLAccountLineItemRawData.[SalesDistrict],
       [BillToParty],
       [ShipToParty],
       [KMVKBUPA],
       GLAccountLineItemRawData.[t_applicationId],
       GLAccountLineItemRawData.[t_extractionDtm]
FROM [base_s4h_cax].[I_GLAccountLineItemRawData_202302] GLAccountLineItemRawData
LEFT JOIN  [edw].[dim_PurgAccAssignment] PA
    ON [PurchasingDocument] = PA.EBELN                              COLLATE DATABASE_DEFAULT
        AND [PurchasingDocumentItem] = PA.EBELP 
LEFT JOIN [edw].[fact_ProductHierarchyVariantConfigCharacteristic_active] as VC
    ON VC.SalesDocument =
            CASE
               WHEN [ReferenceDocumentType]= 'VBRK' and  GLAccountLineItemRawData.SalesDocument =''
                   THEN  PA.VBELN                  COLLATE DATABASE_DEFAULT
                   ELSE GLAccountLineItemRawData.SalesDocument 
               END 
        and VC.SalesDocumentItem =
            CASE
               WHEN [ReferenceDocumentType]= 'VBRK' and  GLAccountLineItemRawData.SalesDocument =''
                   THEN  PA.VBELP                  COLLATE DATABASE_DEFAULT
               ELSE GLAccountLineItemRawData.SalesDocumentItem 
               END 
       UNION ALL
SELECT 
       [SourceLedger],
       [CompanyCode],
       COALESCE(VC.[ProductSurrogateKey],GLAccountLineItemRawData.[Product]) AS [ProductSurrogateKey],
       [FiscalYear],
       [AccountingDocument],
       [LedgerGLLineItem],
       [LedgerFiscalYear],
       [GLRecordType],
       [ChartOfAccounts],
       [ControllingArea],
       [FinancialTransactionType],
       [BusinessTransactionType],
       [ControllingBusTransacType],
       [ReferenceDocumentType],
       [ReferenceDocumentContext],
       [ReferenceDocument],
       [ReferenceDocumentItem],
       [ReferenceDocumentItemGroup],
       [IsReversal],
       [IsReversed],
       [PredecessorReferenceDocType],
       [ReversalReferenceDocumentCntxt],
       [ReversalReferenceDocument],
       [IsSettlement],
       [IsSettled],
       [PredecessorReferenceDocument],
       [PredecessorReferenceDocItem],
       [SourceReferenceDocumentType],
       [SourceReferenceDocument],
       [SourceReferenceDocumentItem],
       [IsCommitment],
       [JrnlEntryItemObsoleteReason],
       [GLAccount],
       [CostCenter],
       [ProfitCenter],
       [FunctionalArea],
       [BusinessArea],
       [Segment],
       [PartnerCostCenter],
       [PartnerProfitCenter],
       [PartnerFunctionalArea],
       [PartnerBusinessArea],
       [PartnerCompany],
       [PartnerSegment],
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
       [BaseUnit],
       [Quantity],
       [DebitCreditCode],
       [FiscalPeriod], 
       [FiscalYearVariant],
       [FiscalYearPeriod],
       [PostingDate],
       [DocumentDate],
       [AccountingDocumentType],
       [AccountingDocumentItem],
       [AssignmentReference],
       [AccountingDocumentCategory],
       [PostingKey],
       [TransactionTypeDetermination],
       [SubLedgerAcctLineItemType],
       [AccountingDocCreatedByUser],
       [LastChangeDateTime],
       [CreationDateTime],
       [CreationDate],
       [OriginObjectType],
       GLAccountLineItemRawData.[GLAccountType],
       [InvoiceReference],
       [InvoiceReferenceFiscalYear],
       [InvoiceItemReference],
       [ReferencePurchaseOrderCategory],
       [PurchasingDocument],
       [PurchasingDocumentItem],
       [AccountAssignmentNumber],
       [DocumentItemText],
       GLAccountLineItemRawData.[SalesDocument],                              
       GLAccountLineItemRawData.[SalesDocumentItem],
       [Product],
       [Plant],
       [Supplier],
       [Customer],
       [ExchangeRateDate],                    
       [FinancialAccountType],
       [SpecialGLCode],
       [TaxCode],
       [ClearingDate],
       [ClearingAccountingDocument],
       [ClearingDocFiscalYear],
       [LineItemIsCompleted],
       [PersonnelNumber],
       [PartnerCompanyCode],
       [OriginProfitCenter],
       [OriginCostCenter],
       [AccountAssignment],
       [AccountAssignmentType],
       [CostCtrActivityType],
       [OrderID],
       [OrderCategory],
       [WBSElement],
       [ProjectInternalID],
       [Project],
       [OperatingConcern],
       [BusinessProcess],
       [CostObject],
       [BillableControl],
       [ServiceDocumentType],
       [ServiceDocument],
       [ServiceDocumentItem],
       [BillingDocumentType],
       [SalesOrganization],
       [DistributionChannel],
       GLAccountLineItemRawData.[SalesDistrict],
       [BillToParty],
       [ShipToParty],
       [KMVKBUPA],
       PA.VBELN as ICSalesDocumentID,
       PA.VBELP as ICSalesDocumentItemID,
       GLAccountLineItemRawData.[t_applicationId],
       GLAccountLineItemRawData.[t_extractionDtm]
FROM [base_s4h_cax].[I_GLAccountLineItemRawData_202303] GLAccountLineItemRawData
LEFT JOIN  [edw].[dim_PurgAccAssignment] PA
    ON [PurchasingDocument] = PA.EBELN                              COLLATE DATABASE_DEFAULT
        AND [PurchasingDocumentItem] = PA.EBELP 
LEFT JOIN [edw].[fact_ProductHierarchyVariantConfigCharacteristic_active] as VC
    ON VC.SalesDocument =
            CASE
               WHEN [ReferenceDocumentType]= 'VBRK' and  GLAccountLineItemRawData.SalesDocument =''
                   THEN  PA.VBELN                  COLLATE DATABASE_DEFAULT
                   ELSE GLAccountLineItemRawData.SalesDocument 
               END 
        and VC.SalesDocumentItem =
            CASE
               WHEN [ReferenceDocumentType]= 'VBRK' and  GLAccountLineItemRawData.SalesDocument =''
                   THEN  PA.VBELP                  COLLATE DATABASE_DEFAULT
               ELSE GLAccountLineItemRawData.SalesDocumentItem 
               END 
       UNION ALL
SELECT 
       [SourceLedger],
       [CompanyCode],
       COALESCE(VC.[ProductSurrogateKey],GLAccountLineItemRawData.[Product]) AS [ProductSurrogateKey],
       [FiscalYear],
       [AccountingDocument],
       [LedgerGLLineItem],
       [LedgerFiscalYear],
       [GLRecordType],
       [ChartOfAccounts],
       [ControllingArea],
       [FinancialTransactionType],
       [BusinessTransactionType],
       [ControllingBusTransacType],
       [ReferenceDocumentType],
       [ReferenceDocumentContext],
       [ReferenceDocument],
       [ReferenceDocumentItem],
       [ReferenceDocumentItemGroup],
       [IsReversal],
       [IsReversed],
       [PredecessorReferenceDocType],
       [ReversalReferenceDocumentCntxt],
       [ReversalReferenceDocument],
       [IsSettlement],
       [IsSettled],
       [PredecessorReferenceDocument],
       [PredecessorReferenceDocItem],
       [SourceReferenceDocumentType],
       [SourceReferenceDocument],
       [SourceReferenceDocumentItem],
       [IsCommitment],
       [JrnlEntryItemObsoleteReason],
       [GLAccount],
       [CostCenter],
       [ProfitCenter],
       [FunctionalArea],
       [BusinessArea],
       [Segment],
       [PartnerCostCenter],
       [PartnerProfitCenter],
       [PartnerFunctionalArea],
       [PartnerBusinessArea],
       [PartnerCompany],
       [PartnerSegment],
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
       [BaseUnit],
       [Quantity],
       [DebitCreditCode],
       [FiscalPeriod], 
       [FiscalYearVariant],
       [FiscalYearPeriod],
       [PostingDate],
       [DocumentDate],
       [AccountingDocumentType],
       [AccountingDocumentItem],
       [AssignmentReference],
       [AccountingDocumentCategory],
       [PostingKey],
       [TransactionTypeDetermination],
       [SubLedgerAcctLineItemType],
       [AccountingDocCreatedByUser],
       [LastChangeDateTime],
       [CreationDateTime],
       [CreationDate],
       [OriginObjectType],
       GLAccountLineItemRawData.[GLAccountType],
       [InvoiceReference],
       [InvoiceReferenceFiscalYear],
       [InvoiceItemReference],
       [ReferencePurchaseOrderCategory],
       [PurchasingDocument],
       [PurchasingDocumentItem],
       [AccountAssignmentNumber],
       [DocumentItemText],
       GLAccountLineItemRawData.[SalesDocument],                                 
       GLAccountLineItemRawData.[SalesDocumentItem], 
       [Product],
       [Plant],
       [Supplier],
       [Customer],
       [ExchangeRateDate],                    
       [FinancialAccountType],
       [SpecialGLCode],
       [TaxCode],
       [ClearingDate],
       [ClearingAccountingDocument],
       [ClearingDocFiscalYear],
       [LineItemIsCompleted],
       [PersonnelNumber],
       [PartnerCompanyCode],
       [OriginProfitCenter],
       [OriginCostCenter],
       [AccountAssignment],
       [AccountAssignmentType],
       [CostCtrActivityType],
       [OrderID],
       [OrderCategory],
       [WBSElement],
       [ProjectInternalID],
       [Project],
       [OperatingConcern],
       [BusinessProcess],
       [CostObject],
       [BillableControl],
       [ServiceDocumentType],
       [ServiceDocument],
       [ServiceDocumentItem],
       [BillingDocumentType],
       [SalesOrganization],
       [DistributionChannel],
       GLAccountLineItemRawData.[SalesDistrict],
       [BillToParty],
       [ShipToParty],
       [KMVKBUPA],
       GLAccountLineItemRawData.[t_applicationId],
       GLAccountLineItemRawData.[t_extractionDtm]
FROM [base_s4h_cax].[I_GLAccountLineItemRawData_202304] GLAccountLineItemRawData
LEFT JOIN  [edw].[dim_PurgAccAssignment] PA
    ON [PurchasingDocument] = PA.EBELN                              COLLATE DATABASE_DEFAULT
        AND [PurchasingDocumentItem] = PA.EBELP 
LEFT JOIN [edw].[fact_ProductHierarchyVariantConfigCharacteristic_active] as VC
    ON VC.SalesDocument =
            CASE
               WHEN [ReferenceDocumentType]= 'VBRK' and  GLAccountLineItemRawData.SalesDocument =''
                   THEN  PA.VBELN                  COLLATE DATABASE_DEFAULT
                   ELSE GLAccountLineItemRawData.SalesDocument 
               END 
        and VC.SalesDocumentItem =
            CASE
               WHEN [ReferenceDocumentType]= 'VBRK' and  GLAccountLineItemRawData.SalesDocument =''
                   THEN  PA.VBELP                  COLLATE DATABASE_DEFAULT
               ELSE GLAccountLineItemRawData.SalesDocumentItem 
               END 
       UNION ALL
SELECT 
       [SourceLedger],
       [CompanyCode],
       COALESCE(VC.[ProductSurrogateKey],GLAccountLineItemRawData.[Product]) AS [ProductSurrogateKey],
       [FiscalYear],
       [AccountingDocument],
       [LedgerGLLineItem],
       [LedgerFiscalYear],
       [GLRecordType],
       [ChartOfAccounts],
       [ControllingArea],
       [FinancialTransactionType],
       [BusinessTransactionType],
       [ControllingBusTransacType],
       [ReferenceDocumentType],
       [ReferenceDocumentContext],
       [ReferenceDocument],
       [ReferenceDocumentItem],
       [ReferenceDocumentItemGroup],
       [IsReversal],
       [IsReversed],
       [PredecessorReferenceDocType],
       [ReversalReferenceDocumentCntxt],
       [ReversalReferenceDocument],
       [IsSettlement],
       [IsSettled],
       [PredecessorReferenceDocument],
       [PredecessorReferenceDocItem],
       [SourceReferenceDocumentType],
       [SourceReferenceDocument],
       [SourceReferenceDocumentItem],
       [IsCommitment],
       [JrnlEntryItemObsoleteReason],
       [GLAccount],
       [CostCenter],
       [ProfitCenter],
       [FunctionalArea],
       [BusinessArea],
       [Segment],
       [PartnerCostCenter],
       [PartnerProfitCenter],
       [PartnerFunctionalArea],
       [PartnerBusinessArea],
       [PartnerCompany],
       [PartnerSegment],
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
       [BaseUnit],
       [Quantity],
       [DebitCreditCode],
       [FiscalPeriod], 
       [FiscalYearVariant],
       [FiscalYearPeriod],
       [PostingDate],
       [DocumentDate],
       [AccountingDocumentType],
       [AccountingDocumentItem],
       [AssignmentReference],
       [AccountingDocumentCategory],
       [PostingKey],
       [TransactionTypeDetermination],
       [SubLedgerAcctLineItemType],
       [AccountingDocCreatedByUser],
       [LastChangeDateTime],
       [CreationDateTime],
       [CreationDate],
       [OriginObjectType],
       GLAccountLineItemRawData.[GLAccountType],
       [InvoiceReference],
       [InvoiceReferenceFiscalYear],
       [InvoiceItemReference],
       [ReferencePurchaseOrderCategory],
       [PurchasingDocument],
       [PurchasingDocumentItem],
       [AccountAssignmentNumber],
       [DocumentItemText],
       GLAccountLineItemRawData.[SalesDocument],        
       GLAccountLineItemRawData.[SalesDocumentItem],
       [Product],
       [Plant],
       [Supplier],
       [Customer],
       [ExchangeRateDate],                    
       [FinancialAccountType],
       [SpecialGLCode],
       [TaxCode],
       [ClearingDate],
       [ClearingAccountingDocument],
       [ClearingDocFiscalYear],
       [LineItemIsCompleted],
       [PersonnelNumber],
       [PartnerCompanyCode],
       [OriginProfitCenter],
       [OriginCostCenter],
       [AccountAssignment],
       [AccountAssignmentType],
       [CostCtrActivityType],
       [OrderID],
       [OrderCategory],
       [WBSElement],
       [ProjectInternalID],
       [Project],
       [OperatingConcern],
       [BusinessProcess],
       [CostObject],
       [BillableControl],
       [ServiceDocumentType],
       [ServiceDocument],
       [ServiceDocumentItem],
       [BillingDocumentType],
       [SalesOrganization],
       [DistributionChannel],
       GLAccountLineItemRawData.[SalesDistrict],
       [BillToParty],
       [ShipToParty],
       [KMVKBUPA],
       PA.VBELN as ICSalesDocumentID,
       PA.VBELP as ICSalesDocumentItemID,
       GLAccountLineItemRawData.[t_applicationId],
       GLAccountLineItemRawData.[t_extractionDtm]
FROM [base_s4h_cax].[I_GLAccountLineItemRawData_202305] GLAccountLineItemRawData 
LEFT JOIN  [edw].[dim_PurgAccAssignment] PA
    ON [PurchasingDocument] = PA.EBELN                              COLLATE DATABASE_DEFAULT
        AND [PurchasingDocumentItem] = PA.EBELP 
LEFT JOIN [edw].[fact_ProductHierarchyVariantConfigCharacteristic_active] as VC
    ON VC.SalesDocument =
            CASE
               WHEN [ReferenceDocumentType]= 'VBRK' and  GLAccountLineItemRawData.SalesDocument =''
                   THEN  PA.VBELN                  COLLATE DATABASE_DEFAULT
                   ELSE GLAccountLineItemRawData.SalesDocument 
               END 
        and VC.SalesDocumentItem =
            CASE
               WHEN [ReferenceDocumentType]= 'VBRK' and  GLAccountLineItemRawData.SalesDocument =''
                   THEN  PA.VBELP                  COLLATE DATABASE_DEFAULT
               ELSE GLAccountLineItemRawData.SalesDocumentItem 
               END 
-- WHERE
--     GLAccountLineItemRawData.MANDT = 200 MPS 2021/11/01: commented out due to different client values between dev,qas, and prod