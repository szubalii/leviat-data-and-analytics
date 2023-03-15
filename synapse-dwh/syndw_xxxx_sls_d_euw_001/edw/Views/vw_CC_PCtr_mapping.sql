
CREATE VIEW edw.vw_dim_CC_PCtr AS
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
FROM base_ff.CC_PCtr_mapping;