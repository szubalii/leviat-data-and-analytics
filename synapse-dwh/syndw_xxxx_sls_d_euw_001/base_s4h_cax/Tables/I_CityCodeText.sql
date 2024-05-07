CREATE TABLE [base_s4h_cax].[I_CityCodeText](
  [MANDT] char(3) NOT NULL -- collate Latin1_General_100_BIN2 NOT NULL
, [Region] nvarchar(3) NOT NULL
, [Country] nvarchar(3) NOT NULL
, [CityCode] nvarchar(4) NOT NULL
, [Language] char(1) NOT NULL -- collate Latin1_General_100_BIN2 NOT NULL
, [CityCodeName] nvarchar(20)
, [t_applicationId]       VARCHAR (32)
, [t_jobId]               VARCHAR (36)
, [t_jobDtm]              DATETIME
, [t_jobBy]        		  NVARCHAR (128)
, [t_extractionDtm]		  DATETIME
, [t_filePath]            NVARCHAR (1024)
, CONSTRAINT [PK_I_CityCodeText] PRIMARY KEY NONCLUSTERED (
    [MANDT], [Region], [Country], [CityCode], [Language]
  ) NOT ENFORCED
)
WITH (
  HEAP
)
