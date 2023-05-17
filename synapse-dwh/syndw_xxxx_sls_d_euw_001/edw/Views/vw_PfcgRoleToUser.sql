CREATE VIEW [edw].[vw_PfcgRoleToUser]
AS
SELECT
    [MANDT]
  , [User_Name]
  , [Role_Name] 
  , [Valid_From]
  , [Valid_To]
FROM
    [base_s4h_cax].[Pfcg_Role_To_User]