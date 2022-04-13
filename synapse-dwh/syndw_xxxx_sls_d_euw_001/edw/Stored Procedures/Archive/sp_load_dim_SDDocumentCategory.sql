CREATE PROC [edw].[sp_load_dim_SDDocumentCategory]
  @t_jobId [varchar](36)
, @t_jobDtm [datetime]
, @t_lastActionCd [varchar](1)
, @t_jobBy [nvarchar](128)
AS
BEGIN

    IF OBJECT_ID('syndw_xxxx_sls_d_euw_001.edw.dim_SDDocumentCategory', 'U') is not null
        TRUNCATE TABLE [edw].[dim_SDDocumentCategory]

    INSERT INTO [edw].[dim_SDDocumentCategory]( [SDDocumentCategoryID]
                                              , [SDDocumentCategory]
                                              --, [DomainValue]
                                              , [t_applicationId]
                                              , [t_jobId]
                                              , [t_jobDtm]
                                              , [t_lastActionCd]
                                              , [t_jobBy])
    SELECT SDDocumentCategory.[SDDocumentCategory]         as [SDDocumentCategoryID]
         , SDDocumentCategoryText.[SDDocumentCategoryName] as [SDDocumentCategory]
         , SDDocumentCategory.t_applicationId
         , @t_jobId                                        AS t_jobId
         , @t_jobDtm                                       AS t_jobDtm
         , @t_lastActionCd                                 AS t_lastActionCd
         , @t_jobBy                                        AS t_jobBy
    FROM [base_s4h_uat_caa].[I_SDDocumentCategory] SDDocumentCategory
             LEFT JOIN
         [base_s4h_uat_caa].[I_SDDocumentCategoryText] SDDocumentCategoryText
         ON
                     SDDocumentCategory.[SDDocumentCategory] = SDDocumentCategoryText.[SDDocumentCategory]
                 AND
                     SDDocumentCategoryText.[Language] = 'E'
END