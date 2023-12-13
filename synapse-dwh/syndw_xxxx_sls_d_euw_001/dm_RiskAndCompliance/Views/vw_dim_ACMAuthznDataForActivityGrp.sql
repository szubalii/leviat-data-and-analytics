CREATE VIEW [dm_RiskAndCompliance].[vw_dim_ACMAuthznDataForActivityGrp]
AS
SELECT
     [LogAccmActyGrpProfileRolename]
    ,[LogAccmActyGrpPrflChgsTintId]
    ,[AuthorizationGroupObject]
    ,[AuthorizationFromValue]
    ,[AuthorizationToValue]
    ,[t_applicationId]
    ,[t_extractionDtm]
FROM
    [base_s4h_cax].[I_ACMAuthznDataForActivityGrp]