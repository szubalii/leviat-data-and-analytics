CREATE TABLE [base_s4h_cax].[I_PackingStatusText]
-- Packing Status Text
(
  [MANDT] char(3) NOT NULL -- collate Latin1_General_100_BIN2 NOT NULL
, [PackingStatus] nvarchar(1) NOT NULL
, [Language] char(1) NOT NULL -- collate Latin1_General_100_BIN2 NOT NULL
, [PackingStatusDesc] nvarchar(20)
, [t_applicationId]       VARCHAR (32)
, [t_jobId]               VARCHAR (36)
, [t_jobDtm]              DATETIME
, [t_jobBy]        		  NVARCHAR (128)
, [t_extractionDtm]		  DATETIME
, [t_filePath]            NVARCHAR (1024)
, CONSTRAINT [PK_I_PackingStatusText] PRIMARY KEY NONCLUSTERED([MANDT],[PackingStatus],[Language]) NOT ENFORCED 
)
WITH ( 
  HEAP
)
