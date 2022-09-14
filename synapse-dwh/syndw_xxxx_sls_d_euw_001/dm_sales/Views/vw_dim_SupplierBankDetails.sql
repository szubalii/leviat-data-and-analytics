CREATE VIEW [dm_sales].[vw_dim_SupplierBankDetails]
AS
SELECT
  sbd.[SupplierID],
  sbd.[BankCountryID],
  sbd.[BankID],
  b.[BankName] AS Bank,
  sbd.[BankAccountID],
  bat.[BankAccountDescription] AS BankAccount,
  sbd.[t_applicationId],
  sbd.[t_extractionDtm]
FROM
  [edw].[dim_SupplierBankDetails] AS sbd
LEFT JOIN
  [base_s4h_cax].[I_Bank] AS b
  ON
    b.BankCountry = sbd.BankCountryID
    AND
    b.BankInternalID = sbd.BankID
LEFT JOIN
  [base_s4h_cax].[I_BankAccountText] bat
  ON
    bat.BankAccountInternalID = sbd.BankAccountID
    AND
    bat.Language = 'E'
