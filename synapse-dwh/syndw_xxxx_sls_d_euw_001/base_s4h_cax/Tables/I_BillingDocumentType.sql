CREATE TABLE [base_s4h_cax].[I_BillingDocumentType](
  [MANDT] char(3) NOT NULL -- collate Latin1_General_100_BIN2 NOT NULL
, [BillingDocumentType] nvarchar(4) NOT NULL
, [SDDocumentCategory] nvarchar(4)
, [IncrementItemNumber] char(6) -- collate Latin1_General_100_BIN2
, [BillingDocumentCategory] nvarchar(1)
, [t_applicationId]       VARCHAR (32)
, [t_jobId]               VARCHAR (36)
, [t_jobDtm]              DATETIME
, [t_jobBy]        		  NVARCHAR (128)
, [t_extractionDtm]		  DATETIME
, [t_filePath]            NVARCHAR (1024)
, CONSTRAINT [PK_I_BillingDocumentType] PRIMARY KEY NONCLUSTERED (
    [MANDT], [BillingDocumentType]
  ) NOT ENFORCED
)
WITH (
  HEAP
)
