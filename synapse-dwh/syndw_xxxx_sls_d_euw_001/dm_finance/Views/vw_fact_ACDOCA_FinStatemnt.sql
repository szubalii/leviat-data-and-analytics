CREATE VIEW [dm_finance].[vw_fact_ACDOCA_FinStatemnt]
AS
SELECT
     [CompanyCodeID]
    ,[ProfitCenterID]
    ,[ProfitCenter]
    ,[GLAccountID]
    ,[FunctionalAreaID]
    ,[CurrencyID]
    ,[SAP_Sales]
    ,[SAP_COGS]
    ,[SAP_SalesMargin]
    ,[FiscalYear]
    ,[FiscalYearPeriod]
    ,[t_applicationId]
    ,[t_extractionDtm]
FROM
    [edw].[fact_ACDOCA_FinStatemnt]