CREATE VIEW [dm_RiskAndCompliance].[vw_dim_ACMAuthznDataForActivityGrp]
AS
SELECT
     [LOGACCMACTYGRPPROFILEROLENAME]
    ,[LOGACCMACTYGRPPRFLCHGSTINTID]
    ,[AUTHORIZATIONGROUPOBJECT]
    ,[AUTHORIZATIONFROMVALUE]
    ,[AUTHORIZATIONTOVALUE]
    ,[t_applicationId]
    ,[t_extractionDtm]
FROM
    [base_s4h_cax].[I_ACMAuthznDataForActivityGrp]