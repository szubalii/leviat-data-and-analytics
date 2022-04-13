CREATE PROC [base_s4h_uat_caa].[sp_load_ExchangeRate_base] 
@t_applicationId [varchar](7),
@t_jobId [varchar](36),
@t_lastDtm [datetime],
@t_lastActionBy [nvarchar](20),
@t_filePath [nvarchar](1024) 
AS
BEGIN
	
	TRUNCATE TABLE [base_s4h_uat_caa].[I_ExchangeRate]

	INSERT INTO [base_s4h_uat_caa].[I_ExchangeRate](
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
      ,[t_lastDtm]
      ,[t_lastActionBy]
      ,[t_filePath]
	)
	SELECT
	 [ExchangeRateType]
    ,CONVERT([char](5), [SourceCurrency]) AS [SourceCurrency]
    ,CONVERT([char](5), [TargetCurrency]) AS [TargetCurrency]
    ,CASE [ExchangeRateEffectiveDate]
			WHEN '00000000' THEN '19000101' 
			ELSE CONVERT([date], [ExchangeRateEffectiveDate], 112) 
		 END AS [ExchangeRateEffectiveDate]
    ,CONVERT([decimal](9,5), CASE 
			WHEN RIGHT(RTRIM([ExchangeRate]), 1) = '-'
			THEN '-' + REPLACE([ExchangeRate], '-','')
			ELSE [ExchangeRate]
	 END) AS [ExchangeRate]	
    ,CONVERT([decimal](9), CASE 
			WHEN RIGHT(RTRIM([NumberOfSourceCurrencyUnits]), 1) = '-'
			THEN '-' + REPLACE([NumberOfSourceCurrencyUnits], '-','')
			ELSE [NumberOfSourceCurrencyUnits]
	 END) AS [NumberOfSourceCurrencyUnits]	
    ,CONVERT([decimal](9), CASE 
			WHEN RIGHT(RTRIM([NumberOfTargetCurrencyUnits]), 1) = '-'
			THEN '-' + REPLACE([NumberOfTargetCurrencyUnits], '-','')
			ELSE [NumberOfTargetCurrencyUnits]
	 END) AS [NumberOfTargetCurrencyUnits]	
    ,[AlternativeExchangeRateType]
    ,CASE [AltvExchangeRateTypeValdtyDate]
		WHEN '00000000' THEN '19000101' 
		ELSE CONVERT([date], [AltvExchangeRateTypeValdtyDate], 112) 
		END AS [AltvExchangeRateTypeValdtyDate]
    ,[InvertedExchangeRateIsAllowed]
    ,CONVERT([char](5), [ReferenceCurrency]) AS [ReferenceCurrency]
    ,[BuyingRateAvgExchangeRateType]
    ,[SellingRateAvgExchangeRateType]
    ,[FixedExchangeRateIsUsed]
    ,[SpecialConversionIsUsed]
	,CONVERT(TINYINT, [SourceCurrencyDecimals])
	,CONVERT(TINYINT, [TargetCurrencyDecimals])
    ,[ExchRateIsIndirectQuotation]
    ,CONVERT([decimal](9,5), CASE 
			WHEN RIGHT(RTRIM([AbsoluteExchangeRate]), 1) = '-'
			THEN '-' + REPLACE([AbsoluteExchangeRate], '-','')
			ELSE [AbsoluteExchangeRate]
	 END) AS [AbsoluteExchangeRate]	
    ,CONVERT([decimal](12,5), CASE 
			WHEN RIGHT(RTRIM([EffectiveExchangeRate]), 1) = '-'
			THEN '-' + REPLACE([EffectiveExchangeRate], '-','')
			ELSE [EffectiveExchangeRate]
	 END) AS [EffectiveExchangeRate]	
    ,CONVERT([decimal](9,5), CASE 
			WHEN RIGHT(RTRIM([DirectQuotedEffectiveExchRate]), 1) = '-'
			THEN '-' + REPLACE([DirectQuotedEffectiveExchRate], '-','')
			ELSE [DirectQuotedEffectiveExchRate]
	 END) AS [DirectQuotedEffectiveExchRate]	
    ,CONVERT([decimal](9,5), CASE 
			WHEN RIGHT(RTRIM([IndirectQuotedEffctvExchRate]), 1) = '-'
			THEN '-' + REPLACE([IndirectQuotedEffctvExchRate], '-','')
			ELSE [IndirectQuotedEffctvExchRate]
	 END) AS [IndirectQuotedEffctvExchRate]	
	,@t_applicationId AS t_applicationId
	,@t_jobId AS t_jobId
	,@t_lastDtm AS t_lastDtm
	,@t_lastActionBy AS t_lastActionBy
	,@t_filePath AS t_filePath
	FROM [base_s4h_uat_caa].[I_ExchangeRate_staging]
END