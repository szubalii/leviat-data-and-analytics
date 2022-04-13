CREATE PROC [edw].[sp_load_dim_Calendar] 
  @t_jobId [varchar](36)
, @t_jobDtm [datetime]
, @t_lastActionCd [varchar](1)
, @t_jobBy [nvarchar](128)
AS
BEGIN

    IF OBJECT_ID('syndw_xxxx_sls_d_euw_001.edw.dim_Calendar', 'U') is not null TRUNCATE TABLE [edw].[dim_Calendar]

    INSERT INTO [edw].[dim_Calendar]( [CalendarDate]
                                    , [CalendarYear]
                                    , [CalendarQuarter]
                                    , [CalendarMonthNumber]
                                    , [CalendarMonth]
                                    , [CalendarWeek]
                                    , [CalendarDay]
                                    , [YearMonth]
                                    , [YearQuarter]
                                    , [YearWeek]
                                    , [WeekDay]
                                    , [FirstDayOfWeekDate]
                                    , [FirstDayOfMonthDate]
                                    , [CalendarDayOfYear]
                                    , [YearDay]
                                    , [t_applicationId]
                                    , [t_jobId]
                                    , [t_jobDtm]
                                    , [t_lastActionCd]
                                    , [t_jobBy])
    SELECT [CalendarDate]
         , [CalendarYear]
         , [CalendarQuarter]
         , cd.[CalendarMonth]     
         , cm.[CalendarMonthName]
         , [CalendarWeek]
         , [CalendarDay]
         , [YearMonth]
         , [YearQuarter]
         , [YearWeek]
         , [WeekDay]
         , [FirstDayOfWeekDate]
         , [FirstDayOfMonthDate]
         , [CalendarDayOfYear]
         , [YearDay]
         , cd.t_applicationId
         , @t_jobId               AS t_jobId
         , @t_jobDtm              AS t_jobDtm
         , @t_lastActionCd        AS t_lastActionCd
         , @t_jobBy               AS t_jobBy
    FROM [base_s4h_uat_caa].[I_CalendarDate] cd
             INNER JOIN [base_s4h_uat_caa].[I_CalendarMonthName] cm
                        ON cd.[CalendarMonth] = cm.[CalendarMonth]

END