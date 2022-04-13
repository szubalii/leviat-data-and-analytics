CREATE PROC [edw].[sp_load_dim_MaterialGroup]
      @t_jobId [varchar](36)
    , @t_jobDtm [datetime]
    , @t_lastActionCd [varchar](1)
    , @t_jobBy [nvarchar](128)
AS
BEGIN

    IF OBJECT_ID('syndw_xxxx_sls_d_euw_001.edw.dim_MaterialGroup', 'U') is not null
        TRUNCATE TABLE [edw].[dim_MaterialGroup]

    INSERT INTO [edw].[dim_MaterialGroup]( [MaterialGroupID]
                                         , [MaterialGroup]
                                         , [MaterialAuthorizationGroup]
                                         , [MaterialGroupText]
                                         , [t_applicationId]
                                         , [t_jobId]
                                         , [t_jobDtm]
                                         , [t_lastActionCd]
                                         , [t_jobBy])
    SELECT MaterialGroup.[MaterialGroup]         as [MaterialGroupID]
         , MaterialGroupText.[MaterialGroupName] as [MaterialGroup]
         , MaterialGroup.[MaterialAuthorizationGroup]
         , MaterialGroupText.[MaterialGroupText]
         , MaterialGroup.t_applicationId
         , @t_jobId                              AS t_jobId
         , @t_jobDtm                             AS t_jobDtm
         , @t_lastActionCd                       AS t_lastActionCd
         , @t_jobBy                              AS t_jobBy
    FROM [base_s4h_uat_caa].[I_MaterialGroup] MaterialGroup
             LEFT JOIN
         [base_s4h_uat_caa].[I_MaterialGroupText] MaterialGroupText
         ON
                     MaterialGroup.[MaterialGroup] =
                     MaterialGroupText.[MaterialGroup]
                 AND
                     MaterialGroupText.[Language] = 'E'

    where MaterialGroup.[MANDT] = 200 and MaterialGroupText.[MANDT] = 200
END    
    