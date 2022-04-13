CREATE TABLE [base_s4h_cax].[I_AdditionalMaterialGroup2Text](
  [MANDT] char(3) collate Latin1_General_100_BIN2 NOT NULL
, [AdditionalMaterialGroup2] nvarchar(3) NOT NULL
, [Language] char(1) collate  Latin1_General_100_BIN2 NOT NULL
, [AdditionalMaterialGroup2Name] nvarchar(40)
, [t_applicationId]       VARCHAR (32)
, [t_jobId]               VARCHAR (36)
, [t_jobDtm]              DATETIME
, [t_jobBy]        		  NVARCHAR (128)
, [t_extractionDtm]		  DATETIME
, [t_filePath]            NVARCHAR (1024)
, CONSTRAINT [PK_I_AdditionalMaterialGroup2Text] PRIMARY KEY NONCLUSTERED (
    [MANDT], [AdditionalMaterialGroup2], [Language]
  ) NOT ENFORCED
)
WITH (
  HEAP
)
