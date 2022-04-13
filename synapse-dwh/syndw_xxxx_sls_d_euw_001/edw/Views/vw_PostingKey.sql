CREATE VIEW [edw].[vw_PostingKey]
	AS SELECT 
	   PostingKey.[PostingKey] AS [PostingKeyID]
      ,PostingKeyText.[PostingKeyName] AS [PostingKey]
      ,[DebitCreditCode]
      ,[FinancialAccountType]
      ,[IsSalesRelated]
      ,[IsUsedInPaymentTransaction]
      ,[ReversalPostingKey]
      ,[IsSpecialGLTransaction]
      ,PostingKey.[t_applicationId]
    FROM 
        [base_s4h_cax].[I_PostingKey] PostingKey
    LEFT JOIN 
        [base_s4h_cax].[I_PostingKeyText] PostingKeyText
        ON 
            PostingKey.[PostingKey] = PostingKeyText.[PostingKey]
            AND
            PostingKeyText.[Language] = 'E'
    -- WHERE PostingKey.[MANDT] = 200 AND PostingKeyText.[MANDT] = 200 MPS 2021/11/01: commented out due to different client values between dev,qas, and prod
