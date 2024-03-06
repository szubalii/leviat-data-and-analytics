CREATE TABLE [base_s4h_cax].[I_BrandText](
  [MANDT] char(3) collate Latin1_General_100_BIN2 NOT NULL
, [Brand] nvarchar(4) NOT NULL
, [Language] char(1) collate  Latin1_General_100_BIN2 NOT NULL
, [BrandName] nvarchar(30)
, CONSTRAINT [PK_I_BrandText] PRIMARY KEY NONCLUSTERED (
    [MANDT], [Brand], [Language]
  ) NOT ENFORCED
)
WITH (
  HEAP
)

ALTER TABLE
  [base_s4h_cax].[I_BrandText]
ADD
  [t_applicationId] VARCHAR   (32)
, [t_jobId]         VARCHAR   (36)
, [t_jobDtm]        DATETIME
, [t_jobBy]  		   NVARCHAR  (128)
, [t_extractionDtm]	DATETIME
, [t_filePath]     NVARCHAR (1024)