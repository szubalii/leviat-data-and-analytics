CREATE VIEW [edw].[vw_TotalSDDocReferenceStatus]
	AS SELECT 
		   TotalSDDocReferenceStatusText.[TotalSDDocReferenceStatus]     AS [TotalSDDocReferenceStatusID]
         , TotalSDDocReferenceStatusText.[TotalSDDocReferenceStatusDesc] AS [TotalSDDocReferenceStatus]
         , t_applicationId
    FROM [base_s4h_cax].[I_TotalSDDocReferenceStatusT] TotalSDDocReferenceStatusText
    WHERE TotalSDDocReferenceStatusText.[Language] = 'E'
      -- AND [MANDT] = 200 MPS 2021/11/01: commented out due to different client values between dev,qas, and prod
