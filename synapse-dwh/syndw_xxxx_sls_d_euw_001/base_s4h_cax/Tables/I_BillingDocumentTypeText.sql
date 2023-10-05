CREATE TABLE [base_s4h_cax].[I_BillingDocumentTypeText](
  [MANDT] char(3) NOT NULL -- collate Latin1_General_100_BIN2 NOT NULL
, [BillingDocumentType] nvarchar(4) NOT NULL
, [Language] char(1) NOT NULL -- collate Latin1_General_100_BIN2 NOT NULL
, [BillingDocumentTypeName] nvarchar(40)
, [t_applicationId]       VARCHAR (32)
, [t_jobId]               VARCHAR (36)
, [t_jobDtm]              DATETIME
, [t_jobBy]        		  NVARCHAR (128)
, [t_extractionDtm]		  DATETIME
, [t_filePath]            NVARCHAR (1024)
, CONSTRAINT [PK_I_BillingDocumentTypeText] PRIMARY KEY NONCLUSTERED (
    [MANDT], [BillingDocumentType], [Language]
  ) NOT ENFORCED
)
WITH (
  HEAP
)
