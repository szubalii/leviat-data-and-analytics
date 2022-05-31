CREATE VIEW [edw].[vw_UnitOfMeasure] AS
SELECT 
    UnitOfMeasure.[UnitOfMeasure]          AS [UnitOfMeasureID]
    ,UnitOfMeasureText.[UnitOfMeasureName] AS [UnitOfMeasure]
    ,UnitOfMeasureText.[UnitOfMeasureLongName]
    ,UnitOfMeasureText.[UnitOfMeasureTechnicalName]
    ,UnitOfMeasureText.[UnitOfMeasure_E]
    ,UnitOfMeasureText.[UnitOfMeasureCommercialName]
    ,UnitOfMeasure.[UnitOfMeasureSAPCode]
    ,UnitOfMeasure.[UnitOfMeasureISOCode]
    ,UnitOfMeasure.[IsPrimaryUnitForISOCode]
    ,UnitOfMeasure.[UnitOfMeasureNumberOfDecimals]
    ,UnitOfMeasure.[UnitOfMeasureIsCommercial]
    ,UnitOfMeasure.[UnitOfMeasureDimension]
    ,UnitOfMeasure.[SIUnitCnvrsnRateNumerator]
    ,UnitOfMeasure.[SIUnitCnvrsnRateDenominator]
    ,UnitOfMeasure.[SIUnitCnvrsnRateExponent]
    ,UnitOfMeasure.[SIUnitCnvrsnAdditiveValue]
    ,UnitOfMeasure.[UnitOfMeasureDspExponent]
    ,UnitOfMeasure.[UnitOfMeasureDspNmbrOfDcmls]
    ,UnitOfMeasure.[UnitOfMeasureTemperature]
    ,UnitOfMeasure.[UnitOfMeasureTemperatureUnit]
    ,UnitOfMeasure.[UnitOfMeasurePressure]
    ,UnitOfMeasure.[UnitOfMeasurePressureUnit]
    ,UnitOfMeasure.[t_applicationId]
    ,UnitOfMeasure.[t_extractionDtm]
FROM
    [base_s4h_cax].[I_UnitOfMeasure] UnitOfMeasure
LEFT JOIN
    [base_s4h_cax].[I_UnitOfMeasureText] UnitOfMeasureText
    ON
        UnitOfMeasure.[UnitOfMeasure] = UnitOfMeasureText.[UnitOfMeasure]
        AND
        UnitOfMeasureText.[Language] = 'E' 
--    WHERE 
--                 UnitOfMeasure.MANDT = 200 AND UnitOfMeasureText.MANDT = 200 MPS 2021/11/01: commented out due to different client values between dev,qas, and prod
