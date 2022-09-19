﻿CREATE VIEW [edw].[vw_ACDOCA_delta]
AS
SELECT 
       [SourceLedger]                           AS [SourceLedgerID],
       [CompanyCode]                            AS [CompanyCodeID],
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
       [SalesDocument]                          AS [SalesDocumentID],          
       [SalesDocumentItem]                      AS [SalesDocumentItemID],
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
       [SalesDistrict]                          AS [SalesDistrictID],
       [BillToParty]                            AS [BillToPartyID],
       [t_applicationId],
       [t_extractionDtm],
       [t_lastActionBy],
       [t_lastActionCd],
       [t_lastActionDtm],
       [t_filePath]
FROM [base_s4h_cax].[I_GLAccountLineItemRawData_active] GLAccountLineItemRawData 
-- WHERE
--     GLAccountLineItemRawData.MANDT = 200 MPS 2021/11/01: commented out due to different client values between dev,qas, and prod