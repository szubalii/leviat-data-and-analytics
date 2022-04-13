CREATE PROC [edw].[sp_load_dim_UnitOfMeasure] @t_jobId [varchar](36)
, @t_jobDtm [datetime]
, @t_lastActionCd [varchar](1)
, @t_jobBy [nvarchar](128)
AS
BEGIN

    IF OBJECT_ID('syndw_xxxx_sls_d_euw_001.edw.dim_UnitOfMeasure', 'U') is not null
        TRUNCATE TABLE [edw].[dim_UnitOfMeasure]

    INSERT INTO [edw].[dim_UnitOfMeasure]( [UnitOfMeasureID]
                                         , [UnitOfMeasure]
                                         , [UnitOfMeasureLongName]
                                         , [UnitOfMeasureTechnicalName]
                                         , [UnitOfMeasure_E]
                                         , [UnitOfMeasureCommercialName]
                                         , [UnitOfMeasureSAPCode]
                                         , [UnitOfMeasureISOCode]
                                         , [IsPrimaryUnitForISOCode]
                                         , [UnitOfMeasureNumberOfDecimals]
                                         , [UnitOfMeasureIsCommercial]
                                         , [UnitOfMeasureDimension]
                                         , [SIUnitCnvrsnRateNumerator]
                                         , [SIUnitCnvrsnRateDenominator]
                                         , [SIUnitCnvrsnRateExponent]
                                         , [SIUnitCnvrsnAdditiveValue]
                                         , [UnitOfMeasureDspExponent]
                                         , [UnitOfMeasureDspNmbrOfDcmls]
                                         , [UnitOfMeasureTemperature]
                                         , [UnitOfMeasureTemperatureUnit]
                                         , [UnitOfMeasurePressure]
                                         , [UnitOfMeasurePressureUnit]
                                         , [t_applicationId]
                                         , [t_jobId]
                                         , [t_jobDtm]
                                         , [t_lastActionCd]
                                         , [t_jobBy])
    SELECT UnitOfMeasure.[UnitOfMeasure]         as [UnitOfMeasureID]
         , UnitOfMeasureText.[UnitOfMeasureName] as [UnitOfMeasure]
         , UnitOfMeasureText.[UnitOfMeasureLongName]
         , UnitOfMeasureText.[UnitOfMeasureTechnicalName]
         , UnitOfMeasureText.[UnitOfMeasure_E]
         , UnitOfMeasureText.[UnitOfMeasureCommercialName]

         , UnitOfMeasure.[UnitOfMeasureSAPCode]
         , UnitOfMeasure.[UnitOfMeasureISOCode]
         , UnitOfMeasure.[IsPrimaryUnitForISOCode]
         , UnitOfMeasure.[UnitOfMeasureNumberOfDecimals]
         , UnitOfMeasure.[UnitOfMeasureIsCommercial]
         , UnitOfMeasure.[UnitOfMeasureDimension]
         , UnitOfMeasure.[SIUnitCnvrsnRateNumerator]
         , UnitOfMeasure.[SIUnitCnvrsnRateDenominator]
         , UnitOfMeasure.[SIUnitCnvrsnRateExponent]
         , UnitOfMeasure.[SIUnitCnvrsnAdditiveValue]
         , UnitOfMeasure.[UnitOfMeasureDspExponent]
         , UnitOfMeasure.[UnitOfMeasureDspNmbrOfDcmls]
         , UnitOfMeasure.[UnitOfMeasureTemperature]
         , UnitOfMeasure.[UnitOfMeasureTemperatureUnit]
         , UnitOfMeasure.[UnitOfMeasurePressure]
         , UnitOfMeasure.[UnitOfMeasurePressureUnit]
         , UnitOfMeasure.t_applicationId
         , @t_jobId                              AS t_jobId
         , @t_jobDtm                             AS t_jobDtm
         , @t_lastActionCd                       AS t_lastActionCd
         , @t_jobBy                              AS t_jobBy
    FROM [base_s4h_uat_caa].[I_UnitOfMeasure] UnitOfMeasure
    LEFT JOIN [base_s4h_uat_caa].[I_UnitOfMeasureText] UnitOfMeasureText ON
                UnitOfMeasure.[UnitOfMeasure] = UnitOfMeasureText.[UnitOfMeasure]
            AND
                UnitOfMeasureText.[Language] = 'E' 
   where 
                UnitOfMeasure.MANDT = 200 and UnitOfMeasureText.MANDT = 200
    
END