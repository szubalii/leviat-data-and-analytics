CREATE VIEW [edw].[vw_SDDocumentRejectionStatus]
	AS SELECT 
		   SDDocumentRejectionStatusText.[SDDocumentRejectionStatus]     AS [SDDocumentRejectionStatusID]
         , SDDocumentRejectionStatusText.[SDDocumentRejectionStatusDesc] AS [SDDocumentRejectionStatus]
         , t_applicationId
    FROM [base_s4h_cax].[I_SDDocumentRejectionStatusT] SDDocumentRejectionStatusText
    WHERE SDDocumentRejectionStatusText.[Language] = 'E' 
--     AND [MANDT] = 200 MPS 2021/11/01: commented out due to different client values between dev,qas, and prod
