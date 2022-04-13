CREATE PROC [edw].[sp_load_dim_SalesDocumentItemType] 
  @t_jobId [varchar](36)
, @t_jobDtm [datetime]
, @t_lastActionCd [varchar](1)
, @t_jobBy [nvarchar](128)
AS
BEGIN

    IF OBJECT_ID('syndw_xxxx_sls_d_euw_001.edw.dim_SalesDocumentItemType', 'U') is not null
        TRUNCATE TABLE [edw].[dim_SalesDocumentItemType]

    INSERT INTO [edw].[dim_SalesDocumentItemType]( [SalesDocumentItemTypeID]
                                                 , [SalesDocumentItemType]
                                                 , [t_applicationId]
                                                 , [t_jobId]
                                                 , [t_jobDtm]
                                                 , [t_lastActionCd]
                                                 , [t_jobBy])
    SELECT SalesDocumentItemTypeText.[SalesDocumentItemType]     as [SalesDocumentItemTypeID]
         , SalesDocumentItemTypeText.[SalesDocumentItemTypeName] as [SalesDocumentItemType]
         , t_applicationId
         , @t_jobId                                              AS t_jobId
         , @t_jobDtm                                             AS t_jobDtm
         , @t_lastActionCd                                       AS t_lastActionCd
         , @t_jobBy                                              AS t_jobBy
    FROM [base_s4h_uat_caa].[I_SalesDocumentItemTypeText] SalesDocumentItemTypeText
    where SalesDocumentItemTypeText.[Language] = 'E'
END