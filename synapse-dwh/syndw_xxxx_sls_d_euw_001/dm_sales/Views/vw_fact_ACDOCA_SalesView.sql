
CREATE VIEW [dm_sales].[vw_fact_ACDOCA_SalesView]
    AS

SELECT
[SourceLedgerID]
[CompanyCodeID],
[FiscalYear],
[AccountingDocument],
[LedgerGLLineItem],
[LedgerFiscalYear],
[GLRecordTypeID],
[ChartOfAccountsID],
[ControllingAreaID],
[FinancialTransactionTypeID],
--TODO https://dev.azure.com/leviatazure/Leviat_Data_and_Analytics_DevOps/_workitems/edit/1615
--fITTT.[FinancialInstrTransTypeName],
[BaseUnit][BusinessTransactionTypeID],
bTTT.[BusinessTransactionType] as [BusinessTransactionTypeName],
acdoca.[ReferenceDocumentTypeID],
rDTT.[ReferenceDocumentTypeName],
[ReferenceDocumentItem],
[IsReversal],
[IsReversed],
[ReversalReferenceDocument],
[IsSettlement],
[IsSettled],
acdoca.[PredecessorReferenceDocTypeID],
prsDTT.[ReferenceDocumentTypeName] AS [PredecessorReferenceDocTypeName],
[PredecessorReferenceDocument],
[PredecessorReferenceDocItem],
acdoca.[SourceReferenceDocumentTypeID],
rsDTT.[ReferenceDocumentTypeName]   AS [SourceReferenceDocumentTypeName],
[SourceReferenceDocument],
[SourceReferenceDocumentItem],
[IsCommitment],
[JrnlEntryItemObsoleteReasonID],
[GLAccountID],
[CostCenterID],
[ProfitCenterID],
[FunctionalAreaID],
fAT.[FunctionalAreaName],
[TransactionCurrency],
[AmountInTransactionCurrency],
[CompanyCodeCurrency],
[AmountInCompanyCodeCurrency],
[GlobalCurrency],
[AmountInGlobalCurrency],
[DebitCreditCodeID],
dCCT.[DebitCreditCodeName],
[DocumentDate],
[AccountingDocumentTypeID],
accDT.[AccountingDocumentTypeName],
[AccountingDocumentItem],
[AccountingDocumentCategoryID],
accDCT.[AccountingDocumentCategoryName],
[PostingKeyID],
pKT.[PostingKeyName],
[LastChangeDateTime],
[CreationDateTime],
[CreationDate],
acdoca.[GLAccountTypeID],
glaTT.[GLAccountTypeName],
[PurchasingDocument],
[PurchasingDocumentItem],
[DocumentItemText],
[SalesDocumentID],
[SalesDocumentItemID],
[ProductID],
[PlantID],
[OrderID],
[PostingDate],
[CustomerID],
[ExchangeRateDate],
[TaxCodeID],
[ClearingDate],
[ClearingAccountingDocument],
[ClearingDocFiscalYear],
[LineItemIsCompleted],
[SalesOrganizationID],
[DistributionChannelID],
[SalesDistrictID],
sDT.[SalesDistrictName],
acdoca.[t_applicationId],
acdoca.[t_extractionDtm]
FROM 
   [edw].[fact_ACDOCA] acdoca
LEFT JOIN  
    [base_s4h_cax].[I_AccountingDocumentCategoryT] accDCT
    ON 
        acdoca.[AccountingDocumentCategoryID] = accDCT.[AccountingDocumentCategory]
        AND 
        accDCT.[Language] = 'E'
LEFT JOIN  
    [base_s4h_cax].[I_AccountingDocumentTypeText] accDT
    ON 
        acdoca.[AccountingDocumentTypeID] = accDT.[AccountingDocumentType]
        AND 
        accDT.[Language] = 'E'       
LEFT JOIN  
    [base_s4h_cax].[I_BusTransactionTypeText] bTTT
    ON 
        acdoca.[BusinessTransactionTypeID] = bTTT.[BusinessTransactionType]
        AND 
        bTTT.[Language] = 'E'       
LEFT JOIN  
    [base_s4h_cax].[I_SalesDistrictText] sDT    
    ON 
        acdoca.[SalesDistrictID] = sDT.[SalesDistrict]
        AND 
        sDT.[Language] = 'E' 
LEFT JOIN          
    [base_s4h_cax].[I_DebitCreditCodeText] dCCT
     ON 
        acdoca.[DebitCreditCodeID] = dCCT.[DebitCreditCode]
        AND 
        dCCT.[Language] = 'E'
/* 
-- US 1444 pending clarification of technical documentation
LEFT JOIN          
     [base_s4h_cax].[I_FinancialInstrTransTypeText]  fITTT
     ON 
        acdoca.[FinancialTransactionType] = fITTT.[FinancialInstrTransactionType]
        AND 
        fITTT.[Language] = 'E'
*/
LEFT JOIN          
     [base_s4h_cax].[I_FunctionalAreaText] fAT
     ON 
        acdoca.[FunctionalAreaID] = fAT.[FunctionalArea]
        AND 
        fAT.[Language] = 'E'
LEFT JOIN          
     [base_s4h_cax].[I_PostingKeyText] pKT
     ON 
        acdoca.[PostingKeyID] = pKT.[PostingKey]
        AND 
        pKT.[Language] = 'E'
LEFT JOIN          
     [base_s4h_cax].[I_ReferenceDocumentTypeText] prsDTT
     ON 
        acdoca.[PredecessorReferenceDocTypeID] = prsDTT.[ReferenceDocumentType]
        AND 
        prsDTT.[Language] = 'E'           
LEFT JOIN          
     [base_s4h_cax].[I_ReferenceDocumentTypeText] rDTT
     ON 
        acdoca.[ReferenceDocumentTypeID] = rDTT.[ReferenceDocumentType]
        AND 
        rDTT.[Language] = 'E'
LEFT JOIN          
     [base_s4h_cax].[I_ReferenceDocumentTypeText] rsDTT
     ON 
        acdoca.[SourceReferenceDocumentTypeID] = rsDTT.[ReferenceDocumentType]
        AND 
        rsDTT.[Language] = 'E'           
LEFT JOIN          
     [base_s4h_cax].[I_GLAccountTypeText] glaTT
     ON 
        acdoca.[GLAccountTypeID] = glaTT.[GLAccountType]
        AND 
        glaTT.[Language] = 'E'        