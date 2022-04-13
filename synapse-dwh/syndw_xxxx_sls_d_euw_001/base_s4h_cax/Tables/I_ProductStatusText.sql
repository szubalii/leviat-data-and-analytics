CREATE TABLE [base_s4h_cax].[I_ProductStatusText](
  [MANDT] char(3) collate Latin1_General_100_BIN2 NOT NULL
, [Status] nvarchar(2) NOT NULL
, [Language] char(1) collate  Latin1_General_100_BIN2 NOT NULL
, [MaterialUsabilityProfileName] nvarchar(25)
, [t_applicationId]       VARCHAR (32)
, [t_jobId]               VARCHAR (36)
, [t_jobDtm]              DATETIME
, [t_jobBy]        		  NVARCHAR (128)
, [t_extractionDtm]		  DATETIME
, [t_filePath]            NVARCHAR (1024)
, CONSTRAINT [PK_I_ProductStatusText] PRIMARY KEY NONCLUSTERED (
    [MANDT], [Status], [Language]
  ) NOT ENFORCED
)
WITH (
  HEAP
)
