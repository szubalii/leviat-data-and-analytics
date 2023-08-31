
CREATE VIEW dm_finance.vw_dim_ExqlReportingEntity AS
SELECT
    ExQLReportingEntity
    t_applicationId,
    t_jobId,
    t_jobDtm,
    t_jobBy,
    t_filePath
FROM base_ff.Budget_EPM
GROUP BY
    ExQLReportingEntity,
    t_applicationId,
    t_jobId,
    t_jobDtm,
    t_jobBy,
    t_filePath