CREATE VIEW [edw].[vw_DistributionChannel]
AS 
     SELECT 
	     [DistributionChannel]     AS [DistributionChannelID]
     ,    [DistributionChannelName] AS [DistributionChannel]
     ,    [t_applicationId]
     FROM 
          [base_s4h_cax].[I_DistributionChannelText] DistributionChannelText
     WHERE
          DistributionChannelText.[Language] = 'E' 
          -- AND
          -- DistributionChannelText.MANDT = 200 MPS 2021/11/01: commented out due to different client values between dev,qas, and prod
