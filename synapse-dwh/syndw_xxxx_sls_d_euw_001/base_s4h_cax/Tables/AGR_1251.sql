CREATE TABLE [base_s4h_cax].[AGR_1251] (
    [MANDT] CHAR(3) NOT NULL
  , [Agr_Name] NVARCHAR(30) NOT NULL
  , [Counter] NVARCHAR(6) NOT NULL
  , [Object] NVARCHAR(10)
  , [Auth] NVARCHAR(12)
  , [Variant] NVARCHAR(4)
  , [Field] NVARCHAR(10)
  , [Low] NVARCHAR(40)
  , [High] NVARCHAR(40)
  , [Modified] CHAR(1)
  , [Deleted] CHAR(1)
  , [Copied] CHAR(1)
  , [Neu] CHAR(1)
  , [Node] NVARCHAR(3)
  , [t_applicationId] VARCHAR (32)
  , [t_jobId] VARCHAR (36)
  , [t_jobDtm] DATETIME
  , [t_jobBy] VARCHAR (128)
  , [t_extractionDtm] DATETIME
  , [t_filePath] NVARCHAR (1024)
  , CONSTRAINT [PK_AGR_1251] PRIMARY KEY NONCLUSTERED(
      [MANDT],[Agr_Name],[Counter]
  ) NOT ENFORCED
) WITH (
  HEAP
)