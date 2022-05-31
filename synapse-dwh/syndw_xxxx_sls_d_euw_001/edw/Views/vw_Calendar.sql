CREATE VIEW [edw].[vw_Calendar]
	AS SELECT 
		 [CalendarDate]
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
         , EOMONTH([CalendarDate]) as [LastDayOfMonthDate]         
         , [CalendarDayOfYear]
         , [YearDay]
         , cd.t_applicationId
    FROM [base_s4h_cax].[I_CalendarDate] cd
             INNER JOIN [base_s4h_cax].[I_CalendarMonthName] cm
                        ON cd.[CalendarMonth] = cm.[CalendarMonth]