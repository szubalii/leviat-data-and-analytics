CREATE VIEW [dm_sales].[vw_dim_DistributionChannel]
AS 
SELECT 
       [DistributionChannelID]
      ,[DistributionChannel]
      ,[t_applicationId]
      ,[t_jobDtm]
      ,[t_lastActionCd]
 FROM [edw].[dim_DistributionChannel]