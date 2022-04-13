CREATE PROC [edw].[sp_load_dim_DistributionChannel] @t_jobId [varchar](36)
, @t_jobDtm [datetime]
, @t_lastActionCd [varchar](1)
, @t_jobBy [nvarchar](128)
AS
BEGIN

    IF OBJECT_ID('syndw_xxxx_sls_d_euw_001.edw.dim_DistributionChannel', 'U') is not null
        TRUNCATE TABLE [edw].[dim_DistributionChannel]
    INSERT INTO [edw].[dim_DistributionChannel]( [DistributionChannelID]
                                               , [DistributionChannel]
                                               , [t_applicationId]
                                               , [t_jobId]
                                               , [t_jobDtm]
                                               , [t_lastActionCd]
                                               , [t_jobBy])
    select DistributionChannel
         , DistributionChannelName
         , [t_applicationId]
         , @t_jobId                  AS t_jobId
         , @t_jobDtm                 AS t_jobDtm
         , @t_lastActionCd           AS t_lastActionCd
         , @t_jobBy                  AS t_jobBy
    FROM [base_s4h_uat_caa].[I_DistributionChannelText] DistributionChannelText
    where DistributionChannelText.[Language] = 'E' and DistributionChannelText.MANDT = 200
END