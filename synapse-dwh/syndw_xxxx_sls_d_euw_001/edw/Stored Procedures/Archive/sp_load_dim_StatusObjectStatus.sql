CREATE PROC [edw].[sp_load_dim_StatusObjectStatus] @t_jobId [varchar](36)
, @t_jobDtm [datetime]
, @t_lastActionCd [varchar](1)
, @t_jobBy [nvarchar](128)
AS
BEGIN

    IF OBJECT_ID('syndw_xxxx_sls_d_euw_001.edw.dim_StatusObjectStatus', 'U') is not null
        TRUNCATE TABLE [edw].[dim_StatusObjectStatus]
    INSERT INTO [edw].[dim_StatusObjectStatus]( [StatusObjectStatusID]
                                              , [UserStatus]
                                              , [UserStatusShort]
                                              , [StatusProfile]
                                              , [StatusIsActive]
                                              , [t_applicationId]
                                              , [t_jobId]
                                              , [t_jobDtm]
                                              , [t_lastActionCd]
                                              , [t_jobBy])
    select
           [StatusObject]
         , [StatusName] as [UserStatus]
         , [StatusShortName] as [UserStatusShort]
         , stost.[StatusProfile]
         , stost.[StatusIsActive]
         , stost.[t_applicationId]
         , @t_jobId        AS t_jobId
         , @t_jobDtm       AS t_jobDtm
         , @t_lastActionCd AS t_lastActionCd
         , @t_jobBy        AS t_jobBy
        from [base_s4h_uat_caa].[I_StatusObjectStatus] stost
        join [base_s4h_uat_caa].[I_StatusCodeText] sct 
            on stost.[StatusCode] = sct.[StatusCode]
                and
               stost.[StatusProfile] = sct.[StatusProfile]
        where stost.[MANDT]  = 200 and sct.[MANDT]  = 200 and sct.[Language] = 'E'
END