CREATE PROC [edw].[sp_load_dim_BillingDocumentType]
  @t_jobId [varchar](36)
, @t_jobDtm [datetime]
, @t_lastActionCd [varchar](1)
, @t_jobBy [nvarchar](128)
AS
BEGIN

    IF OBJECT_ID('syndw_xxxx_sls_d_euw_001.edw.dim_BillingDocumentType', 'U') is not null
        TRUNCATE TABLE [edw].[dim_BillingDocumentType]

    INSERT INTO [edw].[dim_BillingDocumentType]( [BillingDocumentTypeID]
                                               , [BillingDocumentType]
                                               , [SDDocumentCategory]
                                               , [IncrementItemNumber]
                                               , [BillingDocumentCategory]
                                               , [t_applicationId]
                                               , [t_jobId]
                                               , [t_jobDtm]
                                               , [t_lastActionCd]
                                               , [t_jobBy])
    SELECT BillingDocumentType.[BillingDocumentType]     as [BillingDocumentTypeID]
         , BillingDocumentTypeText.[BillingDocumentType] as [BillingDocumentType]
         , [SDDocumentCategory]
         , [IncrementItemNumber]
         , [BillingDocumentCategory]
         , BillingDocumentType.t_applicationId
         , @t_jobId                                      AS t_jobId
         , @t_jobDtm                                     AS t_jobDtm
         , @t_lastActionCd                               AS t_lastActionCd
         , @t_jobBy                                      AS t_jobBy
    FROM [base_s4h_uat_caa].[I_BillingDocumentType] BillingDocumentType
             LEFT JOIN
         [base_s4h_uat_caa].[I_BillingDocumentTypeText] BillingDocumentTypeText
         ON
                     BillingDocumentType.[BillingDocumentType] = BillingDocumentTypeText.[BillingDocumentType]
                 AND
                     BillingDocumentTypeText.[Language] = 'E'
    where BillingDocumentType.[MANDT] = 200 and BillingDocumentTypeText.[MANDT] = 200
END