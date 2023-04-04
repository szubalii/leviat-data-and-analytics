CREATE VIEW [dm_sales].[vw_dim_CustomerGroup]
AS 
SELECT 
       [CustomerGroupID]
      ,[CustomerGroup]
      ,[t_applicationId]
      ,[t_jobDtm]
      ,[t_lastActionCd]
  FROM [edw].[dim_CustomerGroup]