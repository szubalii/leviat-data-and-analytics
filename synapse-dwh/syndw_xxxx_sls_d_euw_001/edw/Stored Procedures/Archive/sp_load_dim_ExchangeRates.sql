CREATE PROC [edw].[sp_load_dim_ExchangeRates]
     @t_jobId [varchar](36)
    ,@t_jobDtm [datetime]
    ,@t_lastActionCd [varchar](1)
    ,@t_jobBy [nvarchar](128) 
AS
BEGIN

    IF OBJECT_ID('syndw_xxxx_sls_d_euw_001.edw.dim_ExchangeRates', 'U') is not null TRUNCATE TABLE [edw].[dim_ExchangeRates]

    INSERT INTO [edw].[dim_ExchangeRates](
       [ExchangeRateType]
      ,[SourceCurrency]
      ,[TargetCurrency]
      ,[ExchangeRateEffectiveDate]
      ,[ExchangeRate]
      ,[NumberOfSourceCurrencyUnits]
      ,[NumberOfTargetCurrencyUnits]
      ,[AlternativeExchangeRateType]
      ,[AltvExchangeRateTypeValdtyDate]
      ,[InvertedExchangeRateIsAllowed]
      ,[ReferenceCurrency]
      ,[BuyingRateAvgExchangeRateType]
      ,[SellingRateAvgExchangeRateType]
      ,[FixedExchangeRateIsUsed]
      ,[SpecialConversionIsUsed]
      ,[SourceCurrencyDecimals]
      ,[TargetCurrencyDecimals]
      ,[ExchRateIsIndirectQuotation]
      ,[AbsoluteExchangeRate]
      ,[EffectiveExchangeRate]
      ,[DirectQuotedEffectiveExchRate]
      ,[IndirectQuotedEffctvExchRate]
      ,[t_applicationId]
      ,[t_jobId]
      ,[t_jobDtm]
      ,[t_lastActionCd]
      ,[t_jobBy]
    )
    SELECT 
       [ExchangeRateType]
      ,[SourceCurrency]
      ,[TargetCurrency]
      ,[ExchangeRateEffectiveDate]
      ,[ExchangeRate]
      ,[NumberOfSourceCurrencyUnits]
      ,[NumberOfTargetCurrencyUnits]
      ,[AlternativeExchangeRateType]
      ,[AltvExchangeRateTypeValdtyDate]
      ,[InvertedExchangeRateIsAllowed]
      ,[ReferenceCurrency]
      ,[BuyingRateAvgExchangeRateType]
      ,[SellingRateAvgExchangeRateType]
      ,[FixedExchangeRateIsUsed]
      ,[SpecialConversionIsUsed]
      ,[SourceCurrencyDecimals]
      ,[TargetCurrencyDecimals]
      ,[ExchRateIsIndirectQuotation]
      ,[AbsoluteExchangeRate]
      ,[EffectiveExchangeRate]
      ,[DirectQuotedEffectiveExchRate]
      ,[IndirectQuotedEffctvExchRate]
      ,[t_applicationId]
      ,@t_jobId AS t_jobId
      ,@t_jobDtm AS t_jobDtm
      ,@t_lastActionCd AS t_lastActionCd
      ,@t_jobBy AS t_jobBy
    FROM 
        [base_s4h_uat_caa].[I_ExchangeRate]
    where [MANDT] = 200
  UNION ALL
  SELECT
      'ZAXBIBUD' as [ExchangeRateType]
      ,[CURRENCY] collate SQL_Latin1_General_CP1_CS_AS as [SourceCurrency]
	  ,'EUR' as [TargetCurrency]
      ,CONVERT(date, (CAST([YEAR] as VARCHAR)), 112) as [ExchangeRateEffectiveDate]
      ,[CRHRATE] as [ExchangeRate]
      ,null as [NumberOfSourceCurrencyUnits]
      ,null as [NumberOfTargetCurrencyUnits]
      ,null as [AlternativeExchangeRateType]
      ,null as [AltvExchangeRateTypeValdtyDate]
      ,null as [InvertedExchangeRateIsAllowed]
      ,null as [ReferenceCurrency]
      ,null as [BuyingRateAvgExchangeRateType]
      ,null as [SellingRateAvgExchangeRateType]
      ,null as [FixedExchangeRateIsUsed]
      ,null as [SpecialConversionIsUsed]
      ,null as [SourceCurrencyDecimals]
      ,null as [TargetCurrencyDecimals]
      ,null as [ExchRateIsIndirectQuotation]
      ,null as [AbsoluteExchangeRate]
      ,null as [EffectiveExchangeRate]
      ,null as [DirectQuotedEffectiveExchRate]
      ,null as [IndirectQuotedEffctvExchRate]
      ,[t_applicationId]
      ,@t_jobId AS t_jobId
      ,@t_jobDtm AS t_jobDtm
      ,@t_lastActionCd AS t_lastActionCd
      ,@t_jobBy AS t_jobBy
  FROM [base_tx_ca_0_hlp_uat].[CRHCURRENCY]
END