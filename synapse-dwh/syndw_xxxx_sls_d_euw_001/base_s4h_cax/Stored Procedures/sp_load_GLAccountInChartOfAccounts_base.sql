CREATE PROC [base_s4h_uat_caa].[sp_load_GLAccountInChartOfAccounts_base] 
@t_applicationId [varchar](7),
@t_jobId [varchar](36),
@t_lastDtm [datetime],
@t_lastActionBy [nvarchar](20),
@t_filePath [nvarchar](1024) 
AS
BEGIN
	
	TRUNCATE TABLE [base_s4h_uat_caa].[I_GLAccountInChartOfAccounts]

	INSERT INTO [base_s4h_uat_caa].[I_GLAccountInChartOfAccounts](
	   [ChartOfAccounts]
      ,[GLAccount]
      ,[IsBalanceSheetAccount]
      ,[GLAccountGroup]
      ,[CorporateGroupAccount]
      ,[ProfitLossAccountType]
      ,[SampleGLAccount]
      ,[AccountIsMarkedForDeletion]
      ,[AccountIsBlockedForCreation]
      ,[AccountIsBlockedForPosting]
      ,[AccountIsBlockedForPlanning]
      ,[PartnerCompany]
      ,[FunctionalArea]
      ,[CreationDate]
      ,[CreatedByUser]
      ,[LastChangeDateTime]
      ,[GLAccountType]
      --,[GLAccountSubtype]
      ,[GLAccountExternal]
      --,[BankReconciliationAccount] did not find in source file
      ,[IsProfitLossAccount]
      ,[t_applicationId]
      ,[t_jobId]
      ,[t_lastDtm]
      ,[t_lastActionBy]
      ,[t_filePath]
	)
	SELECT
	 [ChartOfAccounts]
    ,[GLAccount]
    ,[IsBalanceSheetAccount]
    ,[GLAccountGroup]
    ,[CorporateGroupAccount]
    ,[ProfitLossAccountType]
    ,[SampleGLAccount]
    ,[AccountIsMarkedForDeletion]
    ,[AccountIsBlockedForCreation]
    ,[AccountIsBlockedForPosting]
    ,[AccountIsBlockedForPlanning]
    ,[PartnerCompany]
    ,[FunctionalArea]
    ,CASE [CreationDate]
		WHEN '00000000' THEN '19000101' 
		ELSE CONVERT([date], [CreationDate], 112) 
	END AS [CreationDate]
    ,[CreatedByUser]
    ,CONVERT([decimal](15), CASE 
							WHEN RIGHT(RTRIM([LastChangeDateTime]), 1) = '-'
							THEN '-' + REPLACE([LastChangeDateTime], '-','')
							ELSE [LastChangeDateTime]
							END) AS [LastChangeDateTime]
    ,[GLAccountType]
    --,[GLAccountSubtype]
    ,[GLAccountExternal]
    --,[BankReconciliationAccount]
    ,[IsProfitLossAccount]
	,@t_applicationId AS t_applicationId
	,@t_jobId AS t_jobId
	,@t_lastDtm AS t_lastDtm
	,@t_lastActionBy AS t_lastActionBy
	,@t_filePath AS t_filePath
	FROM [base_s4h_uat_caa].[I_GLAccountInChartOfAccounts_staging]
END