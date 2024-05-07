CREATE TABLE [base_s4h_cax].[I_CreditControlAreaText](
  [MANDT] char(3) NOT NULL -- collate Latin1_General_100_BIN2 NOT NULL
, [CreditControlArea] nvarchar(4) NOT NULL
, [Language] char(1) NOT NULL -- collate Latin1_General_100_BIN2 NOT NULL
, [CreditControlAreaName] nvarchar(35)
, [t_applicationId]       VARCHAR (32)
, [t_jobId]               VARCHAR (36)
, [t_jobDtm]              DATETIME
, [t_jobBy]        		  NVARCHAR (128)
, [t_extractionDtm]		  DATETIME
, [t_filePath]            NVARCHAR (1024)
, CONSTRAINT [PK_I_CreditControlAreaText] PRIMARY KEY NONCLUSTERED (
    [MANDT], [CreditControlArea], [Language]
  ) NOT ENFORCED
)
WITH (
  HEAP
)
