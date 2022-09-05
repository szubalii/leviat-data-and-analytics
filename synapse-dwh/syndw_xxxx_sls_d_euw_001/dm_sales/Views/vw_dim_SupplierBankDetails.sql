CREATE VIEW [dm_sales].[vw_dim_SupplierBankDetails]
  AS 
  SELECT 
  [SupplierID],
  [BankCountryID],
  [BankID],
  [BankAccountID],
  [t_applicationId],
  [t_extractionDtm]
FROM 
  [edw].[dim_SupplierBankDetails]
