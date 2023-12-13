CREATE VIEW [dm_RiskAndCompliance].[vw_dim_ActivityGroupRolesInCompositeRoles]
AS
SELECT
     [Agr_Name]
    ,[Child_Agr]
    ,[Attributes]
    ,[t_applicationId]
    ,[t_extractionDtm]
FROM
    [base_s4h_cax].[AGR_AGRS]