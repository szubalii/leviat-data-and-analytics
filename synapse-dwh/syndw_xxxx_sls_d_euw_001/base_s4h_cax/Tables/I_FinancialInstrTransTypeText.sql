CREATE TABLE [base_s4h_cax].[I_FinancialInstrTransTypeText] (
-- Transaction Type Text
  [MANDT]                           char(3) NOT NULL -- collate Latin1_General_100_BIN2 NOT NULL
, [Language]                        char(1) NOT NULL -- collate Latin1_General_100_BIN2 NOT NULL
, [FinancialInstrumentProductType]  nvarchar(6) NOT NULL
, [FinancialInstrTransactionType]   nvarchar(6) NOT NULL
, [FinancialInstrTransTypeName]     nvarchar(60)
, [t_applicationId]                 VARCHAR (32)
, [t_jobId]                         VARCHAR (36)
, [t_jobDtm]                        DATETIME
, [t_jobBy]        		              NVARCHAR (128)
, [t_extractionDtm]		              DATETIME
, [t_filePath]                      NVARCHAR (1024)
    CONSTRAINT [PK_I_FinancialInstrTransTypeText] 
      PRIMARY KEY NONCLUSTERED ([Language],[FinancialInstrumentProductType],[FinancialInstrTransactionType]) NOT ENFORCED
)
WITH
(
    DISTRIBUTION = ROUND_ROBIN,
    HEAP
)
GO