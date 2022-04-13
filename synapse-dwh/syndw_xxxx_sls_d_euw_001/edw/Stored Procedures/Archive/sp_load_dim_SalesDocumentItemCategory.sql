CREATE PROC [edw].[sp_load_dim_SalesDocumentItemCategory] 
  @t_jobId [varchar](36)
, @t_jobDtm [datetime]
, @t_lastActionCd [varchar](1)
, @t_jobBy [nvarchar](128)
AS
BEGIN

    IF OBJECT_ID('syndw_xxxx_sls_d_euw_001.edw.dim_SalesDocumentItemCategory', 'U') is not null
        TRUNCATE TABLE [edw].[dim_SalesDocumentItemCategory]

    INSERT INTO [edw].[dim_SalesDocumentItemCategory]( [SalesDocumentItemCategoryID]
                                                     , [SalesDocumentItemCategory]
                                                     --, [BillingRelevanceCode]
                                                     , [ScheduleLineIsAllowed]
                                                     --, [PricingRelevance]
                                                     --, [TextDeterminationProcedure]
                                                     , [t_applicationId]
                                                     , [t_jobId]
                                                     , [t_jobDtm]
                                                     , [t_lastActionCd]
                                                     , [t_jobBy])
    SELECT SalesDocumentItemCategory.[SalesDocumentItemCategory]         as [SalesDocumentItemCategoryID]
         , SalesDocumentItemCategoryText.[SalesDocumentItemCategoryName] as [SalesDocumentItemCategory]
         --, [BillingRelevanceCode]
         , [ScheduleLineIsAllowed]
         --, [PricingRelevance]
         --, [TextDeterminationProcedure]
         , SalesDocumentItemCategory.t_applicationId
         , @t_jobId                                                      AS t_jobId
         , @t_jobDtm                                                     AS t_jobDtm
         , @t_lastActionCd                                               AS t_lastActionCd
         , @t_jobBy                                                      AS t_jobBy
    FROM [base_s4h_uat_caa].[I_SalesDocumentItemCategory] SalesDocumentItemCategory
             LEFT JOIN
         [base_s4h_uat_caa].[I_SalesDocumentItemCategoryT] SalesDocumentItemCategoryText
         ON
                     SalesDocumentItemCategory.[SalesDocumentItemCategory] =
                     SalesDocumentItemCategoryText.[SalesDocumentItemCategory]
                 AND
                     SalesDocumentItemCategoryText.[Language] = 'E'
   Where  SalesDocumentItemCategory.[MANDT] = 200 and SalesDocumentItemCategoryText.[MANDT] = 200
END