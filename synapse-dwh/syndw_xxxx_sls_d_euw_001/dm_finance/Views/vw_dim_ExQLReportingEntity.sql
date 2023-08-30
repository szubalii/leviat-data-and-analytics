
CREATE VIEW dm_finance.vw_dim_ExQLReportingEntity AS
    SELECT
    CompanyCodeID,
    ProfitCenterID,
    CompanyCodeID + ProfitCenterID                     AS [SKReportingEntityKey],
    ExQLReportingEntity,
    CONCAT(CompanyCodeID,'_',ExQLReportingEntity)      AS [ReportingEntityID],
    t_applicationId,
    t_jobId,
    t_jobDtm,
    t_jobBy,
    t_filePath
FROM base_ff.ExQLReportingEntity;