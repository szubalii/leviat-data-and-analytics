﻿CREATE TABLE [base_s4h_cax].[AGR_DEFINE] (
    [MANDT] CHAR(3) NOT NULL
  , [Agr_Name] NVARCHAR(30) NOT NULL
  , [Parent_Agr] NVARCHAR(30)
  , [Attributes] NVARCHAR(30)
  , [t_applicationId] VARCHAR (32)
  , [t_jobId] VARCHAR (36)
  , [t_jobDtm] DATETIME
  , [t_jobBy] VARCHAR (128)
  , [t_extractionDtm] DATETIME
  , [t_filePath] NVARCHAR (1024)
  , CONSTRAINT [PK_AGR_DEFINE] PRIMARY KEY NONCLUSTERED(
      [MANDT],[Agr_Name]
  ) NOT ENFORCED
) WITH (
  HEAP
)