CREATE PROC [edw].[sp_load_dim_PostingKey]
     @t_jobId [varchar](36)
    ,@t_jobDtm [datetime]
    ,@t_lastActionCd [varchar](1)
    ,@t_jobBy [nvarchar](128) 
AS
BEGIN

    IF OBJECT_ID('syndw_xxxx_sls_d_euw_001.edw.dim_PostingKey', 'U') is not null TRUNCATE TABLE [edw].[dim_PostingKey]

    INSERT INTO [edw].[dim_PostingKey](
       [PostingKeyID]
      ,[PostingKey]
      ,[DebitCreditCode]
      ,[FinancialAccountType]
      ,[IsSalesRelated]
      ,[IsUsedInPaymentTransaction]
      ,[ReversalPostingKey]
      ,[IsSpecialGLTransaction]
      ,[t_applicationId]
      ,[t_jobId]
      ,[t_jobDtm]
      ,[t_lastActionCd]
      ,[t_jobBy]
    )
    SELECT
       PostingKey.[PostingKey] as [PostingKeyID]
      ,PostingKeyText.[PostingKeyName] as [PostingKey]
      ,[DebitCreditCode]
      ,[FinancialAccountType]
      ,[IsSalesRelated]
      ,[IsUsedInPaymentTransaction]
      ,[ReversalPostingKey]
      ,[IsSpecialGLTransaction]
      ,PostingKey.[t_applicationId]
      ,@t_jobId AS t_jobId
      ,@t_jobDtm AS t_jobDtm
      ,@t_lastActionCd AS t_lastActionCd
      ,@t_jobBy AS t_jobBy
    FROM 
        [base_s4h_uat_caa].[I_PostingKey] PostingKey
    LEFT JOIN 
        [base_s4h_uat_caa].[I_PostingKeyText] PostingKeyText
        ON 
            PostingKey.[PostingKey] = PostingKeyText.[PostingKey]
            AND
            PostingKeyText.[Language] = 'E'
    where PostingKey.[MANDT] = 200 and PostingKeyText.[MANDT] = 200
END