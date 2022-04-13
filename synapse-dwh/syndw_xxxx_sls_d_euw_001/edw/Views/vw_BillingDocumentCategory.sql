CREATE VIEW [edw].[vw_BillingDocumentCategory]
	AS SELECT 
           BillingDocumentCategoryText.[BillingDocumentCategory]     AS [BillingDocumentCategoryID]
         , BillingDocumentCategoryText.[BillingDocumentCategoryName] AS [BillingDocumentCategory]
         , t_applicationId
    FROM [base_s4h_cax].[I_BillingDocumentCategoryText] BillingDocumentCategoryText
    WHERE BillingDocumentCategoryText.[Language] = 'E'