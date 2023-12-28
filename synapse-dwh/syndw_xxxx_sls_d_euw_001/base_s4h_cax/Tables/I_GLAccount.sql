CREATE TABLE [base_s4h_cax].[I_GLAccount](
  [MANDT] char(3) NOT NULL -- collate Latin1_General_100_BIN2 NOT NULL
, [GLAccount] nvarchar(10) NOT NULL
, [CompanyCode] nvarchar(4) NOT NULL
, [ChartOfAccounts] nvarchar(4)
, [GLAccountGroup] nvarchar(4)
, [CorporateGroupAccount] nvarchar(10)
, [AccountIsBlockedForPosting] nvarchar(1)
, [AccountIsBlockedForPlanning] nvarchar(1)
, [AccountIsBlockedForCreation] nvarchar(1)
, [IsBalanceSheetAccount] nvarchar(1)
, [AccountIsMarkedForDeletion] nvarchar(1)
, [PartnerCompany] nvarchar(6)
, [FunctionalArea] nvarchar(16)
, [CreationDate] date
, [SampleGLAccount] nvarchar(10)
, [IsProfitLossAccount] nvarchar(1)
, [CreatedByUser] nvarchar(12)
, [ProfitLossAccountType] nvarchar(2)
, [ReconciliationAccountType] nvarchar(1)
, [LineItemDisplayIsEnabled] nvarchar(1)
, [IsOpenItemManaged] nvarchar(1)
, [AlternativeGLAccount] nvarchar(10)
, [AcctgDocItmDisplaySequenceRule] nvarchar(3)
, [GLAccountExternal] nvarchar(10)
, [CountryChartOfAccounts] nvarchar(4)
, [AuthorizationGroup] nvarchar(4)
, [t_applicationId]       VARCHAR (32)
, [t_jobId]               VARCHAR (36)
, [t_jobDtm]              DATETIME
, [t_jobBy]        		  NVARCHAR (128)
, [t_extractionDtm]		  DATETIME
, [t_filePath]            NVARCHAR (1024)
, CONSTRAINT [PK_I_GLAccount] PRIMARY KEY NONCLUSTERED (
    [MANDT], [GLAccount], [CompanyCode]
  ) NOT ENFORCED
)
WITH (
  HEAP
)
