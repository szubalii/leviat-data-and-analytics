CREATE VIEW [edw].[vw_FiscalCalendar]
AS
SELECT
    [FiscalYearVariant]
  , [CalendarDate]
  , [FiscalYear]
  , [FiscalYearStartDate]
  , [FiscalYearEndDate]
  , [FiscalPeriod]
  , [FiscalPeriodStartDate]
  , [FiscalPeriodEndDate]
  , [FiscalQuarter]
  , [FiscalQuarterStartDate]
  , [FiscalQuarterEndDate]
  , [FiscalWeek]
  , [FiscalWeekStartDate]
  , [FiscalWeekEndDate]
  , [FiscalYearPeriod]
  , [FiscalYearQuarter]
  , [FiscalYearWeek]
  --, [FiscalYearConsecutiveNumber]
  --, [FiscalPeriodConsecutiveNumber]
  --, [FiscalQuarterConsecutiveNumber]
  --, [FiscalWeekConsecutiveNumber]
FROM
  [base_s4h_cax].[I_FiscalCalendarDate]
