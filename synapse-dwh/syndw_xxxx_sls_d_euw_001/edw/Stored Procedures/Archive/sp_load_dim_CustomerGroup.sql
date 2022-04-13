CREATE PROC [edw].[sp_load_dim_CustomerGroup]
      @t_jobId [varchar](36)
    , @t_jobDtm [datetime]
    , @t_lastActionCd [varchar](1)
    , @t_jobBy [nvarchar](128)
AS
BEGIN

    IF OBJECT_ID('syndw_xxxx_sls_d_euw_001.edw.dim_CustomerGroup', 'U') is not null
        TRUNCATE TABLE [edw].[dim_CustomerGroup]
    INSERT INTO [edw].[dim_CustomerGroup]( [CustomerGroupID]
                                         , [CustomerGroup]
                                         , [t_applicationId]
                                         , [t_jobId]
                                         , [t_jobDtm]
                                         , [t_lastActionCd]
                                         , [t_jobBy])
    select CustomerGroup
         , CustomerGroupName
         , [t_applicationId]
         , @t_jobId                  AS t_jobId
         , @t_jobDtm                 AS t_jobDtm
         , @t_lastActionCd           AS t_lastActionCd
         , @t_jobBy           		 AS t_jobBy
    FROM [base_s4h_uat_caa].[I_CustomerGroupText] CustomerGroupText
    where CustomerGroupText.[Language] = 'E' and CustomerGroupText.MANDT = 200
END