CREATE PROC [edw].[sp_load_dim_DeliveryBlockStatus] @t_jobId [varchar](36)
, @t_jobDtm [datetime]
, @t_lastActionCd [varchar](1)
, @t_jobBy [nvarchar](128)
AS
BEGIN

    IF OBJECT_ID('syndw_xxxx_sls_d_euw_001.edw.dim_DeliveryBlockStatus', 'U') is not null
        TRUNCATE TABLE [edw].[dim_DeliveryBlockStatus]

    INSERT INTO [edw].[dim_DeliveryBlockStatus]( [DeliveryBlockStatusID]
                                               , [DeliveryBlockStatus]
                                               , [t_applicationId]
                                               , [t_jobId]
                                               , [t_jobDtm]
                                               , [t_lastActionCd]
                                               , [t_jobBy])
    SELECT DeliveryBlockStatusText.[DeliveryBlockStatus]     as [DeliveryBlockStatusID]
         , DeliveryBlockStatusText.[DeliveryBlockStatusDesc] as [DeliveryBlockStatus]
         , t_applicationId
         , @t_jobId                                          AS t_jobId
         , @t_jobDtm                                         AS t_jobDtm
         , @t_lastActionCd                                   AS t_lastActionCd
         , @t_jobBy                                          AS t_jobBy
    FROM [base_s4h_uat_caa].[I_DeliveryBlockStatusText] DeliveryBlockStatusText
    where DeliveryBlockStatusText.[Language] = 'E'
      and [MANDT] = 200
END