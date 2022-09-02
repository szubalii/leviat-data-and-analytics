CREATE VIEW [edw].[vw_SupplierBankDetails]
AS
SELECT 
  [Supplier]              AS [SupplierID],
  [BankCountry]           AS [BankCountryID],
  [Bank]                  AS [BankID],
  [BankAccount]           AS [BankAccountID],
  [t_applicationId],
  [t_extractionDtm]
FROM 
  [base_s4h_cax].[I_SupplierBankDetails]
