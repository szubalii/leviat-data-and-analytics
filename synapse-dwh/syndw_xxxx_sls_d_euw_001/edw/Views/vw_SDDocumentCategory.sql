CREATE VIEW [edw].[vw_SDDocumentCategory]
	AS SELECT 
		   SDDocumentCategory.[SDDocumentCategory]         AS [SDDocumentCategoryID]
         , SDDocumentCategoryText.[SDDocumentCategoryName] AS [SDDocumentCategory]
         , SDDocumentCategory.t_applicationId
    FROM [base_s4h_cax].[I_SDDocumentCategory] SDDocumentCategory
             LEFT JOIN
         [base_s4h_cax].[I_SDDocumentCategoryText] SDDocumentCategoryText
         ON
                SDDocumentCategory.[SDDocumentCategory] = SDDocumentCategoryText.[SDDocumentCategory]
             AND
                SDDocumentCategoryText.[Language] = 'E'
