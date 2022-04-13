CREATE VIEW [edw].[vw_ItemBillingIncompletionStatus]
	AS SELECT 
		   ItemBillingIncompletionStatusText.[ItemBillingIncompletionStatus]     AS [ItemBillingIncompletionStatusID]
         , ItemBillingIncompletionStatusText.[ItemBillingIncompletionStsDesc]    AS [ItemBillingIncompletionStatus]
         , t_applicationId
    FROM [base_s4h_cax].[I_ItemBillingIncompletionStsT] ItemBillingIncompletionStatusText
    WHERE ItemBillingIncompletionStatusText.[Language] = 'E'
      -- AND [MANDT] = 200 MPS 2021/11/01: commented out due to different client values between dev,qas, and prod
