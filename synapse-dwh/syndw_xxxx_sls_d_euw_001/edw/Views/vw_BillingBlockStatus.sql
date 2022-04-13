CREATE VIEW [edw].[vw_BillingBlockStatus]
	AS SELECT 
		   BillingBlockStatusText.[BillingBlockStatus]     AS [BillingBlockStatusID]
         , BillingBlockStatusText.[BillingBlockStatusDesc] AS [BillingBlockStatus]
         , t_applicationId
    FROM [base_s4h_cax].[I_BillingBlockStatusText] BillingBlockStatusText
    WHERE BillingBlockStatusText.[Language] = 'E'
      -- AND [MANDT] = 200 MPS 2021/11/01: commented out due to different client values between dev,qas, and prod
