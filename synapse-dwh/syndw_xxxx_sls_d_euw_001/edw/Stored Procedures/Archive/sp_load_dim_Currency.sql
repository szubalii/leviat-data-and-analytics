CREATE PROC [edw].[sp_load_dim_Currency]
  @t_jobId [varchar](36)
, @t_jobDtm [datetime]
, @t_lastActionCd [varchar](1)
, @t_jobBy [nvarchar](128)
AS
BEGIN

    IF OBJECT_ID('syndw_xxxx_sls_d_euw_001.edw.dim_Currency', 'U') is not null
        TRUNCATE TABLE [edw].[dim_Currency]

    INSERT INTO [edw].[dim_Currency]( [CurrencyID]
                                    , [Currency]
                                    , [Decimals]
                                    , [CurrencyISOCode]
                                    , [AlternativeCurrencyKey]
                                    , [IsPrimaryCurrencyForISOCrcy]
                                    , [t_applicationId]
                                    , [t_jobId]
                                    , [t_jobDtm]
                                    , [t_lastActionCd]
                                    , [t_jobBy])
    SELECT Currency.[Currency]              as [CurrencyID]
         , CurrencyText.[CurrencyShortName] as [Currency]
         , [Decimals]
         , [CurrencyISOCode]
         , [AlternativeCurrencyKey]
         , [IsPrimaryCurrencyForISOCrcy]
         , Currency.t_applicationId
         , @t_jobId                         AS t_jobId
         , @t_jobDtm                        AS t_jobDtm
         , @t_lastActionCd                  AS t_lastActionCd
         , @t_jobBy                         AS t_jobBy
    FROM [base_s4h_uat_caa].[I_Currency] Currency
             LEFT JOIN [base_s4h_uat_caa].[I_CurrencyText] CurrencyText
                       ON Currency.[Currency] = CurrencyText.[Currency]
                           AND
                          CurrencyText.[Language] = 'E'
    where Currency.[MANDT] = 200 and CurrencyText.[MANDT] = 200
END