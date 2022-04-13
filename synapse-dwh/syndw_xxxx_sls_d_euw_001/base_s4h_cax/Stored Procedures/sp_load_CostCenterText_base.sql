CREATE PROC [base_s4h_uat_caa].[sp_load_CostCenterText_base] 
@t_applicationId [varchar](7),
@t_jobId [varchar](36),
@t_lastDtm [datetime],
@t_lastActionBy [nvarchar](20),
@t_filePath [nvarchar](1024) 
AS
BEGIN
	
	TRUNCATE TABLE [base_s4h_uat_caa].[I_CostCenterText]

	INSERT INTO [base_s4h_uat_caa].[I_CostCenterText](
	   [CostCenter]
      ,[ControllingArea]
      ,[Language]
      ,[ValidityEndDate]
      ,[ValidityStartDate]
      ,[CostCenterName]
      ,[CostCenterDescription]
      ,[t_applicationId]
      ,[t_jobId]
      ,[t_lastDtm]
      ,[t_lastActionBy]
      ,[t_filePath]
	)
	SELECT
	 [CostCenter]
    ,[ControllingArea]
    ,CONVERT([char](1), [Language]) AS [Language]
    ,CASE [ValidityEndDate]
	 WHEN '00000000' THEN '19000101' 
	 ELSE CONVERT([date], [ValidityEndDate], 112) 
	 END AS [ValidityEndDate]
	,CASE [ValidityStartDate]
	 WHEN '00000000' THEN '19000101' 
	 ELSE CONVERT([date], [ValidityStartDate], 112) 
	 END AS [ValidityStartDate]
    ,[CostCenterName]
    ,[CostCenterDescription]
	,@t_applicationId AS t_applicationId
	,@t_jobId AS t_jobId
	,@t_lastDtm AS t_lastDtm
	,@t_lastActionBy AS t_lastActionBy
	,@t_filePath AS t_filePath
	FROM [base_s4h_uat_caa].[I_CostCenterText_staging]
END