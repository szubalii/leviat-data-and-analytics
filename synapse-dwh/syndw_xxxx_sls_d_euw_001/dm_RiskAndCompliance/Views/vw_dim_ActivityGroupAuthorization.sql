CREATE VIEW [dm_RiskAndCompliance].[vw_dim_ActivityGroupAuthorization]
AS
SELECT
  AGR.[Agr_Name] AS [ActivityGroupRoleName]
--   , AGR.[Counter]
-- , AGR.[Object] AS [Transaction]
--   , AGR.[Auth]
--   , AGR.[Variant]
--   , AGR.[Field]
, AGR.[Low] AS [TransactionCode]
, TSTCT.[TText] AS [TransactionCodeText]
--   , AGR.[High]
--   , AGR.[Modified]
--   , AGR.[Deleted]
--   , AGR.[Copied]
--   , AGR.[Neu]
--   , AGR.[Node]
, AGR.[t_applicationId]
, AGR.[t_extractionDtm]
FROM
  [base_s4h_cax].[AGR_1251] AGR
LEFT JOIN
  [base_s4h_cax].[TSTCT] TSTCT
  ON
    AGR.[Low] = TSTCT.[TCode]
