CREATE TABLE [base_s4h_cax].[I_CentralCreditCheckStatusText](
  [MANDT] char(3) NOT NULL -- collate Latin1_General_100_BIN2 NOT NULL
, [CentralCreditCheckStatus] nvarchar(1) NOT NULL
, [Language] char(1) NOT NULL -- collate Latin1_General_100_BIN2 NOT NULL
, [CentralCreditCheckStatusDesc] nvarchar(20)
, [t_applicationId]       VARCHAR (32)
, [t_jobId]               VARCHAR (36)
, [t_jobDtm]              DATETIME
, [t_jobBy]        		  NVARCHAR (128)
, [t_extractionDtm]		  DATETIME
, [t_filePath]            NVARCHAR (1024)
, CONSTRAINT [PK_I_CentralCreditCheckStatusText] PRIMARY KEY NONCLUSTERED (
    [MANDT], [CentralCreditCheckStatus], [Language]
  ) NOT ENFORCED
)
WITH (
  HEAP
)
