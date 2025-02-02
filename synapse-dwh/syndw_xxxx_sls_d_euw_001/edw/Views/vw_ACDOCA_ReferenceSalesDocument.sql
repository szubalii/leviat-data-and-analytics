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
       ) AS SalesReferenceDocumentCalculated,
       edw.svf_getSalesDocItem(
              GLA.SalesDocumentID
              ,GLA.SalesDocumentItemID
              ,DPF.SubsequentDocumentItem
              ,PF.PrecedingDocumentItem
       ) AS SalesReferenceDocumentItemCalculated
FROM [edw].[vw_GLAccountLineItemRawData] AS GLA
LEFT JOIN [base_s4h_cax].[I_SDDocumentProcessFlow] DPF
    ON
       GLA.SalesDocumentID = DPF.PrecedingDocument  
       AND
       GLA.SalesDocumentItemID = DPF.PrecedingDocumentItem  
       AND
       DPF.SubsequentDocumentCategory = 'C'
LEFT JOIN [base_s4h_cax].[I_SDDocumentProcessFlow] AS PF
    ON
       GLA.SalesDocumentID = PF.SubsequentDocument  
       AND
       GLA.SalesDocumentItemID = PF.SubsequentDocumentItem  
       AND
       PF.PrecedingDocumentCategory IN ('C', 'I')
WHERE GLA.[AccountingDocumentTypeID] <> 'DC'
)

SELECT
       SRDC.[SourceLedgerID],
       SRDC.[CompanyCodeID], 
       SRDC.[FiscalYear],
       SRDC.[AccountingDocument], 
       SRDC.[LedgerGLLineItem],
       SRDC.[SalesReferenceDocumentCalculated],
       SRDC.[SalesReferenceDocumentItemCalculated],
       SDI.[SalesDocumentItemCategoryID],
       SDI.[SalesOrganizationID] AS SDI_SalesOrganizationID,
       SDI.[SoldToPartyID] AS SDI_SoldToPartyID,
       SDI.[MaterialID] AS SDI_MaterialID
FROM SalesReferenceDocumentCalculated SRDC
LEFT JOIN [edw].[fact_SalesDocumentItem] SDI 
    ON 
       SRDC.SalesReferenceDocumentCalculated = SDI.SalesDocument
       AND 
       SRDC.SalesReferenceDocumentItemCalculated = SDI.SalesDocumentItem 
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
       SDI.[SalesDocumentItemCategoryID],
       SDI.[SalesOrganizationID],
       SDI.[SoldToPartyID],
       SDI.[MaterialID]
