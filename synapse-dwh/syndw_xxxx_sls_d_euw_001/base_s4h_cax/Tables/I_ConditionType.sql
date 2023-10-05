CREATE TABLE [base_s4h_cax].[I_ConditionType](
  [MANDT] char(3) NOT NULL -- collate Latin1_General_100_BIN2 NOT NULL
, [ConditionUsage] nvarchar(1) NOT NULL
, [ConditionApplication] nvarchar(2) NOT NULL
, [ConditionType] nvarchar(4) NOT NULL
, [t_applicationId]       VARCHAR (32)
, [t_jobId]               VARCHAR (36)
, [t_jobDtm]              DATETIME
, [t_jobBy]        		  NVARCHAR (128)
, [t_extractionDtm]		  DATETIME
, [t_filePath]            NVARCHAR (1024)
, CONSTRAINT [PK_I_ConditionType] PRIMARY KEY NONCLUSTERED (
    [MANDT], [ConditionUsage], [ConditionApplication], [ConditionType]
  ) NOT ENFORCED
)
WITH (
  HEAP
)
