CREATE PROC [base_s4h_uat_caa].[sp_load_PostingKey_base] 
@t_applicationId [varchar](7),
@t_jobId [varchar](36),
@t_lastDtm [datetime],
@t_lastActionBy [nvarchar](20),
@t_filePath [nvarchar](1024) 
AS
BEGIN
	
	TRUNCATE TABLE [base_s4h_uat_caa].[I_PostingKey]

	INSERT INTO [base_s4h_uat_caa].[I_PostingKey](
	   [PostingKey]
      ,[DebitCreditCode]
      ,[FinancialAccountType]
      ,[IsSalesRelated]
      ,[IsUsedInPaymentTransaction]
      ,[ReversalPostingKey]
      ,[IsSpecialGLTransaction]
      ,[t_applicationId]
      ,[t_jobId]
      ,[t_lastDtm]
      ,[t_lastActionBy]
      ,[t_filePath]
	)
	SELECT
	 [PostingKey]
    ,[DebitCreditCode]
    ,[FinancialAccountType]
    ,[IsSalesRelated]
    ,[IsUsedInPaymentTransaction]
    ,[ReversalPostingKey]
    ,[IsSpecialGLTransaction]
	,@t_applicationId AS t_applicationId
	,@t_jobId AS t_jobId
	,@t_lastDtm AS t_lastDtm
	,@t_lastActionBy AS t_lastActionBy
	,@t_filePath AS t_filePath
	FROM [base_s4h_uat_caa].[I_PostingKey_staging]
END