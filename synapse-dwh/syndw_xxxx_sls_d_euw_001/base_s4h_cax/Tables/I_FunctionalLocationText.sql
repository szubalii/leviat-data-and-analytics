CREATE TABLE [base_s4h_cax].[I_FunctionalLocationText](
  [MANDT] char(3) NOT NULL -- collate Latin1_General_100_BIN2 NOT NULL
, [FunctionalLocation] nvarchar(30) NOT NULL
, [Language] char(1) NOT NULL -- collate Latin1_General_100_BIN2 NOT NULL
, [FunctionalLocationName] nvarchar(40)
, [IsPrimaryLanguage] nvarchar(1)
, [FuncnlLocHasLongText] nvarchar(1)
, [LastChangeDateTime] decimal(15)
, [t_applicationId]       VARCHAR (32)
, [t_jobId]               VARCHAR (36)
, [t_jobDtm]              DATETIME
, [t_jobBy]        		  NVARCHAR (128)
, [t_extractionDtm]		  DATETIME
, [t_filePath]            NVARCHAR (1024)
, CONSTRAINT [PK_I_FunctionalLocationText] PRIMARY KEY NONCLUSTERED (
    [MANDT], [FunctionalLocation], [Language]
  ) NOT ENFORCED
)
WITH (
  HEAP
)
