CREATE TABLE [base_s4h_cax].[I_MaterialText](
  [MANDT] char(3) NOT NULL -- collate Latin1_General_100_BIN2 NOT NULL
, [Material] nvarchar(40) NOT NULL
, [Language] char(1) NOT NULL -- collate Latin1_General_100_BIN2 NOT NULL
, [MaterialName] nvarchar(40)
, [t_applicationId]       VARCHAR (32)
, [t_jobId]               VARCHAR (36)
, [t_jobDtm]              DATETIME
, [t_jobBy]        		  NVARCHAR (128)
, [t_extractionDtm]		  DATETIME
, [t_filePath]            NVARCHAR (1024)
, CONSTRAINT [PK_I_MaterialText] PRIMARY KEY NONCLUSTERED (
    [MANDT], [Material], [Language]
  ) NOT ENFORCED
)
WITH (
  HEAP
)
