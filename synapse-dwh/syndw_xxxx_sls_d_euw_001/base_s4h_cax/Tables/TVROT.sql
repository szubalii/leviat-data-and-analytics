CREATE TABLE [base_s4h_cax].[TVROT](
  [MANDT]           CHAR(3) NOT NULL -- collate Latin1_General_100_BIN2 NOT NULL
, [SPRAS]			CHAR(1) NOT NULL -- collate Latin1_General_100_BIN2 NOT NULL
, [ROUTE]           NVARCHAR(6) NOT NULL
, [BEZEI]           NVARCHAR(40) NOT NULL
, [t_applicationId] VARCHAR (32)
, [t_jobId]         VARCHAR (36)
, [t_jobDtm]        DATETIME
, [t_jobBy]        	NVARCHAR (128)
, [t_extractionDtm]	DATETIME
, [t_filePath]      NVARCHAR (1024)
, CONSTRAINT [PK_TVROT] PRIMARY KEY NONCLUSTERED (
    [MANDT],[SPRAS],[ROUTE]
  ) NOT ENFORCED
)
WITH (
  HEAP
)