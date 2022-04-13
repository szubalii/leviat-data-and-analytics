CREATE VIEW [edw].[vw_Country]
	AS SELECT 
		   Country.[Country]         AS [CountryID]
         , CountryText.[CountryName] AS [Country]
         , Country.[CountryThreeDigitISOCode]
         , Country.[CountryCurrency]
         , Country.[IndexBasedCurrency]
         , Country.[HardCurrency]
         , Country.[TaxCalculationProcedure]
         , Country.[CountryAlternativeCode]
         , CountryText.[NationalityName]
         , CountryText.[NationalityLongName]
         , Country.t_applicationId
    FROM [base_s4h_cax].[I_Country] Country
    LEFT JOIN [base_s4h_cax].[I_CountryText] CountryText
         ON Country.[Country] = CountryText.[Country]  AND  CountryText.[Language] = 'E' 
     --     WHERE Country.MANDT = 200 AND CountryText.MANDT = 200 MPS 2021/11/01: commented out due to different client values between dev,qas, and prod
