CREATE PROC [base_s4h_uat_caa].[sp_load_FiscalCalendarDate_base] 
@t_applicationId [varchar](7),
@t_jobId [varchar](36),
@t_lastDtm [datetime],
@t_lastActionBy [nvarchar](20),
@t_filePath [nvarchar](1024) 
AS
BEGIN
	
	TRUNCATE TABLE [base_s4h_uat_caa].[I_FiscalCalendarDate]

	INSERT INTO [base_s4h_uat_caa].[I_FiscalCalendarDate](
	   [FiscalYearVariant]
      ,[CalendarDate]
      ,[FiscalYear]
      ,[FiscalYearStartDate]
      ,[FiscalYearEndDate]
      ,[FiscalPeriod]
      ,[FiscalPeriodStartDate]
      ,[FiscalPeriodEndDate]
      ,[FiscalQuarter]
      ,[FiscalQuarterStartDate]
      ,[FiscalQuarterEndDate]
      ,[FiscalWeek]
      ,[FiscalWeekStartDate]
      ,[FiscalWeekEndDate]
      ,[FiscalYearPeriod]
      ,[FiscalYearQuarter]
      ,[FiscalYearWeek]
      ,[FiscalYearConsecutiveNumber]
      ,[FiscalPeriodConsecutiveNumber]
      ,[FiscalQuarterConsecutiveNumber]
      ,[FiscalWeekConsecutiveNumber]
      ,[t_applicationId]
      ,[t_jobId]
      ,[t_lastDtm]
      ,[t_lastActionBy]
      ,[t_filePath]
	)
	SELECT
	 [FiscalYearVariant]
    ,CASE [CalendarDate]
		WHEN '00000000' THEN '19000101' 
		ELSE CONVERT([date], [CalendarDate], 112) 
	 END AS [CalendarDate]
    ,CONVERT([char](4), [FiscalYear]) AS [FiscalYear]
    ,CASE [FiscalYearStartDate]
		WHEN '00000000' THEN '19000101' 
		ELSE CONVERT([date], [FiscalYearStartDate], 112) 
	 END AS [FiscalYearStartDate]
    ,CASE [FiscalYearEndDate]
		WHEN '00000000' THEN '19000101' 
		ELSE CONVERT([date], [FiscalYearEndDate], 112) 
	 END AS [FiscalYearEndDate]
    ,CONVERT([char](3), [FiscalPeriod]) AS [FiscalPeriod]
    ,CASE [FiscalPeriodStartDate]
		WHEN '00000000' THEN '19000101' 
		ELSE CONVERT([date], [FiscalPeriodStartDate], 112) 
	 END AS [FiscalPeriodStartDate]
    ,CASE [FiscalPeriodEndDate]
		WHEN '00000000' THEN '19000101' 
		ELSE CONVERT([date], [FiscalPeriodEndDate], 112) 
	 END AS [FiscalPeriodEndDate]
    ,CONVERT([char](1), [FiscalQuarter]) AS [FiscalQuarter]
    ,CASE [FiscalQuarterStartDate]
		WHEN '00000000' THEN '19000101' 
		ELSE CONVERT([date], [FiscalQuarterStartDate], 112) 
	 END AS [FiscalQuarterStartDate]
    ,CASE [FiscalQuarterEndDate]
		WHEN '00000000' THEN '19000101' 
		ELSE CONVERT([date], [FiscalQuarterEndDate], 112) 
	 END AS [FiscalQuarterEndDate]
    ,CONVERT([char](2), [FiscalWeek]) AS [FiscalWeek]
    ,CASE [FiscalWeekStartDate]
		WHEN '00000000' THEN '19000101' 
		ELSE CONVERT([date], [FiscalWeekStartDate], 112) 
	 END AS [FiscalWeekStartDate]
    ,CASE [FiscalWeekEndDate]
		WHEN '00000000' THEN '19000101' 
		ELSE CONVERT([date], [FiscalWeekEndDate], 112) 
	 END AS [FiscalWeekEndDate]
    ,CONVERT([char](7), [FiscalYearPeriod]) AS [FiscalYearPeriod]
    ,CONVERT([char](5), [FiscalYearQuarter]) AS [FiscalYearQuarter]
    ,CONVERT([char](6), [FiscalYearWeek]) AS [FiscalYearWeek]
    ,CONVERT(INT, [FiscalYearConsecutiveNumber])
    ,CONVERT(INT, [FiscalPeriodConsecutiveNumber])
    ,CONVERT(INT, [FiscalQuarterConsecutiveNumber])
    ,CONVERT(INT, [FiscalWeekConsecutiveNumber])
	,@t_applicationId AS t_applicationId
	,@t_jobId AS t_jobId
	,@t_lastDtm AS t_lastDtm
	,@t_lastActionBy AS t_lastActionBy
	,@t_filePath AS t_filePath
	FROM [base_s4h_uat_caa].[I_FiscalCalendarDate_staging]
END