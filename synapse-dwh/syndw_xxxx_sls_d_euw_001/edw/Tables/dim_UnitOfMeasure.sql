CREATE TABLE [edw].[dim_UnitOfMeasure]
(
    [UnitOfMeasureID]               NVARCHAR(4) collate Latin1_General_100_BIN2 NOT NULL,
    [UnitOfMeasure]                 NVARCHAR(40),
    [UnitOfMeasureLongName]         nvarchar(30),
    [UnitOfMeasureTechnicalName]    nvarchar(6),
    [UnitOfMeasure_E]               nvarchar(3),
    [UnitOfMeasureCommercialName]   nvarchar(3),
    [UnitOfMeasureSAPCode]          nvarchar(3),
    [UnitOfMeasureISOCode]          nvarchar(3),
    [IsPrimaryUnitForISOCode]       nvarchar(1),
    [UnitOfMeasureNumberOfDecimals] smallint,
    [UnitOfMeasureIsCommercial]     nvarchar(1),
    [UnitOfMeasureDimension]        nvarchar(6),
    [SIUnitCnvrsnRateNumerator]     int,
    [SIUnitCnvrsnRateDenominator]   int,
    [SIUnitCnvrsnRateExponent]      smallint,
    [SIUnitCnvrsnAdditiveValue]     decimal(9, 6),
    [UnitOfMeasureDspExponent]      smallint,
    [UnitOfMeasureDspNmbrOfDcmls]   smallint,
    [UnitOfMeasureTemperature]      float,
    [UnitOfMeasureTemperatureUnit]  nvarchar(3) collate Latin1_General_100_BIN2,
    [UnitOfMeasurePressure]         float,
    [UnitOfMeasurePressureUnit]     nvarchar(3) collate Latin1_General_100_BIN2,
    [t_applicationId]               VARCHAR(32)    NULL,
    [t_jobId]                       VARCHAR(36)    NULL,
    [t_jobDtm]                      DATETIME       NULL,
    [t_lastActionCd]        VARCHAR(1),
    [t_jobBy]               NVARCHAR(128),
    CONSTRAINT [PK_dim_UnitOfMeasuret] PRIMARY KEY NONCLUSTERED ([UnitOfMeasureID]) NOT ENFORCED
)
    WITH
        (
        DISTRIBUTION = REPLICATE, HEAP )
GO