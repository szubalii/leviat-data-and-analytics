CREATE VIEW [edw].[vw_PurchasingDocumentType]
	AS
SELECT
       PDT.[PurchasingDocumentType]     AS [PurchasingDocumentTypeID],
       PDT.[PurchasingDocumentCategory] AS [PurchasingDocumentCategoryID],
       PDT.[PurgDocFieldSelControlKey],
       PDT.[PurgHasFlxblWorkflowApproval],
       PDTT.[PurchasingDocumentTypeName],
       PDT.[t_applicationId]
FROM [base_s4h_cax].[I_PurchasingDocumentType] PDT
LEFT JOIN [base_s4h_cax].[I_PurchasingDocumentTypeText] PDTT
  ON
  PDT.[PurchasingDocumentType] = PDTT.[PurchasingDocumentType]
    AND
  PDT.[PurchasingDocumentCategory] = PDTT.[PurchasingDocumentCategory]
WHERE PDTT.[Language] = 'E'
