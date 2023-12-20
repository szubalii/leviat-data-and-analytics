CREATE TABLE [base_s4h_cax].[AGR_TEXTS] (
    [MANDT] CHAR(3) NOT NULL
  , [Agr_Name] NVARCHAR(30) NOT NULL
  , [Spras] CHAR(1) NOT NULL
  , [Line] NVARCHAR(5) NOT NULL
  , [Text] NVARCHAR(80)
  , [t_applicationId] VARCHAR (32)
  , [t_jobId] VARCHAR (36)
  , [t_jobDtm] DATETIME
  , [t_jobBy] VARCHAR (128)
  , [t_extractionDtm] DATETIME
  , [t_filePath] NVARCHAR (1024)
  , CONSTRAINT [PK_AGR_TEXTS] PRIMARY KEY NONCLUSTERED(
      [MANDT],[Agr_Name],[Spras],[Line]
  ) NOT ENFORCED
) WITH (
  HEAP
)