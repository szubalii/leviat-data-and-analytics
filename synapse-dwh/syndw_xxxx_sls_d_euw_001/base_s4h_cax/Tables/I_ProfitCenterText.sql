CREATE TABLE [base_s4h_cax].[I_ProfitCenterText](
  [MANDT] char(3) NOT NULL -- collate Latin1_General_100_BIN2 NOT NULL
, [Language] char(1) NOT NULL -- collate Latin1_General_100_BIN2 NOT NULL
, [ControllingArea] nvarchar(4) NOT NULL
, [ProfitCenter] nvarchar(10) NOT NULL
, [ValidityEndDate] date NOT NULL
, [ValidityStartDate] date
, [ProfitCenterName] nvarchar(20)
, [ProfitCenterLongName] nvarchar(40)
, [t_applicationId]       VARCHAR (32)
, [t_jobId]               VARCHAR (36)
, [t_jobDtm]              DATETIME
, [t_jobBy]        		  NVARCHAR (128)
, [t_extractionDtm]		  DATETIME
, [t_filePath]            NVARCHAR (1024)
, CONSTRAINT [PK_I_ProfitCenterText] PRIMARY KEY NONCLUSTERED (
         [MANDT]
        ,[Language]
        ,[ControllingArea]
        ,[ProfitCenter]
        ,[ValidityEndDate]
    ) NOT ENFORCED
)
WITH (
  HEAP
)
