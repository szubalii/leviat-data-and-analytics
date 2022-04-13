CREATE PROC [base_s4h_uat_caa].[sp_load_ControllingArea_base] 
@t_applicationId [varchar](7),
@t_jobId [varchar](36),
@t_lastDtm [datetime],
@t_lastActionBy [nvarchar](20),
@t_filePath [nvarchar](1024) 
AS
BEGIN
	
	TRUNCATE TABLE [base_s4h_uat_caa].[I_ControllingArea]

	INSERT INTO [base_s4h_uat_caa].[I_ControllingArea](
	   [ControllingArea]
      ,[FiscalYearVariant]
      ,[ControllingAreaName]
      ,[ControllingAreaCurrency]
      ,[ChartOfAccounts]
      ,[CostCenterStandardHierarchy]
      ,[ProfitCenterStandardHierarchy]
      ,[FinancialManagementArea]
      ,[ControllingAreaCurrencyRole]
      ,[CtrlgStdFinStatementVersion]
      ,[ProfitCenterAccountingCurrency]
      ,[t_applicationId]
      ,[t_jobId]
      ,[t_lastDtm]
      ,[t_lastActionBy]
      ,[t_filePath]
	)
	SELECT
	 [ControllingArea]
    ,[FiscalYearVariant]
    ,[ControllingAreaName]
    ,CONVERT([char](5), [ControllingAreaCurrency]) as [ControllingAreaCurrency]
    ,[ChartOfAccounts]
    ,[CostCenterStandardHierarchy]
    ,[ProfitCenterStandardHierarchy]
    ,[FinancialManagementArea]
    ,[ControllingAreaCurrencyRole]
    ,[CtrlgStdFinStatementVersion]
    ,CONVERT([char](5), [ProfitCenterAccountingCurrency]) as [ProfitCenterAccountingCurrency]
	,@t_applicationId AS t_applicationId
	,@t_jobId AS t_jobId
	,@t_lastDtm AS t_lastDtm
	,@t_lastActionBy AS t_lastActionBy
	,@t_filePath AS t_filePath
	FROM [base_s4h_uat_caa].[I_ControllingArea_staging]
END