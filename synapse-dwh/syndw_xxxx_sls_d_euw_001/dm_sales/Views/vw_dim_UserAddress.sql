CREATE VIEW [dm_sales].[vw_dim_UserAddress] AS 

SELECT
  [UserName]
, [UserID]
, [UserClass]
, [t_applicationId]  
, [t_jobId]             
, [t_jobDtm]          
, [t_jobBy]      
, [t_filePath]    
, [t_extractionDtm]  

FROM [edw].[dim_UserAddress]
