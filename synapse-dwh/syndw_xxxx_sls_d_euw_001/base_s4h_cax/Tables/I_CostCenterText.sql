CREATE TABLE [base_s4h_cax].[I_CostCenterText](
  [MANDT] char(3) NOT NULL -- collate Latin1_General_100_BIN2 NOT NULL
, [CostCenter] nvarchar(10) NOT NULL
, [ControllingArea] nvarchar(4) NOT NULL
, [Language] char(1) NOT NULL -- collate Latin1_General_100_BIN2 NOT NULL
, [ValidityEndDate] date NOT NULL
, [ValidityStartDate] date
, [CostCenterName] nvarchar(20)
, [CostCenterDescription] nvarchar(40)
, [t_applicationId]       VARCHAR (32)
, [t_jobId]               VARCHAR (36)
, [t_jobDtm]              DATETIME
, [t_jobBy]        		  NVARCHAR (128)
, [t_extractionDtm]		  DATETIME
, [t_filePath]            NVARCHAR (1024)
, CONSTRAINT [PK_I_CostCenterText] PRIMARY KEY NONCLUSTERED (
    [MANDT], [CostCenter], [ControllingArea], [Language], [ValidityEndDate]
  ) NOT ENFORCED
)
WITH (
  HEAP
)
