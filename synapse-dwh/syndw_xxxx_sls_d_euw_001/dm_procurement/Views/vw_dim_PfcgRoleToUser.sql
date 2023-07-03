CREATE VIEW [dm_procurement].[vw_dim_PfcgRoleToUser]
AS
SELECT
    [User_Name]
  , [Role_Name] 
  , [Valid_From]
  , [Valid_To]
  , [PurchasingOrganizationID]
FROM
    [edw].[vw_PfcgRoleToUser]