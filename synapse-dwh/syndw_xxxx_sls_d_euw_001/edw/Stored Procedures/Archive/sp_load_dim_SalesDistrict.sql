CREATE PROC [edw].[sp_load_dim_SalesDistrict] @t_jobId [varchar](36)
, @t_jobDtm [datetime]
, @t_lastActionCd [varchar](1)
, @t_jobBy [nvarchar](128)
AS
BEGIN

    IF OBJECT_ID('syndw_xxxx_sls_d_euw_001.edw.dim_SalesDistrict', 'U') is not null
        TRUNCATE TABLE [edw].[dim_SalesDistrict]

    INSERT INTO [edw].[dim_SalesDistrict]( [SalesDistrictID]
                                         , [SalesDistrict]
                                         , [t_applicationId]
                                         , [t_jobId]
                                         , [t_jobDtm]
                                         , [t_lastActionCd]
                                         , [t_jobBy])
    select SalesDistrict.SalesDistrict
         , SalesDistrictText.SalesDistrictName
         , SalesDistrict.[t_applicationId]
         , @t_jobId        AS t_jobId
         , @t_jobDtm       AS t_jobDtm
         , @t_lastActionCd AS t_lastActionCd
         , @t_jobBy        AS t_jobBy
    FROM [base_s4h_uat_caa].[I_SalesDistrict] SalesDistrict
             LEFT JOIN [base_s4h_uat_caa].[I_SalesDistrictText] SalesDistrictText
                       ON SalesDistrict.[SalesDistrict] = SalesDistrictText.[SalesDistrict]
            and SalesDistrictText.[Language] = 'E'
    where SalesDistrict.MANDT = 200 and SalesDistrictText.MANDT = 200
END