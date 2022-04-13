CREATE VIEW [edw].[vw_SalesDocumentType]
	AS SELECT 
		   SalesDocumentTypeText.[SalesDocumentType]     AS [SalesDocumentTypeID]
         , SalesDocumentTypeText.[SalesDocumentTypeName] AS [SalesDocumentType]
         , t_applicationId
    FROM [base_s4h_cax].[I_SalesDocumentTypeText] SalesDocumentTypeText
    WHERE SalesDocumentTypeText.[Language] = 'E' 
--     AND [MANDT] = 200 MPS 2021/11/01: commented out due to different client values between dev,qas, and prod
