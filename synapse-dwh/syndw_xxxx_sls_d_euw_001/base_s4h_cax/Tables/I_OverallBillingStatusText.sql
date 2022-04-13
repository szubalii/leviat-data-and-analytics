CREATE TABLE [base_s4h_cax].[I_OverallBillingStatusText](
  [OverallBillingStatus] nvarchar(1) NOT NULL
, [Language] char(1) collate  Latin1_General_100_BIN2 NOT NULL
, [OverallBillingStatusDesc] nvarchar(60)
, [t_applicationId]       VARCHAR (32)
, [t_jobId]               VARCHAR (36)
, [t_jobDtm]              DATETIME
, [t_jobBy]        		  NVARCHAR (128)
, [t_extractionDtm]		  DATETIME
, [t_filePath]            NVARCHAR (1024)
, CONSTRAINT [PK_I_OverallBillingStatusText] PRIMARY KEY NONCLUSTERED (
    [OverallBillingStatus], [Language]
  ) NOT ENFORCED
)
WITH (
  HEAP
)
