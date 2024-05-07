CREATE TABLE [base_s4h_cax].[I_PostingKey](
  [TS_SEQUENCE_NUMBER] INTEGER NOT NULL
, [ODQ_CHANGEMODE] CHAR(1)
, [ODQ_ENTITYCNTR] NUMERIC(19,0)
, [MANDT] char(3) NOT NULL -- collate Latin1_General_100_BIN2 NOT NULL
, [PostingKey] nvarchar(2) NOT NULL
, [DebitCreditCode] nvarchar(1)
, [FinancialAccountType] nvarchar(1)
, [IsSalesRelated] nvarchar(1)
, [IsUsedInPaymentTransaction] nvarchar(1)
, [ReversalPostingKey] nvarchar(2)
, [IsSpecialGLTransaction] nvarchar(1)
, [t_applicationId]       VARCHAR (32)
, [t_jobId]               VARCHAR (36)
, [t_jobDtm]              DATETIME
, [t_jobBy]        		  NVARCHAR (128)
, [t_extractionDtm]		  DATETIME
, [t_filePath]            NVARCHAR (1024)
, CONSTRAINT [PK_I_PostingKey] PRIMARY KEY NONCLUSTERED (
    [TS_SEQUENCE_NUMBER], [MANDT], [PostingKey]
  ) NOT ENFORCED
)
WITH (
  HEAP
)
