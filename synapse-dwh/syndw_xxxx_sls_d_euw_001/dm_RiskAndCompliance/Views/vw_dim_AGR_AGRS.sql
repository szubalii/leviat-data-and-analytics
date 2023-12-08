CREATE VIEW [dm_RiskAndCompliance].[vw_dim_AGR_AGRS]
AS
SELECT
     [AGR_NAME]
    ,[CHILD_AGR]
    ,[ATTRIBUTES]
    ,[t_applicationId]
    ,[t_extractionDtm]
FROM
    [base_s4h_cax].[AGR_AGRS]