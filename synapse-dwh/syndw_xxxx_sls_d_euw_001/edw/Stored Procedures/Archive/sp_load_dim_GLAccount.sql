CREATE PROC [edw].[sp_load_dim_GLAccount]
     @t_jobId [varchar](36)
    ,@t_jobDtm [datetime]
    ,@t_lastActionCd [varchar](1)
    ,@t_jobBy [nvarchar](128) 
AS
BEGIN

    IF OBJECT_ID('syndw_xxxx_sls_d_euw_001.edw.dim_GLAccountInChartOfAccounts', 'U') is not null TRUNCATE TABLE [edw].[dim_GLAccountInChartOfAccounts]

    INSERT INTO [edw].[dim_GLAccountInChartOfAccounts](
       [ChartOfAccounts]
      ,[GLAccountID]
      ,[GLAccount]
      ,[GLAccountLongName]
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
      ,[GLAccountTypeID]
      ,[GLAccountType]
      --,[GLAccountSubtype]
      ,[GLAccountExternal]
      --,[BankReconciliationAccount]
      ,[IsProfitLossAccount]
      ,[t_applicationId]
      ,[t_jobId]
      ,[t_jobDtm]
      ,[t_lastActionCd]
      ,[t_jobBy]
    )
    SELECT 
       GLAccountInChartOfAccounts.[ChartOfAccounts]
      ,GLAccountInChartOfAccounts.[GLAccount] as [GLAccountID]
      ,GLAccountText.[GLAccountName] as [GLAccount]
      ,GLAccountText.[GLAccountLongName]
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
      ,GLAccountInChartOfAccounts.[LastChangeDateTime]
      ,GLAccountInChartOfAccounts.[GLAccountType] as [GLAccountTypeID]
      ,GLAccountTypeText.[GLAccountTypeName] as [GLAccountType]
      --,[GLAccountSubtype]
      ,[GLAccountExternal]
      --,[BankReconciliationAccount]
      ,[IsProfitLossAccount]
      ,GLAccountInChartOfAccounts.[t_applicationId]
      ,@t_jobId AS t_jobId
      ,@t_jobDtm AS t_jobDtm
      ,@t_lastActionCd AS t_lastActionCd
      ,@t_jobBy AS t_jobBy
    FROM 
        [base_s4h_uat_caa].[I_GLAccountInChartOfAccounts] GLAccountInChartOfAccounts
    LEFT JOIN 
        [base_s4h_uat_caa].[I_GLAccountText] GLAccountText
        ON 
            GLAccountInChartOfAccounts.[GLAccount] = GLAccountText.[GLAccount]
            AND
            GLAccountText.[Language] = 'E'
    LEFT JOIN 
        [base_s4h_uat_caa].[I_GLAccountTypeText] GLAccountTypeText
        ON 
            GLAccountInChartOfAccounts.[GLAccountType] = GLAccountTypeText.[GLAccountType]
            AND
            GLAccountTypeText.[Language] = 'E'
 where    GLAccountInChartOfAccounts.[MANDT] = 200 
      and GLAccountText.[MANDT] = 200
END