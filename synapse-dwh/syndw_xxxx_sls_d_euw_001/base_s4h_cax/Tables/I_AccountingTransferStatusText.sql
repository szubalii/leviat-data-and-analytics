CREATE TABLE [base_s4h_cax].[I_AccountingTransferStatusText](
  [AccountingTransferStatus] nvarchar(1) NOT NULL
, [Language] char(1) NOT NULL -- collate Latin1_General_100_BIN2 NOT NULL
, [AccountingTransferStatusDesc] nvarchar(60)
, [t_applicationId]       VARCHAR (32)
, [t_jobId]               VARCHAR (36)
, [t_jobDtm]              DATETIME
, [t_jobBy]        		  NVARCHAR (128)
, [t_extractionDtm]		  DATETIME
, [t_filePath]            NVARCHAR (1024)
, CONSTRAINT [PK_I_AccountingTransferStatusText] PRIMARY KEY NONCLUSTERED (
    [AccountingTransferStatus], [Language]
  ) NOT ENFORCED
)
WITH (
  HEAP
)
