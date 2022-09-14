CREATE TABLE [base_s4h_cax].[I_BankAccountText]
-- Bank Account Description
(
  [MANDT] nchar(3) collate Latin1_General_100_BIN2 NOT NULL
, [BankAccountInternalID] char(10) collate Latin1_General_100_BIN2 NOT NULL
, [Language] nchar(1) collate  Latin1_General_100_BIN2 NOT NULL
, [BankAccountDescription] nvarchar(60) collate Latin1_General_100_BIN2
, [t_applicationId]       VARCHAR (32)
, [t_jobId]               VARCHAR (36)
, [t_lastDtm]             DATETIME
, [t_lastActionBy]        VARCHAR (20)
, [t_filePath]            NVARCHAR (1024)
, [t_extractionDtm]             DATETIME
, CONSTRAINT [PK_I_BankAccountText] PRIMARY KEY NONCLUSTERED([MANDT],[BankAccountInternalID],[Language]) NOT ENFORCED 
)
WITH ( 
  HEAP
)
