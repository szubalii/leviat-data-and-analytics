CREATE VIEW [edw].[vw_PfcgRoleToUser]
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
    [base_s4h_cax].[Pfcg_Role_To_User]