CREATE TABLE [base_s4h_cax].[I_UnitOfMeasureText](
  [MANDT] char(3) NOT NULL -- collate Latin1_General_100_BIN2 NOT NULL
, [Language] char(1) NOT NULL -- collate Latin1_General_100_BIN2 NOT NULL
, [UnitOfMeasure] nvarchar(3) NOT NULL -- collate Latin1_General_100_BIN2 NOT NULL
, [UnitOfMeasureLongName] nvarchar(30)
, [UnitOfMeasureName] nvarchar(10)
, [UnitOfMeasureTechnicalName] nvarchar(6)
, [UnitOfMeasure_E] nvarchar(3)
, [UnitOfMeasureCommercialName] nvarchar(3)
, [t_applicationId]       VARCHAR (32)
, [t_jobId]               VARCHAR (36)
, [t_jobDtm]              DATETIME
, [t_jobBy]        		  NVARCHAR (128)
, [t_extractionDtm]		  DATETIME
, [t_filePath]            NVARCHAR (1024)
, CONSTRAINT [PK_I_UnitOfMeasureText] PRIMARY KEY NONCLUSTERED (
    [MANDT], [Language], [UnitOfMeasure]
  ) NOT ENFORCED
)
WITH (
  HEAP
)
