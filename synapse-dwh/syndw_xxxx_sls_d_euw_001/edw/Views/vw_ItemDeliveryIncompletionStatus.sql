CREATE VIEW [edw].[vw_ItemDeliveryIncompletionStatus]
	AS SELECT 
		   ItemDeliveryIncompletionStatusText.[ItemDeliveryIncompletionStatus]     AS [ItemDeliveryIncompletionStatusID]
         , ItemDeliveryIncompletionStatusText.[ItemDelivIncompletionStsDesc]       AS [ItemDeliveryIncompletionStatus]
         , t_applicationId
    FROM [base_s4h_cax].[I_ItemDelivIncompletionStsT] ItemDeliveryIncompletionStatusText
    WHERE ItemDeliveryIncompletionStatusText.[Language] = 'E'
      -- AND [MANDT] = 200 MPS 2021/11/01: commented out due to different client values between dev,qas, and prod
