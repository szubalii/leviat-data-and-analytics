CREATE PROC [edw].[sp_load_dim_SDDocumentReason]
  @t_jobId [varchar](36)
, @t_jobDtm [datetime]
, @t_lastActionCd [varchar](1)
, @t_jobBy [nvarchar](128)
AS
BEGIN

    IF OBJECT_ID('syndw_xxxx_sls_d_euw_001.edw.dim_SDDocumentReason', 'U') is not null
        TRUNCATE TABLE [edw].[dim_SDDocumentReason]

    INSERT INTO [edw].[dim_SDDocumentReason]( [SDDocumentReasonID]
                                            , [SDDocumentReason]
                                            --, [RetroBillingUsage]
                                            --, [SelfBillingValueItem]
                                            , [t_applicationId]
                                            , [t_jobId]
                                            , [t_jobDtm]
                                            , [t_lastActionCd]
                                            , [t_jobBy])
    SELECT SDDocumentReason.[SDDocumentReason]         as [SDDocumentReasonID]
         , SDDocumentReasonText.[SDDocumentReasonText] as [SDDocumentReason]
         --, [RetroBillingUsage]
         --, [SelfBillingValueItem]
         , SDDocumentReason.t_applicationId
         , @t_jobId                                    AS t_jobId
         , @t_jobDtm                                   AS t_jobDtm
         , @t_lastActionCd                             AS t_lastActionCd
         , @t_jobBy                                    AS t_jobBy
    FROM [base_s4h_uat_caa].[I_SDDocumentReason] SDDocumentReason
             LEFT JOIN
         [base_s4h_uat_caa].[I_SDDocumentReasonText] SDDocumentReasonText
         ON
                     SDDocumentReason.[SDDocumentReason] = SDDocumentReasonText.[SDDocumentReason]
                 AND
                     SDDocumentReasonText.[Language] = 'E'
END