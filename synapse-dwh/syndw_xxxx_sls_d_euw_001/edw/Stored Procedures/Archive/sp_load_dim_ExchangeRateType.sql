CREATE PROC [edw].[sp_load_dim_ExchangeRateType]
      @t_jobId [varchar](36)
    , @t_jobDtm [datetime]
    , @t_lastActionCd [varchar](1)
    , @t_jobBy [nvarchar](128)
AS
BEGIN

    IF OBJECT_ID('syndw_xxxx_sls_d_euw_001.edw.dim_ExchangeRateType', 'U') is not null
        TRUNCATE TABLE [edw].[dim_ExchangeRateType]

    INSERT INTO [edw].[dim_ExchangeRateType](
                                              [ExchangeRateTypeID]
                                            , [ExchangeRateType]
                                            , [ReferenceCurrency]
                                            , [BuyingRateAvgExchangeRateType]
                                            , [InvertedExchangeRateIsAllowed]
                                            , [SellingRateAvgExchangeRateType]
                                            , [FixedExchangeRateIsUsed]
                                            , [SpecialConversionIsUsed]
                                            , [SourceCurrencyIsBaseCurrency]
                                            , [t_applicationId]
                                            , [t_jobId]
                                            , [t_jobDtm]
                                            , [t_lastActionCd]
                                            , [t_jobBy])
    SELECT
           ExchangeRateType.ExchangeRateType           as [ExchangeRateTypeID]
         , ExchangeRateTypeText.[ExchangeRateTypeName] as [ExchangeRateType]
         , ExchangeRateType.[ReferenceCurrency]
         , ExchangeRateType.[BuyingRateAvgExchangeRateType]
         , ExchangeRateType.[InvertedExchangeRateIsAllowed]
         , ExchangeRateType.[SellingRateAvgExchangeRateType]
         , ExchangeRateType.[FixedExchangeRateIsUsed]
         , ExchangeRateType.[SpecialConversionIsUsed]
         , ExchangeRateType.[SourceCurrencyIsBaseCurrency]
         , ExchangeRateType.[t_applicationId]
         , @t_jobId                                    AS t_jobId
         , @t_jobDtm                                   AS t_jobDtm
         , @t_lastActionCd                             AS t_lastActionCd
         , @t_jobBy                                    AS t_jobBy
    FROM [base_s4h_uat_caa].[I_ExchangeRateType] ExchangeRateType
             LEFT JOIN
         [base_s4h_uat_caa].[I_ExchangeRateTypeText] ExchangeRateTypeText
         ON
                     ExchangeRateType.[ExchangeRateType] = ExchangeRateTypeText.[ExchangeRateType]
                 AND
                     ExchangeRateTypeText.[Language] = 'E'
    where ExchangeRateType.[MANDT] = 200 and ExchangeRateTypeText.[MANDT] = 200
END