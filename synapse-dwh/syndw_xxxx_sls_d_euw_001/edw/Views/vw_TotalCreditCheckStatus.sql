CREATE VIEW [edw].[vw_TotalCreditCheckStatus]
	AS SELECT 
		   TotalCreditCheckStatusText.[TotalCreditCheckStatus]     AS [TotalCreditCheckStatusID]
         , TotalCreditCheckStatusText.[TotalCreditCheckStatusDesc] AS [TotalCreditCheckStatus]
         , t_applicationId
    FROM [base_s4h_cax].[I_TotalCreditCheckStatusText] TotalCreditCheckStatusText
    WHERE TotalCreditCheckStatusText.[Language] = 'E' 
--     and [MANDT] = 200 MPS 2021/11/01: commented out due to different client values between dev,qas, and prod
