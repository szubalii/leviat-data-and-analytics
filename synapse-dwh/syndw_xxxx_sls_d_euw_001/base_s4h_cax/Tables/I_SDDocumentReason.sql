CREATE TABLE [base_s4h_cax].[I_SDDocumentReason](
  [MANDT] char(3) NOT NULL -- collate Latin1_General_100_BIN2 NOT NULL
, [SDDocumentReason] nvarchar(3) NOT NULL
, [t_applicationId]       VARCHAR (32)
, [t_jobId]               VARCHAR (36)
, [t_jobDtm]              DATETIME
, [t_jobBy]        		  NVARCHAR (128)
, [t_extractionDtm]		  DATETIME
, [t_filePath]            NVARCHAR (1024)
, CONSTRAINT [PK_I_SDDocumentReason] PRIMARY KEY NONCLUSTERED (
    [MANDT], [SDDocumentReason]
  ) NOT ENFORCED
)
WITH (
  HEAP
)
