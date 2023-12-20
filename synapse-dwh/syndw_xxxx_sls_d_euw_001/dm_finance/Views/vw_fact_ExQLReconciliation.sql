CREATE VIEW [dm_finance].[vw_fact_ExQLReconciliation] AS
SELECT
     [edw].[svf_get2PartNaturalKey](
        [CompanyCode],
        [ExQLReportingEntity]
     ) AS [nk_ExQLReconciliation]
    ,[ReportingEntity]
    ,[CompanyCode]
    ,[ExQLReportingEntity]
    ,[YTD]
    ,[ExQLValueIn$MM]
    ,[t_applicationId]
	,[t_jobDtm]
FROM
    [base_ff].[ExQLReconciliation]