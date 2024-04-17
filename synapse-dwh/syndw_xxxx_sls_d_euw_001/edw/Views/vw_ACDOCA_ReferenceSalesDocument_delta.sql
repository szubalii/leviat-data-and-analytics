CREATE VIEW [edw].[vw_ACDOCA_ReferenceSalesDocument_delta]
AS
WITH SalesReferenceDocumentCalculated AS (
  SELECT  
    GLA.[SourceLedger],
    GLA.[CompanyCode], 
    GLA.[FiscalYear],
    GLA.[AccountingDocument], 
    GLA.[LedgerGLLineItem],
    edw.svf_getSalesDoc(
      GLA.SalesDocument
      ,DPF.SubsequentDocument
      ,PF.PrecedingDocument
    ) AS SalesReferenceDocumentCalculated,
    edw.svf_getSalesDocItem(
      GLA.SalesDocument
      ,GLA.SalesDocumentItem
      ,DPF.SubsequentDocumentItem
      ,PF.PrecedingDocumentItem
    ) AS SalesReferenceDocumentItemCalculated
  FROM
    [base_s4h_cax].[vw_I_GLAccountLineItemRawData_delta] AS GLA
  LEFT JOIN
    [base_s4h_cax].[I_SDDocumentProcessFlow] DPF
    ON
      GLA.SalesDocument = DPF.PrecedingDocument COLLATE DATABASE_DEFAULT 
      AND
      GLA.SalesDocumentItem = DPF.PrecedingDocumentItem COLLATE DATABASE_DEFAULT 
      AND
      DPF.SubsequentDocumentCategory = 'C'
  LEFT JOIN
    [base_s4h_cax].[I_SDDocumentProcessFlow] AS PF
    ON
      GLA.SalesDocument = PF.SubsequentDocument COLLATE DATABASE_DEFAULT 
      AND
      GLA.SalesDocumentItem = PF.SubsequentDocumentItem COLLATE DATABASE_DEFAULT 
      AND
      PF.PrecedingDocumentCategory IN ('C', 'I')
  WHERE
    GLA.[AccountingDocumentType] <> 'DC'
)

SELECT
  SRDC.[SourceLedger],
  SRDC.[CompanyCode], 
  SRDC.[FiscalYear],
  SRDC.[AccountingDocument], 
  SRDC.[LedgerGLLineItem],
  SRDC.[SalesReferenceDocumentCalculated],
  SRDC.[SalesReferenceDocumentItemCalculated],
  SDI.[SalesDocumentItemCategoryID],
  SDI.[SalesOrganizationID] AS SDI_SalesOrganizationID,
  SDI.[SoldToPartyID] AS SDI_SoldToPartyID,
  SDI.[MaterialID] AS SDI_MaterialID
FROM
  SalesReferenceDocumentCalculated SRDC
LEFT JOIN
  [edw].[fact_SalesDocumentItem] SDI 
  ON 
    SRDC.SalesReferenceDocumentCalculated = SDI.SalesDocument
    AND 
    SRDC.SalesReferenceDocumentItemCalculated = SDI.SalesDocumentItem COLLATE DATABASE_DEFAULT
    AND 
    SDI.CurrencyTypeID = '10'
GROUP BY
  SRDC.[SourceLedger],
  SRDC.[CompanyCode], 
  SRDC.[FiscalYear],
  SRDC.[AccountingDocument], 
  SRDC.[LedgerGLLineItem],
  SRDC.[SalesReferenceDocumentCalculated],
  SRDC.[SalesReferenceDocumentItemCalculated],
  SDI.[SalesDocumentItemCategoryID],
  SDI.[SalesOrganizationID],
  SDI.[SoldToPartyID],
  SDI.[MaterialID]
