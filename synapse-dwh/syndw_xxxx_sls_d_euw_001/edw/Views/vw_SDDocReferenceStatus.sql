CREATE VIEW [edw].[vw_SDDocReferenceStatus]
	AS SELECT 
		   SDDocReferenceStatusText.[SDDocReferenceStatus]     AS [SDDocReferenceStatusID]
         , SDDocReferenceStatusText.[SDDocReferenceStatusDesc] AS [SDDocReferenceStatus]
         , t_applicationId
    FROM [base_s4h_cax].[I_SDDocReferenceStatusText] SDDocReferenceStatusText
    WHERE SDDocReferenceStatusText.[Language] = 'E' 
--     AND [MANDT] = 200 MPS 2021/11/01: commented out due to different client values between dev,qas, and prod
