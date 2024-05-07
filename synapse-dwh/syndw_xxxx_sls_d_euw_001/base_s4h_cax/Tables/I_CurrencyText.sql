CREATE TABLE [base_s4h_cax].[I_CurrencyText](
  [MANDT] char(3) NOT NULL -- collate Latin1_General_100_BIN2 NOT NULL
, [Language] char(1) NOT NULL -- collate Latin1_General_100_BIN2 NOT NULL
, [Currency] char(5) NOT NULL -- collate Latin1_General_100_BIN2 NOT NULL
, [CurrencyName] nvarchar(40)
, [CurrencyShortName] nvarchar(15)
, [t_applicationId]       VARCHAR (32)
, [t_jobId]               VARCHAR (36)
, [t_jobDtm]              DATETIME
, [t_jobBy]        		  NVARCHAR (128)
, [t_extractionDtm]		  DATETIME
, [t_filePath]            NVARCHAR (1024)
, CONSTRAINT [PK_I_CurrencyText] PRIMARY KEY NONCLUSTERED (
    [MANDT], [Language], [Currency]
  ) NOT ENFORCED
)
WITH (
  HEAP
)
