CREATE VIEW [dm_finance].[vw_fact_Reconciliation] AS
SELECT
     [ReportingEntity]
    ,[CompanyCode]
    ,[ExQLReportingEntity]
    ,[Key]
    ,[YTD]
    ,[HFMvaluesIN$M]
    ,[t_applicationId]
	,[t_jobDtm]
FROM
    [base_ff].[Reconciliation]