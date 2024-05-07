CREATE TABLE [base_s4h_cax].[I_FinancialTransactionTypeT](
  [MANDT] char(3) NOT NULL -- collate Latin1_General_100_BIN2 NOT NULL
, [Language] char(1) NOT NULL -- collate Latin1_General_100_BIN2 NOT NULL
, [FinancialTransactionType] nvarchar(3) NOT NULL
, [FinancialTransactionTypeName] nvarchar(20)
, [t_applicationId]       VARCHAR (32)
, [t_jobId]               VARCHAR (36)
, [t_jobDtm]              DATETIME
, [t_jobBy]        		  NVARCHAR (128)
, [t_extractionDtm]		  DATETIME
, [t_filePath]            NVARCHAR (1024)
, CONSTRAINT [PK_I_FinancialTransactionTypeT] PRIMARY KEY NONCLUSTERED (
    [MANDT], [Language], [FinancialTransactionType]
  ) NOT ENFORCED
)
WITH (
  HEAP
)
