CREATE VIEW [edw].[vw_ACDOCA_SalesDocument]
AS
SELECT  
       GLA.[SourceLedgerID],
       GLA.[CompanyCodeID], 
       GLA.[FiscalYear],
       GLA.[AccountingDocument], 
       GLA.[LedgerGLLineItem],
       MAX(SDI.[SalesOrganizationID]) as SalesOrganizationID_SDI
FROM [edw].[vw_GLAccountLineItemRawData] AS GLA
LEFT JOIN [edw].[fact_SalesDocumentItem] SDI 
    ON 
       GLA.SalesDocumentID = SDI.SalesDocument
       AND 
       SDI.CurrencyTypeID = '10'
GROUP BY
       GLA.[SourceLedgerID],
       GLA.[CompanyCodeID], 
       GLA.[FiscalYear],
       GLA.[AccountingDocument], 
       GLA.[LedgerGLLineItem]
