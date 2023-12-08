CREATE VIEW [dm_RiskAndCompliance].[vw_fact_P_USR_AUTH_ROLE]
AS
SELECT
     [BNAME]
    ,[profile]
    ,[agr_name]
    ,[refuser]
    ,[from_dat]
    ,[to_dat]
    ,[col_flag]
    ,[org_flag]
    ,[text]
    ,[t_applicationId]
    ,[t_extractionDtm]
FROM
  [base_s4h_cax].[P_USR_AUTH_ROLE]