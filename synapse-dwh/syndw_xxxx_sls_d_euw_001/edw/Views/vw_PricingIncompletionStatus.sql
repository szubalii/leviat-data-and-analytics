CREATE VIEW [edw].[vw_PricingIncompletionStatus]
	AS SELECT 
		   PricingIncompletionStatusText.[PricingIncompletionStatus]     AS [PricingIncompletionStatusID]
         , PricingIncompletionStatusText.[PricingIncompletionStatusDesc] AS [PricingIncompletionStatus]
         , t_applicationId
    FROM [base_s4h_cax].[I_PricingIncompletionStatusT] PricingIncompletionStatusText
    WHERE PricingIncompletionStatusText.[Language] = 'E'
      -- AND [MANDT] = 200 MPS 2021/11/01: commented out due to different client values between dev,qas, and prod
