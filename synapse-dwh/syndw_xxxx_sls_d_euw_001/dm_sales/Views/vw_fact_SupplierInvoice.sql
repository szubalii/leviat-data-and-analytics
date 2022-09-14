CREATE VIEW [dm_sales].[vw_fact_SupplierInvoice]
AS
SELECT
    [SupplierInvoiceID],
    [FiscalYear],
    [InvoicingPartyID],
    [CompanyCodeID],
    [DocumentDate],
    [CreationDate],
    [PostingDate],
    [SupplyingCountryID],
    [SupplyingCountry],
    [InvoiceGrossAmount],
    [DocumentCurrencyID],
    [t_applicationId],
    [t_extractionDtm]
FROM
    [edw].[fact_SupplierInvoice]
