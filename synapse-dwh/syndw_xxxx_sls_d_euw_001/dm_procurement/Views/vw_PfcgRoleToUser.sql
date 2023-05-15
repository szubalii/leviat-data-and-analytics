CREATE VIEW [dm_procurement].[vw_PfcgRoleToUser]
AS
SELECT
    [MANDT]
  , [User_Name]
  , [Role_Name] 
  , [Valid_From]
  , [Valid_To]
  , [t_applicationId] 
  , [t_jobId] 
  , [t_jobDtm]
  , [t_jobBy] 
  , [t_extractionDtm] 
  , [t_filePath]
FROM
    [edw].[vw_PfcgRoleToUser]