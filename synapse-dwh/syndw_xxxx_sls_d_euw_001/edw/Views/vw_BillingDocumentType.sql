CREATE VIEW [edw].[vw_BillingDocumentType]
AS
SELECT
    BDT.[BillingDocumentType] AS [BillingDocumentTypeID]
  , BDTT.[BillingDocumentTypeName] AS [BillingDocumentType]
  , BDT.[SDDocumentCategory] AS [SDDocumentCategoryID]
  , BDT.[IncrementItemNumber]
  , BDT.[BillingDocumentCategory]
  , BDT.[t_applicationId]
FROM
  [base_s4h_cax].[I_BillingDocumentType] AS BDT
LEFT JOIN
  [base_s4h_cax].[I_BillingDocumentTypeText] AS BDTT
  ON
    BDTT.[BillingDocumentType] = BDT.[BillingDocumentType]
    AND
    BDTT.[Language] = 'E'
    -- WHERE BillingDocumentType.[MANDT] = 200 AND BillingDocumentTypeText.[MANDT] = 200 MPS 2021/11/01: commented out due to different client values between dev,qas, and prod
