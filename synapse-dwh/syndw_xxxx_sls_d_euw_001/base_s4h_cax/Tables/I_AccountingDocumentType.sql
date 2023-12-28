CREATE TABLE [base_s4h_cax].[I_AccountingDocumentType](
  [TS_SEQUENCE_NUMBER] INTEGER NOT NULL
, [ODQ_CHANGEMODE] CHAR(1)
, [ODQ_ENTITYCNTR] NUMERIC(19,0)
, [MANDT] char(3) NOT NULL -- collate Latin1_General_100_BIN2 NOT NULL
, [AccountingDocumentType] nvarchar(2) NOT NULL
, [AccountingDocumentNumberRange] nvarchar(2)
, [AuthorizationGroup] nvarchar(4)
, [ExchangeRateType] nvarchar(4)
, [AllowedFinancialAccountTypes] nvarchar(5)
, [t_applicationId]       VARCHAR (32)
, [t_jobId]               VARCHAR (36)
, [t_jobDtm]              DATETIME
, [t_jobBy]        		  NVARCHAR (128)
, [t_extractionDtm]		  DATETIME
, [t_filePath]            NVARCHAR (1024)
, CONSTRAINT [PK_I_AccountingDocumentType] PRIMARY KEY NONCLUSTERED (
    [TS_SEQUENCE_NUMBER], [MANDT], [AccountingDocumentType]
  ) NOT ENFORCED
)
WITH (
  HEAP
)
