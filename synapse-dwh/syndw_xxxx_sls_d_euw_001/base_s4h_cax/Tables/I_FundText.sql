CREATE TABLE [base_s4h_cax].[I_FundText](
  [MANDT] char(3) NOT NULL -- collate Latin1_General_100_BIN2 NOT NULL
, [FinancialManagementArea] nvarchar(4) NOT NULL
, [Fund] nvarchar(10) NOT NULL
, [Language] char(1) NOT NULL -- collate Latin1_General_100_BIN2 NOT NULL
, [FundName] nvarchar(20)
, [FundDescription] nvarchar(40)
, [t_applicationId]       VARCHAR (32)
, [t_jobId]               VARCHAR (36)
, [t_jobDtm]              DATETIME
, [t_jobBy]        		  NVARCHAR (128)
, [t_extractionDtm]		  DATETIME
, [t_filePath]            NVARCHAR (1024)
, CONSTRAINT [PK_I_FundText] PRIMARY KEY NONCLUSTERED (
    [MANDT], [FinancialManagementArea], [Fund], [Language]
  ) NOT ENFORCED
)
WITH (
  HEAP
)
