CREATE VIEW [dbo].[vw_fact_SupplierInvoice]
  AS 
  SELECT
    [SupplierInvoiceID],
    [FiscalYear],
    [InvoicingPartyID],
    [CompanyCodeID],
    [DocumentDate] 
    [PostingDate],  
    [SupplyingCountryID],
    [SupplyingCountry],   
    [t_applicationId],
    [t_extractionDtm]          
  FROM 
    [edw].[fact_SupplierInvoice]
