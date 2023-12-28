CREATE TABLE [base_s4h_cax].[I_BusinessProcessText](
  [MANDT] char(3) NOT NULL -- collate Latin1_General_100_BIN2 NOT NULL
, [ControllingArea] nvarchar(4) NOT NULL
, [BusinessProcess] nvarchar(12) NOT NULL
, [Language] char(1) NOT NULL -- collate Latin1_General_100_BIN2 NOT NULL
, [ValidityEndDate] date NOT NULL
, [BusinessProcessName] nvarchar(20)
, [BusinessProcessDescription] nvarchar(40)
, [t_applicationId]       VARCHAR (32)
, [t_jobId]               VARCHAR (36)
, [t_jobDtm]              DATETIME
, [t_jobBy]        		  NVARCHAR (128)
, [t_extractionDtm]		  DATETIME
, [t_filePath]            NVARCHAR (1024)
, CONSTRAINT [PK_I_BusinessProcessText] PRIMARY KEY NONCLUSTERED (
    [MANDT], [ControllingArea], [BusinessProcess], [Language], [ValidityEndDate]
  ) NOT ENFORCED
)
WITH (
  HEAP
)
