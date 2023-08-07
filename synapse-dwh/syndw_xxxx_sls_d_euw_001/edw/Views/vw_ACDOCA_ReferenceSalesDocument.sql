CREATE VIEW [edw].[vw_ACDOCA_ReferenceSalesDocument]
AS
WITH SalesReferenceDocumentCalculated AS (
SELECT  
       GLA.[SourceLedgerID],
       GLA.[CompanyCodeID], 
       GLA.[FiscalYear],
       GLA.[AccountingDocument], 
       GLA.[LedgerGLLineItem],
       edw.svf_getSalesDoc(GLA.SalesDocumentID,DPF.SubsequentDocument,PF.PrecedingDocument) AS SalesReferenceDocumentCalculated,
       edw.svf_getSalesDocItem(GLA.SalesDocumentID,GLA.SalesDocumentItemID,DPF.SubsequentDocumentItem,PF.PrecedingDocumentItem) AS SalesReferenceDocumentItemCalculated
FROM [edw].[vw_GLAccountLineItemRawData] AS GLA
LEFT JOIN [base_s4h_cax].[I_SDDocumentProcessFlow] DPF
    ON
       GLA.SalesDocumentID = DPF.PrecedingDocument COLLATE DATABASE_DEFAULT 
       AND
       GLA.SalesDocumentItemID = DPF.PrecedingDocumentItem COLLATE DATABASE_DEFAULT 
       AND
       DPF.SubsequentDocumentCategory = 'C'
LEFT JOIN [base_s4h_cax].[I_SDDocumentProcessFlow] AS PF
    ON
       GLA.SalesDocumentID = PF.SubsequentDocument COLLATE DATABASE_DEFAULT 
       AND
       GLA.SalesDocumentItemID = PF.SubsequentDocumentItem COLLATE DATABASE_DEFAULT 
       AND
       PF.PrecedingDocumentCategory IN ('C', 'I')
)

SELECT
       [SourceLedgerID],
       [CompanyCodeID], 
       [FiscalYear],
       [AccountingDocument], 
       [LedgerGLLineItem],
       [SalesReferenceDocumentCalculated],
       [SalesReferenceDocumentItemCalculated]
FROM SalesReferenceDocumentCalculated 
GROUP BY
       [SourceLedgerID],
       [CompanyCodeID], 
       [FiscalYear],
       [AccountingDocument], 
       [LedgerGLLineItem],
       [SalesReferenceDocumentCalculated],
       [SalesReferenceDocumentItemCalculated]
