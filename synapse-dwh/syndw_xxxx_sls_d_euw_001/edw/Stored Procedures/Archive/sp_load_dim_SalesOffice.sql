CREATE PROC [edw].[sp_load_dim_SalesOffice] @t_jobId [varchar](36)
, @t_jobDtm [datetime]
, @t_lastActionCd [varchar](1)
, @t_jobBy [nvarchar](128)
AS
BEGIN

    IF OBJECT_ID('syndw_xxxx_sls_d_euw_001.edw.dim_SalesOffice', 'U') is not null
        TRUNCATE TABLE [edw].[dim_SalesOffice]
    INSERT INTO [edw].[dim_SalesOffice](         [SalesOfficeID]
                                               , [SalesOffice]
                                               , [t_applicationId]
                                               , [t_jobId]
                                               , [t_jobDtm]
                                               , [t_lastActionCd]
                                               , [t_jobBy])
    select SalesOffice
         , SalesOfficeName
         , [t_applicationId]
         , @t_jobId                  AS t_jobId
         , @t_jobDtm                 AS t_jobDtm
         , @t_lastActionCd           AS t_lastActionCd
         , @t_jobBy                  AS t_jobBy
    FROM [base_s4h_uat_caa].[I_SalesOfficeText] SalesOfficeText
    where SalesOfficeText.[Language] = 'E' and SalesOfficeText.MANDT = 200
END