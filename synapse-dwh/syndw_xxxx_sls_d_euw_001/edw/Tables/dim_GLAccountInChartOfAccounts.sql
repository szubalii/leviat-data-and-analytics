CREATE TABLE [edw].[dim_GLAccountInChartOfAccounts] (
-- G/L Account In Chart Of Accounts
  [ChartOfAccounts] nvarchar(8) NOT NULL
, [GLAccountID] nvarchar(20) NOT NULL --renamed (ex GLAccount)
--, [Language] char(1)  -- from [base_s4h_cax].[I_GLAccountText]
, [GLAccount] nvarchar(40) --renamed (ex GLAccountName)
, [GLAccountLongName] nvarchar(100) --from [base_s4h_cax].[I_GLAccountText]
, [IsBalanceSheetAccount] nvarchar(2)
, [GLAccountGroup] nvarchar(8)
, [CorporateGroupAccount] nvarchar(20)
, [ProfitLossAccountType] nvarchar(4)
, [SampleGLAccount] nvarchar(20)
, [AccountIsMarkedForDeletion] nvarchar(2)
, [AccountIsBlockedForCreation] nvarchar(2)
, [AccountIsBlockedForPosting] nvarchar(2)
, [AccountIsBlockedForPlanning] nvarchar(2)
, [PartnerCompany] nvarchar(12)
, [FunctionalArea] nvarchar(32)
, [CreationDate] date
, [CreatedByUser] nvarchar(24)
, [LastChangeDateTime] decimal(15)
, [GLAccountTypeID] nvarchar(2) --renamed (ex GLAccountType)
, [GLAccountType] nvarchar(120) --renamed (ex [GLAccountTypeName]) from [base_s4h_cax].[I_GLAccountTypeText]
, [GLAccountSubtype] nvarchar(2)
, [GLAccountExternal] nvarchar(20)
, [BankReconciliationAccount] nvarchar(20)
, [IsProfitLossAccount] nvarchar(2)
, [t_applicationId]       VARCHAR (32)
, [t_jobId]               VARCHAR (36)
, [t_jobDtm]              DATETIME
, [t_lastActionCd]        VARCHAR(1)
, [t_jobBy]               NVARCHAR(128)
,    CONSTRAINT [PK_dim_GLAccountInChartOfAccounts] PRIMARY KEY NONCLUSTERED ([ChartOfAccounts],[GLAccountID]) NOT ENFORCED
)
WITH
(
    DISTRIBUTION = REPLICATE,
    HEAP
)
GO
