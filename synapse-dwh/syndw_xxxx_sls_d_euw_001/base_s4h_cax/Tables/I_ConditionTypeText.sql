CREATE TABLE [base_s4h_cax].[I_ConditionTypeText](
  [MANDT] char(3) NOT NULL -- collate Latin1_General_100_BIN2 NOT NULL
, [Language] char(1) NOT NULL -- collate Latin1_General_100_BIN2 NOT NULL
, [ConditionUsage] nvarchar(1) NOT NULL
, [ConditionApplication] nvarchar(2) NOT NULL
, [ConditionType] nvarchar(4) NOT NULL
, [ConditionTypeName] nvarchar(30)
, [t_applicationId]       VARCHAR (32)
, [t_jobId]               VARCHAR (36)
, [t_jobDtm]              DATETIME
, [t_jobBy]        		  NVARCHAR (128)
, [t_extractionDtm]		  DATETIME
, [t_filePath]            NVARCHAR (1024)
, CONSTRAINT [PK_I_ConditionTypeText] PRIMARY KEY NONCLUSTERED (
    [MANDT], [Language], [ConditionUsage], [ConditionApplication], [ConditionType]
  ) NOT ENFORCED
)
WITH (
  HEAP
)
