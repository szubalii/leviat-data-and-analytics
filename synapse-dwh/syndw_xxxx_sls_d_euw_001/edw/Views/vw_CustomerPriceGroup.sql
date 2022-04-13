CREATE VIEW [edw].[vw_CustomerPriceGroup]
	AS SELECT 
		   CustomerPriceGroupText.[CustomerPriceGroup]     AS [CustomerPriceGroupID]
         , CustomerPriceGroupText.[CustomerPriceGroupName] AS [CustomerPriceGroup]
         , t_applicationId
    FROM [base_s4h_cax].[I_CustomerPriceGroupText] CustomerPriceGroupText
    WHERE CustomerPriceGroupText.[Language] = 'E'
--     AND CustomerPriceGroupText.[MANDT] = 200 MPS 2021/11/01: commented out due to different client values between dev,qas, and prod
