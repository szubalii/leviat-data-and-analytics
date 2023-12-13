CREATE VIEW [dm_RiskAndCompliance].[vw_dim_UserAuthorizationRoles]
AS
SELECT
     [BName]
    ,[Profile]
    ,[Agr_Name]
    ,[RefUser]
    ,[From_Dat]
    ,[To_Dat]
    ,[Col_Flag]
    ,[Org_Flag]
    ,[Text]
    ,[t_applicationId]
    ,[t_extractionDtm]
FROM
  [base_s4h_cax].[P_USR_AUTH_ROLE]