CREATE TABLE [edw].[dim_UnitOfMeasure]
(
    [UnitOfMeasureID]               NVARCHAR(4) NOT NULL, -- collate Latin1_General_100_BIN2 NOT NULL,
    [UnitOfMeasure]                 NVARCHAR(40),
    [UnitOfMeasureLongName]         NVARCHAR(30),
    [UnitOfMeasureTechnicalName]    NVARCHAR(6),
    [UnitOfMeasure_E]               NVARCHAR(3),
    [UnitOfMeasureCommercialName]   NVARCHAR(3),
    [UnitOfMeasureSAPCode]          NVARCHAR(3),
    [UnitOfMeasureISOCode]          NVARCHAR(3),
    [IsPrimaryUnitForISOCode]       NVARCHAR(1),
    [UnitOfMeasureNumberOfDecimals] SMALLINT,
    [UnitOfMeasureIsCommercial]     NVARCHAR(1),
    [UnitOfMeasureDimension]        NVARCHAR(6),
    [SIUnitCnvrsnRateNumerator]     INT,
    [SIUnitCnvrsnRateDenominator]   INT,
    [SIUnitCnvrsnRateExponent]      SMALLINT,
    [SIUnitCnvrsnAdditiveValue]     DECIMAL(9, 6),
    [UnitOfMeasureDspExponent]      SMALLINT,
    [UnitOfMeasureDspNmbrOfDcmls]   SMALLINT,
    [UnitOfMeasureTemperature]      FLOAT,
    [UnitOfMeasureTemperatureUnit]  NVARCHAR(3), -- collate Latin1_General_100_BIN2,
    [UnitOfMeasurePressure]         FLOAT,
    [UnitOfMeasurePressureUnit]     NVARCHAR(3), -- collate Latin1_General_100_BIN2,
    [t_applicationId]               VARCHAR(32)    NULL,
    [t_extractionDtm]               DATETIME       NULL,
    [t_jobId]                       VARCHAR(36)    NULL,
    [t_jobDtm]                      DATETIME       NULL,
    [t_lastActionCd]                VARCHAR(1),
    [t_jobBy]                       NVARCHAR(128),
    CONSTRAINT [PK_dim_UnitOfMeasuret] PRIMARY KEY NONCLUSTERED ([UnitOfMeasureID]) NOT ENFORCED
)
    WITH
        (
        DISTRIBUTION = REPLICATE, HEAP )
GO