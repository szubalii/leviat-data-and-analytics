CREATE TABLE [base_s4h_cax].[I_HdrDelivIncompletionStatusT](
  [MANDT] char(3) NOT NULL -- collate Latin1_General_100_BIN2 NOT NULL
, [HeaderDelivIncompletionStatus] nvarchar(1) NOT NULL
, [Language] char(1) NOT NULL -- collate Latin1_General_100_BIN2 NOT NULL
, [HdrDelivIncompletionStatusDesc] nvarchar(20)
, [t_applicationId]       VARCHAR (32)
, [t_jobId]               VARCHAR (36)
, [t_jobDtm]              DATETIME
, [t_jobBy]        		  NVARCHAR (128)
, [t_extractionDtm]		  DATETIME
, [t_filePath]            NVARCHAR (1024)
, CONSTRAINT [PK_I_HdrDelivIncompletionStatusT] PRIMARY KEY NONCLUSTERED (
    [MANDT], [HeaderDelivIncompletionStatus], [Language]
  ) NOT ENFORCED
)
WITH (
  HEAP
)
