CREATE VIEW [edw].[vw_ExchangeRateType]
	AS SELECT 
		   ExchangeRateType.ExchangeRateType           AS [ExchangeRateTypeID]
         , ExchangeRateTypeText.[ExchangeRateTypeName] AS [ExchangeRateType]
         , ExchangeRateType.[ReferenceCurrency]
         , ExchangeRateType.[BuyingRateAvgExchangeRateType]
         , ExchangeRateType.[InvertedExchangeRateIsAllowed]
         , ExchangeRateType.[SellingRateAvgExchangeRateType]
         , ExchangeRateType.[FixedExchangeRateIsUsed]
         , ExchangeRateType.[SpecialConversionIsUsed]
         , ExchangeRateType.[SourceCurrencyIsBaseCurrency]
         , ExchangeRateType.[t_applicationId]
    FROM [base_s4h_cax].[I_ExchangeRateType] ExchangeRateType
             LEFT JOIN
         [base_s4h_cax].[I_ExchangeRateTypeText] ExchangeRateTypeText
         ON
                     ExchangeRateType.[ExchangeRateType] = ExchangeRateTypeText.[ExchangeRateType]
                 AND
                     ExchangeRateTypeText.[Language] = 'E'
    -- WHERE ExchangeRateType.[MANDT] = 200 AND ExchangeRateTypeText.[MANDT] = 200  MPS 2021/11/01: commented out due to different client values between dev,qas, and prod
