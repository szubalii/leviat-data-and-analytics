CREATE PROC [edw].[sp_load_dim_PricingIncompletionStatus] @t_jobId [varchar](36)
, @t_jobDtm [datetime]
, @t_lastActionCd [varchar](1)
, @t_jobBy [nvarchar](128)
AS
BEGIN

    IF OBJECT_ID('syndw_xxxx_sls_d_euw_001.edw.dim_PricingIncompletionStatus', 'U') is not null
        TRUNCATE TABLE [edw].[dim_PricingIncompletionStatus]

    INSERT INTO [edw].[dim_PricingIncompletionStatus]( [PricingIncompletionStatusID]
                                                , [PricingIncompletionStatus]
                                                , [t_applicationId]
                                                , [t_jobId]
                                                , [t_jobDtm]
                                                , [t_lastActionCd]
                                                , [t_jobBy])
    SELECT PricingIncompletionStatusText.[PricingIncompletionStatus]     as [PricingIncompletionStatusID]
         , PricingIncompletionStatusText.[PricingIncompletionStatusDesc] as [PricingIncompletionStatus]
         , t_applicationId
         , @t_jobId                                            AS t_jobId
         , @t_jobDtm                                           AS t_jobDtm
         , @t_lastActionCd                                     AS t_lastActionCd
         , @t_jobBy                                            AS t_jobBy
    FROM [base_s4h_uat_caa].[I_PricingIncompletionStatusT] PricingIncompletionStatusText
    where PricingIncompletionStatusText.[Language] = 'E'
      and [MANDT] = 200
END