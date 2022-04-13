CREATE VIEW [edw].[vw_DeliveryBlockStatus]
	AS SELECT 
		   DeliveryBlockStatusText.[DeliveryBlockStatus]     AS [DeliveryBlockStatusID]
         , DeliveryBlockStatusText.[DeliveryBlockStatusDesc] AS [DeliveryBlockStatus]
         , t_applicationId
    FROM [base_s4h_cax].[I_DeliveryBlockStatusText] DeliveryBlockStatusText
    WHERE DeliveryBlockStatusText.[Language] = 'E'
      -- AND [MANDT] = 200 MPS 2021/11/01: commented out due to different client values between dev,qas, and prod
