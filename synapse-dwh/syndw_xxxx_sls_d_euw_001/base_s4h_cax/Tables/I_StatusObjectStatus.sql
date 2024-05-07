CREATE TABLE [base_s4h_cax].[I_StatusObjectStatus](
  [MANDT] nchar(3) NOT NULL -- collate Latin1_General_100_BIN2 NOT NULL
, [StatusObject] nvarchar(22) NOT NULL -- collate Latin1_General_100_BIN2 NOT NULL
, [StatusCode] nvarchar(5) NOT NULL -- collate Latin1_General_100_BIN2 NOT NULL
, [StatusProfile] nvarchar(8) -- collate Latin1_General_100_BIN2
, [IsUserStatus] nvarchar(1) -- collate Latin1_General_100_BIN2
, [StatusIsActive] nvarchar(1) -- collate Latin1_General_100_BIN2
, [StatusIsInactive] nvarchar(1) -- collate Latin1_General_100_BIN2
, [t_applicationId]       VARCHAR (32)
, [t_jobId]               VARCHAR (36)
, [t_jobDtm]              DATETIME
, [t_jobBy]        		  NVARCHAR (128)
, [t_extractionDtm]		  DATETIME
, [t_filePath]            NVARCHAR (1024)
, CONSTRAINT [PK_I_StatusObjectStatus] PRIMARY KEY NONCLUSTERED (
    [MANDT], [StatusObject], [StatusCode]
  ) NOT ENFORCED
)
WITH (
  HEAP
)
