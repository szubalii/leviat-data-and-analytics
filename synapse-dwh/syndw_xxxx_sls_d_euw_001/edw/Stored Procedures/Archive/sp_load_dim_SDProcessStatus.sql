CREATE PROC [edw].[sp_load_dim_SDProcessStatus]
      @t_jobId [varchar](36)
    , @t_jobDtm [datetime]
    , @t_lastActionCd [varchar](1)
    , @t_jobBy [nvarchar](128)
AS
BEGIN

    IF OBJECT_ID('syndw_xxxx_sls_d_euw_001.edw.dim_SDProcessStatus', 'U') IS NOT NULL TRUNCATE TABLE [edw].[dim_SDProcessStatus]

    INSERT INTO [edw].[dim_SDProcessStatus](
        [SDProcessStatusID]
        ,[SDProcessStatus]
        ,[t_applicationId]
        ,[t_jobId]
        ,[t_jobDtm]
        ,[t_lastActionCd]
        ,[t_jobBy])
    SELECT 
        [SDProcessStatusID]
        ,[SDProcessStatus]
        ,[t_applicationId]
        ,@t_jobId                              AS t_jobId
        ,@t_jobDtm                             AS t_jobDtm
        ,@t_lastActionCd                       AS t_lastActionCd
        ,@t_jobBy                              AS t_jobBy
    FROM
        [edw].[vw_SDProcessStatus]
END
