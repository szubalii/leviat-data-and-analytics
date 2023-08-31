
CREATE VIEW dm_finance.vw_dim_ExQLReportingEntity AS
SELECT
       ExQLReportingEntity
FROM base_ff.Budget_EPM
GROUP BY
       ExQLReportingEntity