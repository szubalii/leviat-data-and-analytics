CREATE VIEW [dm_sales].[vw_dim_Calendar] AS

SELECT [CalendarDate]        as [Date]
     , [CalendarYear]        as [Year]
     , [CalendarQuarter]     as [Quarter]
     , [CalendarMonthNumber] as [MonthNumber]
     , [CalendarMonth]       as [Month]
     , [CalendarWeek]        as [Week]
     , [CalendarDay]         as [Day]
     , [YearMonth]
     , [YearQuarter]
     , [YearWeek]
     , [WeekDay]
     , [FirstDayOfWeekDate]
     , [FirstDayOfMonthDate]
     , [CalendarDayOfYear]
     , [YearDay]
FROM [edw].[dim_Calendar]
where CAST([CalendarYear] AS integer) >= 2019
  and CAST([CalendarYear] AS integer) <= YEAR(CONVERT(date, GETDATE())) + 3
