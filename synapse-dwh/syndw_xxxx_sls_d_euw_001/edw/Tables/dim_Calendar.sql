CREATE TABLE [edw].[dim_Calendar]
(
-- Date
    [CalendarDate]          date NOT NULL,
    [CalendarYear]          char(4),
    [CalendarQuarter]       char(1),
    [CalendarMonthNumber]   char(2),
    [CalendarMonth]         nvarchar(12),
    [CalendarWeek]          char(2),
    [CalendarDay]           char(2),
    [YearMonth]             char(6),
    [YearQuarter]           char(5),
    [YearWeek]              char(6),
    [WeekDay]               char(1),
    [FirstDayOfWeekDate]    date,
    [FirstDayOfMonthDate]   date,
    [LastDayOfMonthDate]    date,    
    [CalendarDayOfYear]     char(3),
    [YearDay]               char(7),
    [t_applicationId]       VARCHAR (32),
    [t_jobId]               VARCHAR (36),
    [t_jobDtm]              DATETIME,
    [t_lastActionCd]        VARCHAR(1),
    [t_jobBy]               NVARCHAR(128),
    CONSTRAINT [PK_dim_Calendar] PRIMARY KEY NONCLUSTERED ([CalendarDate]) NOT ENFORCED
)
    WITH
        (
        DISTRIBUTION = REPLICATE, HEAP )
GO



