CREATE TABLE [base_s4h_cax].[I_MaterialGroupText](
  [MANDT] char(3) NOT NULL -- collate Latin1_General_100_BIN2 NOT NULL
, [MaterialGroup] nvarchar(9) NOT NULL
, [Language] char(1) NOT NULL -- collate Latin1_General_100_BIN2 NOT NULL
, [MaterialGroupName] nvarchar(20)
, [MaterialGroupText] nvarchar(60)
, [t_applicationId]       VARCHAR (32)
, [t_jobId]               VARCHAR (36)
, [t_jobDtm]              DATETIME
, [t_jobBy]        		  NVARCHAR (128)
, [t_extractionDtm]		  DATETIME
, [t_filePath]            NVARCHAR (1024)
, CONSTRAINT [PK_I_MaterialGroupText] PRIMARY KEY NONCLUSTERED (
    [MANDT], [MaterialGroup], [Language]
  ) NOT ENFORCED
)
WITH (
  HEAP
)
