CREATE TABLE [base_s4h_cax].[I_MaterialDocumentHeader](
  [MANDT] nchar(3) NOT NULL -- collate Latin1_General_100_BIN2 NOT NULL
, [MaterialDocumentYear] char(4) NOT NULL -- collate Latin1_General_100_BIN2 NOT NULL
, [MaterialDocument] nvarchar(10) NOT NULL -- collate Latin1_General_100_BIN2 NOT NULL
, [DocumentDate] date
, [PostingDate] date
, [AccountingDocumentType] nvarchar(2) -- collate Latin1_General_100_BIN2
, [InventoryTransactionType] nvarchar(2) -- collate Latin1_General_100_BIN2
, [CreatedByUser] nvarchar(12) -- collate Latin1_General_100_BIN2
, [CreationDate] date
, [CreationTime] time(0)
, [MaterialDocumentHeaderText] nvarchar(25) -- collate Latin1_General_100_BIN2
, [DeliveryDocument] nvarchar(10) -- collate Latin1_General_100_BIN2
, [ReferenceDocument] nvarchar(16) -- collate Latin1_General_100_BIN2
, [BillOfLading] nvarchar(16) -- collate Latin1_General_100_BIN2
, [t_applicationId]       VARCHAR (32)
, [t_jobId]               VARCHAR (36)
, [t_jobDtm]              DATETIME
, [t_jobBy]               VARCHAR (128)
, [t_extractionDtm]       VARCHAR (128)
, [t_filePath]            NVARCHAR (1024)
, CONSTRAINT [PK_I_MaterialDocumentHeader] PRIMARY KEY NONCLUSTERED (
    [MANDT], [MaterialDocumentYear], [MaterialDocument]
  ) NOT ENFORCED
)
WITH (
  HEAP, DISTRIBUTION = REPLICATE
)
