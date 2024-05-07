CREATE TABLE [base_s4h_cax].[I_TextObjectPlainLongText](
  [MANDT] char(3) NOT NULL -- collate Latin1_General_100_BIN2 NOT NULL
, [TextObjectCategory] nvarchar(10) NOT NULL
, [TextObjectType] nvarchar(4) NOT NULL
, [TextObjectKey] nvarchar(70) NOT NULL
, [Language] char(1) NOT NULL -- collate Latin1_General_100_BIN2 NOT NULL
, [PlainLongText] varchar(max)
, [t_applicationId]       VARCHAR (32)
, [t_jobId]               VARCHAR (36)
, [t_jobDtm]              DATETIME
, [t_jobBy]        		  NVARCHAR (128)
, [t_extractionDtm]		  DATETIME
, [t_filePath]            NVARCHAR (1024)
, CONSTRAINT [PK_I_TextObjectPlainLongText] PRIMARY KEY NONCLUSTERED (
    [MANDT], [TextObjectCategory], [TextObjectType], [TextObjectKey], [Language]
  ) NOT ENFORCED
)
WITH (
  HEAP
)
