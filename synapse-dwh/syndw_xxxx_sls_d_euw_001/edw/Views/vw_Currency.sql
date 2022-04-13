CREATE VIEW [edw].[vw_Currency]
	AS SELECT 
		   Currency.[Currency]              AS [CurrencyID]
         , CurrencyText.[CurrencyShortName] AS [Currency]
         , [Decimals]
         , [CurrencyISOCode]
         , [AlternativeCurrencyKey]
         , [IsPrimaryCurrencyForISOCrcy]
         , Currency.t_applicationId
    FROM [base_s4h_cax].[I_Currency] Currency
             LEFT JOIN [base_s4h_cax].[I_CurrencyText] CurrencyText
                       ON Currency.[Currency] = CurrencyText.[Currency]
                           AND
                          CurrencyText.[Language] = 'E'
    -- WHERE Currency.[MANDT] = 200 AND CurrencyText.[MANDT] = 200 MPS 2021/11/01: commented out due to different client values between dev,qas, and prod
