CREATE VIEW [edw].[vw_PfcgRoleToUser]
AS
SELECT
    [MANDT]
  , [User_Name]
  , [Role_Name] 
  , [Valid_From]
  , [Valid_To]
  , CONCAT(SUBSTRING(Role_Name,12,2), '01') as PurchasingOrganizationID --1 Purch Org per Company Code, country indicates the Purch Org.
FROM
    [base_s4h_cax].[Pfcg_Role_To_User]

--Remove any global users that are not assigned to a purchasing organization from the dataset. (Firefighters, Master Data Members etc.)
WHERE CONCAT(SUBSTRING(Role_Name,12,2), '01') <> 'XX01' 