
CREATE VIEW dm_finance.vw_dim_ExQLReportingEntity AS
    SELECT
    CompanyCodeID,
    ProfitCenterID,
    CompanyCodeID + ProfitCenterID as SKReportingEntityKey ,
    ExQLReportingEntity,
    t_applicationId,
    t_jobId,
    t_jobDtm,
    t_jobBy,
    t_filePath
FROM base_ff.ExQLReportingEntity;