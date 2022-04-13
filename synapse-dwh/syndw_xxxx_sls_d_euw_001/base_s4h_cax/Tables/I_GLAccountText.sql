CREATE TABLE [base_s4h_cax].[I_GLAccountText](
  [TS_SEQUENCE_NUMBER] INTEGER NOT NULL
, [ODQ_CHANGEMODE] CHAR(1)
, [ODQ_ENTITYCNTR] NUMERIC(19,0)
, [MANDT] char(3) collate Latin1_General_100_BIN2 NOT NULL
, [ChartOfAccounts] nvarchar(4) NOT NULL
, [GLAccount] nvarchar(10) NOT NULL
, [Language] char(1) collate  Latin1_General_100_BIN2 NOT NULL
, [GLAccountName] nvarchar(20)
, [GLAccountLongName] nvarchar(50)
, [LastChangeDateTime] decimal(15)
, [t_applicationId]       VARCHAR (32)
, [t_jobId]               VARCHAR (36)
, [t_jobDtm]              DATETIME
, [t_jobBy]        		  NVARCHAR (128)
, [t_extractionDtm]		  DATETIME
, [t_filePath]            NVARCHAR (1024)
, CONSTRAINT [PK_I_GLAccountText] PRIMARY KEY NONCLUSTERED (
    [TS_SEQUENCE_NUMBER], [MANDT], [ChartOfAccounts], [GLAccount], [Language]
  ) NOT ENFORCED
)
WITH (
  HEAP
)
