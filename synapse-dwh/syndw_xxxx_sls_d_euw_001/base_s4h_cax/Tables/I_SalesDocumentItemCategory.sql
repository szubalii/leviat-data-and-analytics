CREATE TABLE [base_s4h_cax].[I_SalesDocumentItemCategory](
  [MANDT] char(3) NOT NULL -- collate Latin1_General_100_BIN2 NOT NULL
, [SalesDocumentItemCategory] nvarchar(4) NOT NULL
, [ScheduleLineIsAllowed] nvarchar(1)
, [t_applicationId]       VARCHAR (32)
, [t_jobId]               VARCHAR (36)
, [t_jobDtm]              DATETIME
, [t_jobBy]        		  NVARCHAR (128)
, [t_extractionDtm]		  DATETIME
, [t_filePath]            NVARCHAR (1024)
, CONSTRAINT [PK_I_SalesDocumentItemCategory] PRIMARY KEY NONCLUSTERED (
    [MANDT], [SalesDocumentItemCategory]
  ) NOT ENFORCED
)
WITH (
  HEAP
)
