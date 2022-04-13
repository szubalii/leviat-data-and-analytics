CREATE PROC [edw].[sp_load_dim_OverallSDDocumentRjcnStatus]
  @t_jobId [varchar](36)
, @t_jobDtm [datetime]
, @t_lastActionCd [varchar](1)
, @t_jobBy [nvarchar](128)
AS
BEGIN

    IF OBJECT_ID('syndw_xxxx_sls_d_euw_001.edw.dim_OverallSDDocumentRjcnStatus', 'U') is not null
        TRUNCATE TABLE [edw].[dim_OverallSDDocumentRjcnStatus]

    INSERT INTO [edw].[dim_OverallSDDocumentRjcnStatus](
                                                  [OverallSDDocumentRjcnStatusID]
                                                , [OverallSDDocumentRjcnStatus]
                                                , [t_applicationId]
                                                , [t_jobId]
                                                , [t_jobDtm]
                                                , [t_lastActionCd]
                                                , [t_jobBy])
    SELECT OverallSDDocumentRjcnStatusText.[OverallSDDocumentRejectionSts]     as [OverallSDDocumentRjcnStatusID]
         , OverallSDDocumentRjcnStatusText.[OvrlSDDocumentRejectionStsDesc] as [OverallSDDocumentRjcnStatus]
         , t_applicationId
         , @t_jobId                                            AS t_jobId
         , @t_jobDtm                                           AS t_jobDtm
         , @t_lastActionCd                                     AS t_lastActionCd
         , @t_jobBy                                            AS t_jobBy
    FROM [base_s4h_uat_caa].[I_OverallSDDocumentRjcnStatusT] OverallSDDocumentRjcnStatusText
    where OverallSDDocumentRjcnStatusText.[Language] = 'E'
      and [MANDT] = 200
END