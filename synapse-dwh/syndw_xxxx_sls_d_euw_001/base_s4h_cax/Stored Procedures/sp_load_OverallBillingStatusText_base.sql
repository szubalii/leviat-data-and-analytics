CREATE PROC [base_s4h_uat_caa].[sp_load_OverallBillingStatusText_base]
	@t_applicationId [varchar](7),
	@t_jobId [varchar](36),
	@t_lastDtm [datetime],
	@t_lastActionBy [nvarchar](20),
	@t_filePath [nvarchar](1024)
AS
BEGIN
	
	TRUNCATE TABLE [base_s4h_uat_caa].[I_OverallBillingStatusText]

	INSERT INTO [base_s4h_uat_caa].[I_OverallBillingStatusText](
		[OverallBillingStatus]
		,[Language]
		,[OverallBillingStatusDesc]
		,[t_applicationId]
		,[t_jobId]
		,[t_lastDtm]
		,[t_lastActionBy]
		,[t_filePath]
	)
	SELECT
		[OverallBillingStatus]
		,CONVERT([char](1), [Language]) AS [Language]
		,[OverallBillingStatusDesc]
		,@t_applicationId AS t_applicationId
		,@t_jobId AS t_jobId
		,@t_lastDtm AS t_lastDtm
		,@t_lastActionBy AS t_lastActionBy
		,@t_filePath AS t_filePath
	FROM [base_s4h_uat_caa].[I_OverallBillingStatusText_staging]
END
