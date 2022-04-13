CREATE PROC [edw].[sp_load_dim_CustomerPriceGroup]   
  @t_jobId [varchar](36)
, @t_jobDtm [datetime]
, @t_lastActionCd [varchar](1)
, @t_jobBy [nvarchar](128)
AS
BEGIN

    IF OBJECT_ID('syndw_xxxx_sls_d_euw_001.edw.dim_CustomerPriceGroup', 'U') is not null
        TRUNCATE TABLE [edw].[dim_CustomerPriceGroup]

    INSERT INTO [edw].[dim_CustomerPriceGroup]( [CustomerPriceGroupID]
                                              , [CustomerPriceGroup]
                                              , [t_applicationId]
                                              , [t_jobId]
                                              , [t_jobDtm]
                                              , [t_lastActionCd]
                                              , [t_jobBy])
    SELECT CustomerPriceGroupText.[CustomerPriceGroup]     as [CustomerPriceGroupID]
         , CustomerPriceGroupText.[CustomerPriceGroupName] as [CustomerPriceGroup]
         , t_applicationId
         , @t_jobId                                        AS t_jobId
         , @t_jobDtm                                       AS t_jobDtm
         , @t_lastActionCd                                 AS t_lastActionCd
         , @t_jobBy                                 	   AS t_jobBy
    FROM [base_s4h_uat_caa].[I_CustomerPriceGroupText] CustomerPriceGroupText
    where CustomerPriceGroupText.[Language] = 'E' and CustomerPriceGroupText.[MANDT] = 200
END