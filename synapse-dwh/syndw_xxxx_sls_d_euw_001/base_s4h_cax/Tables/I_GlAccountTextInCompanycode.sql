CREATE TABLE [base_s4h_cax].[I_GlAccountTextInCompanycode](
  [MANDT] char(3) NOT NULL -- collate Latin1_General_100_BIN2 NOT NULL
, [GLAccount] nvarchar(10) NOT NULL
, [CompanyCode] nvarchar(4) NOT NULL
, [Language] char(1) NOT NULL -- collate Latin1_General_100_BIN2 NOT NULL
, [ChartOfAccounts] nvarchar(4)
, [GLAccountName] nvarchar(20)
, [GLAccountLongName] nvarchar(50)
, [t_applicationId]       VARCHAR (32)
, [t_jobId]               VARCHAR (36)
, [t_jobDtm]              DATETIME
, [t_jobBy]        		  NVARCHAR (128)
, [t_extractionDtm]		  DATETIME
, [t_filePath]            NVARCHAR (1024)
, CONSTRAINT [PK_I_GlAccountTextInCompanycode] PRIMARY KEY NONCLUSTERED (
    [MANDT], [GLAccount], [CompanyCode], [Language]
  ) NOT ENFORCED
)
WITH (
  HEAP
)
