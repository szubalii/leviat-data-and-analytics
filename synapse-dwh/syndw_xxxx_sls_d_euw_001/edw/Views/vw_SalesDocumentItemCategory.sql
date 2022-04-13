CREATE VIEW [edw].[vw_SalesDocumentItemCategory]
	AS SELECT 
		   SalesDocumentItemCategory.[SalesDocumentItemCategory]         AS [SalesDocumentItemCategoryID]
         , SalesDocumentItemCategoryText.[SalesDocumentItemCategoryName] AS [SalesDocumentItemCategory]
         , [ScheduleLineIsAllowed]
         , SalesDocumentItemCategory.t_applicationId
    FROM [base_s4h_cax].[I_SalesDocumentItemCategory] SalesDocumentItemCategory
             LEFT JOIN
         [base_s4h_cax].[I_SalesDocumentItemCategoryT] SalesDocumentItemCategoryText
         ON
                     SalesDocumentItemCategory.[SalesDocumentItemCategory] =
                     SalesDocumentItemCategoryText.[SalesDocumentItemCategory]
                 AND
                     SalesDocumentItemCategoryText.[Language] = 'E'
--    WHERE  SalesDocumentItemCategory.[MANDT] = 200 AND SalesDocumentItemCategoryText.[MANDT] = 200 MPS 2021/11/01: commented out due to different client values between dev,qas, and prod
