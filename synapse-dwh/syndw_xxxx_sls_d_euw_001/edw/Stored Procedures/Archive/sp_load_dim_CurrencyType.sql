CREATE PROC [edw].[sp_load_dim_CurrencyType]
     @t_jobId        [varchar]   (36)
    ,@t_jobDtm       [datetime]
    ,@t_lastActionCd [varchar]    (1)
    ,@t_jobBy [nvarchar] (128)
AS
BEGIN

    IF OBJECT_ID('syndw_xxxx_sls_d_euw_001.edw.dim_CurrencyType', 'U') is not null
        TRUNCATE TABLE [edw].[dim_CurrencyType]

    INSERT INTO
        [edw].[dim_CurrencyType] (
             [CurrencyTypeID]
            ,[CurrencyType]
            ,[t_applicationId]
            ,[t_jobId]
            ,[t_jobDtm]
            ,[t_lastActionCd]
            ,[t_jobBy]
        )
    SELECT
         *
        ,@t_jobId        AS t_jobId
        ,@t_jobDtm       AS t_jobDtm
        ,@t_lastActionCd AS t_lastActionCd
        ,@t_jobBy        AS t_jobBy
    FROM
        [edw].[vw_CurrencyType]
END
