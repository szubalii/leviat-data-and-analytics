CREATE TABLE [base_s4h_cax].[I_ServiceDocumentTypeText](
  [MANDT] char(3) NOT NULL -- collate Latin1_General_100_BIN2 NOT NULL
, [ServiceDocumentType] nvarchar(4) NOT NULL
, [Language] char(1) NOT NULL -- collate Latin1_General_100_BIN2 NOT NULL
, [ServiceDocumentTypeName] nvarchar(40)
, [t_applicationId]       VARCHAR (32)
, [t_jobId]               VARCHAR (36)
, [t_jobDtm]              DATETIME
, [t_jobBy]        		  NVARCHAR (128)
, [t_extractionDtm]		  DATETIME
, [t_filePath]            NVARCHAR (1024)
, CONSTRAINT [PK_I_ServiceDocumentTypeText] PRIMARY KEY NONCLUSTERED (
    [MANDT], [ServiceDocumentType], [Language]
  ) NOT ENFORCED
)
WITH (
  HEAP
)
