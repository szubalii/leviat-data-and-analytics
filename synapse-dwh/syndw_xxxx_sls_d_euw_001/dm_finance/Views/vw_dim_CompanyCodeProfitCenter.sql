CREATE VIEW dm_finance.vw_dim_CompanyCodeProfitCenter AS
SELECT
    CompanyCodeID,
    ProfitCenterID,
    CompanyCodeID + ProfitCenterID AS [SKReportingEntityKey],
    ExQLReportingEntity
FROM base_ff.ExQLReportingEntity;