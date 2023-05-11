CREATE VIEW [dm_procurement].[vw_PfcgRoleToUser]
AS
SELECT
    [MANDT]
  , [user_name]
  , [role_name] 
  , [valid_from]
  , [valid_to]
  , [t_applicationId] 
  , [t_jobId] 
  , [t_jobDtm]
  , [t_jobBy] 
  , [t_extractionDtm] 
  , [t_filePath]
FROM
    [edw].[vw_PfcgRoleToUser]