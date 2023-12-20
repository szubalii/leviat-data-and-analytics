CREATE TABLE [base_s4h_cax].[TSTCT] (
    [Sprsl] CHAR(1) NOT NULL
  , [TCode] NVARCHAR(20) NOT NULL
  , [TText] NVARCHAR(36)
  , [t_applicationId] VARCHAR (32)
  , [t_jobId] VARCHAR (36)
  , [t_jobDtm] DATETIME
  , [t_jobBy] VARCHAR (128)
  , [t_extractionDtm] DATETIME
  , [t_filePath] NVARCHAR (1024)
  , CONSTRAINT [PK_TSTCT] PRIMARY KEY NONCLUSTERED(
      [Sprsl],[TCode]
  ) NOT ENFORCED
) WITH (
  HEAP
)