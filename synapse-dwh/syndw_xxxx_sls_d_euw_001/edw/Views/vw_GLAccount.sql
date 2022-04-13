CREATE VIEW [edw].[vw_GLAccount]
	AS SELECT 
	   GLAccountInChartOfAccounts.[ChartOfAccounts]
      ,GLAccountInChartOfAccounts.[GLAccount] AS [GLAccountID]
      ,GLAccountText.[GLAccountName] AS [GLAccount]
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
      ,GLAccountInChartOfAccounts.[GLAccountType] AS [GLAccountTypeID]
      ,GLAccountTypeText.[GLAccountTypeName] AS [GLAccountType]
      ,[GLAccountExternal]
      ,[IsProfitLossAccount]
      ,GLAccountInChartOfAccounts.[t_applicationId]
    FROM 
        [base_s4h_cax].[I_GLAccountInChartOfAccounts] GLAccountInChartOfAccounts
    LEFT JOIN 
        [base_s4h_cax].[I_GLAccountText] GLAccountText
        ON 
            GLAccountInChartOfAccounts.[GLAccount] = GLAccountText.[GLAccount]
            AND
            GLAccountText.[Language] = 'E'
    LEFT JOIN 
        [base_s4h_cax].[I_GLAccountTypeText] GLAccountTypeText
        ON 
            GLAccountInChartOfAccounts.[GLAccountType] = GLAccountTypeText.[GLAccountType]
            AND
            GLAccountTypeText.[Language] = 'E'
--  WHERE    GLAccountInChartOfAccounts.[MANDT] = 200 AND GLAccountText.[MANDT] = 200 MPS 2021/11/01: commented out due to different client values between dev,qas, and prod
