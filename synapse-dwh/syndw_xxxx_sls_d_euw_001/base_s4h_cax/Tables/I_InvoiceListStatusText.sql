CREATE TABLE [base_s4h_cax].[I_InvoiceListStatusText](
  [MANDT] char(3) NOT NULL -- collate Latin1_General_100_BIN2 NOT NULL
, [InvoiceListStatus] nvarchar(1) NOT NULL
, [Language] char(1) NOT NULL -- collate Latin1_General_100_BIN2 NOT NULL
, [InvoiceListStatusDesc] nvarchar(20)
, [t_applicationId]       VARCHAR (32)
, [t_jobId]               VARCHAR (36)
, [t_jobDtm]              DATETIME
, [t_jobBy]        		  NVARCHAR (128)
, [t_extractionDtm]		  DATETIME
, [t_filePath]            NVARCHAR (1024)
, CONSTRAINT [PK_I_InvoiceListStatusText] PRIMARY KEY NONCLUSTERED (
    [MANDT], [InvoiceListStatus], [Language]
  ) NOT ENFORCED
)
WITH (
  HEAP
)
