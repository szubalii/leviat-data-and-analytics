CREATE PROC [edw].[sp_load_dim_Country]
     @t_jobId [varchar](36)
    ,@t_jobDtm [datetime]
    ,@t_lastActionCd [varchar](1)
    ,@t_jobBy [nvarchar](128)
AS
BEGIN

    IF OBJECT_ID('syndw_xxxx_sls_d_euw_001.edw.dim_Country', 'U') is not null
        TRUNCATE TABLE [edw].[dim_Country]

    INSERT INTO [edw].[dim_Country]( [CountryID]
                                   , [Country]
                                   , [CountryThreeLetterISOCode]
                                   , [CountryThreeDigitISOCode]
                                   , [CountryCurrency]
                                   , [IndexBasedCurrency]
                                   , [HardCurrency]
                                   , [TaxCalculationProcedure]
                                   , [CountryAlternativeCode]
                                   , [NationalityName]
                                   , [NationalityLongName]
                                   , [t_applicationId]
                                   , [t_jobId]
                                   , [t_jobDtm]
                                   , [t_lastActionCd]
                                   , [t_jobBy])
    SELECT Country.[Country]         as [CountryID]
         , CountryText.[CountryName] as [Country]
         , Country.[CountryThreeDigitISOCode]
         , Country.CountryThreeDigitISOCode
         , Country.[CountryCurrency]
         , Country.[IndexBasedCurrency]
         , Country.[HardCurrency]
         , Country.[TaxCalculationProcedure]
         , Country.[CountryAlternativeCode]
         , CountryText.[NationalityName]
         , CountryText.[NationalityLongName]
         , Country.t_applicationId
         , @t_jobId                  AS t_jobId
         , @t_jobDtm                 AS t_jobDtm
         , @t_lastActionCd           AS t_lastActionCd
         , @t_jobBy                  AS t_jobBy
    FROM [base_s4h_uat_caa].[I_Country] Country
    LEFT JOIN [base_s4h_uat_caa].[I_CountryText] CountryText
         ON Country.[Country] = CountryText.[Country]  AND  CountryText.[Language] = 'E' 
         where Country.MANDT = 200 and CountryText.MANDT = 200
END