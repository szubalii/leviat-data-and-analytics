CREATE TABLE [base_s4h_cax].[I_GLAccountInChartOfAccounts](
  [TS_SEQUENCE_NUMBER] INTEGER NOT NULL
, [ODQ_CHANGEMODE] CHAR(1)
, [ODQ_ENTITYCNTR] NUMERIC(19,0)
, [MANDT] char(3) NOT NULL -- collate Latin1_General_100_BIN2 NOT NULL
, [ChartOfAccounts] nvarchar(4) NOT NULL
, [GLAccount] nvarchar(10) NOT NULL
, [IsBalanceSheetAccount] nvarchar(1)
, [GLAccountGroup] nvarchar(4)
, [CorporateGroupAccount] nvarchar(10)
, [ProfitLossAccountType] nvarchar(2)
, [SampleGLAccount] nvarchar(10)
, [AccountIsMarkedForDeletion] nvarchar(1)
, [AccountIsBlockedForCreation] nvarchar(1)
, [AccountIsBlockedForPosting] nvarchar(1)
, [AccountIsBlockedForPlanning] nvarchar(1)
, [PartnerCompany] nvarchar(6)
, [FunctionalArea] nvarchar(16)
, [CreationDate] date
, [CreatedByUser] nvarchar(12)
, [LastChangeDateTime] decimal(15)
, [GLAccountType] nvarchar(1)
, [GLAccountExternal] nvarchar(10)
, [IsProfitLossAccount] nvarchar(1)
, [t_applicationId]       VARCHAR (32)
, [t_jobId]               VARCHAR (36)
, [t_jobDtm]              DATETIME
, [t_jobBy]        		  NVARCHAR (128)
, [t_extractionDtm]		  DATETIME
, [t_filePath]            NVARCHAR (1024)
, CONSTRAINT [PK_I_GLAccountInChartOfAccounts] PRIMARY KEY NONCLUSTERED (
    [TS_SEQUENCE_NUMBER], [MANDT], [ChartOfAccounts], [GLAccount]
  ) NOT ENFORCED
)
WITH (
  HEAP
)
