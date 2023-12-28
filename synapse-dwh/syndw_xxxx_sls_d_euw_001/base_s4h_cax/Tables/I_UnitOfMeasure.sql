CREATE TABLE [base_s4h_cax].[I_UnitOfMeasure](
  [MANDT] char(3) NOT NULL -- collate Latin1_General_100_BIN2 NOT NULL
, [UnitOfMeasure] nvarchar(3) NOT NULL -- collate Latin1_General_100_BIN2 NOT NULL
, [UnitOfMeasureSAPCode] nvarchar(3)
, [UnitOfMeasureISOCode] nvarchar(3)
, [IsPrimaryUnitForISOCode] nvarchar(1)
, [UnitOfMeasureNumberOfDecimals] smallint
, [UnitOfMeasureIsCommercial] nvarchar(1)
, [UnitOfMeasureDimension] nvarchar(6)
, [SIUnitCnvrsnRateNumerator] int
, [SIUnitCnvrsnRateDenominator] int
, [SIUnitCnvrsnRateExponent] smallint
, [SIUnitCnvrsnAdditiveValue] decimal(9,6)
, [UnitOfMeasureDspExponent] smallint
, [UnitOfMeasureDspNmbrOfDcmls] smallint
, [UnitOfMeasureTemperature] float
, [UnitOfMeasureTemperatureUnit] nvarchar(3) -- collate Latin1_General_100_BIN2
, [UnitOfMeasurePressure] float
, [UnitOfMeasurePressureUnit] nvarchar(3) -- collate Latin1_General_100_BIN2
, [UnitOfMeasure_E] nvarchar(3)
, [t_applicationId]       VARCHAR (32)
, [t_jobId]               VARCHAR (36)
, [t_jobDtm]              DATETIME
, [t_jobBy]        		  NVARCHAR (128)
, [t_extractionDtm]		  DATETIME
, [t_filePath]            NVARCHAR (1024)
, CONSTRAINT [PK_I_UnitOfMeasure] PRIMARY KEY NONCLUSTERED (
    [MANDT], [UnitOfMeasure]
  ) NOT ENFORCED
)
WITH (
  HEAP
)
