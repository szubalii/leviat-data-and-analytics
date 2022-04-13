CREATE PROC [edw].[sp_load_dim_CustomerAccountAssignmentGroup] @t_jobId [varchar](36)
, @t_jobDtm [datetime]
, @t_lastActionCd [varchar](1)
, @t_jobBy [nvarchar](128)
AS
BEGIN

    IF OBJECT_ID('syndw_xxxx_sls_d_euw_001.edw.dim_CustomerAccountAssignmentGroup', 'U') is not null
        TRUNCATE TABLE [edw].[dim_CustomerAccountAssignmentGroup]

    INSERT INTO [edw].[dim_CustomerAccountAssignmentGroup](
                                                 [CustomerAccountAssignmentGroupID]
                                               , [CustomerAccountAssignmentGroup]
                                               , [t_applicationId]
                                               , [t_jobId]
                                               , [t_jobDtm]
                                               , [t_lastActionCd]
                                               , [t_jobBy])
    select CustomerAccountAssignmentGroup
         , CustomerAccountAssgmtGrpName
         , [t_applicationId]
         , @t_jobId                  AS t_jobId
         , @t_jobDtm                 AS t_jobDtm
         , @t_lastActionCd           AS t_lastActionCd
         , @t_jobBy					 AS t_jobBy
    FROM [base_s4h_uat_caa].[I_CustomerAccountAssgmtGroupT] I_CustomerAccountAssgmtGroupT
    where I_CustomerAccountAssgmtGroupT.[Language] = 'E' and I_CustomerAccountAssgmtGroupT.MANDT = 200
END
