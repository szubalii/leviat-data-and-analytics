CREATE VIEW [edw].[vw_ACDOCA_ReferenceSalesDocument]
AS
WITH SalesReferenceDocumentCalculated AS (
SELECT  
       GLA.[SourceLedgerID],
       GLA.[CompanyCodeID], 
       GLA.[FiscalYear],
       GLA.[AccountingDocument], 
       GLA.[LedgerGLLineItem],
       edw.svf_getSalesDoc(
              GLA.SalesDocumentID
              ,DPF.SubsequentDocument
              ,PF.PrecedingDocument
              ,GLA.[AccountingDocumentTypeID]
       ) AS SalesReferenceDocumentCalculated,
       edw.svf_getSalesDocItem(
              GLA.SalesDocumentID
              ,GLA.SalesDocumentItemID
              ,DPF.SubsequentDocumentItem
              ,PF.PrecedingDocumentItem
              ,GLA.[AccountingDocumentTypeID]
       ) AS SalesReferenceDocumentItemCalculated
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
       SRDC.[SourceLedgerID],
       SRDC.[CompanyCodeID], 
       SRDC.[FiscalYear],
       SRDC.[AccountingDocument], 
       SRDC.[LedgerGLLineItem],
       SRDC.[SalesReferenceDocumentCalculated],
       SRDC.[SalesReferenceDocumentItemCalculated],
       SDI.[SalesDocumentItemCategoryID]
FROM SalesReferenceDocumentCalculated SRDC
LEFT JOIN [edw].[fact_SalesDocumentItem] SDI 
    ON 
       SRDC.SalesReferenceDocumentCalculated = SDI.SalesDocument
       AND 
       SRDC.SalesReferenceDocumentItemCalculated = SDI.SalesDocumentItem COLLATE DATABASE_DEFAULT
       AND 
       SDI.CurrencyTypeID = '10'
GROUP BY
       SRDC.[SourceLedgerID],
       SRDC.[CompanyCodeID], 
       SRDC.[FiscalYear],
       SRDC.[AccountingDocument], 
       SRDC.[LedgerGLLineItem],
       SRDC.[SalesReferenceDocumentCalculated],
       SRDC.[SalesReferenceDocumentItemCalculated],
       SDI.[SalesDocumentItemCategoryID]
