CREATE TABLE [base_s4h_cax].[I_CalendarDate](
  [CalendarDate] date NOT NULL
, [CalendarYear] char(4) -- collate Latin1_General_100_BIN2
, [CalendarQuarter] char(1) -- collate Latin1_General_100_BIN2
, [CalendarMonth] char(2) -- collate Latin1_General_100_BIN2
, [CalendarWeek] char(2) -- collate Latin1_General_100_BIN2
, [CalendarDay] char(2) -- collate Latin1_General_100_BIN2
, [YearMonth] char(6) -- collate Latin1_General_100_BIN2
, [YearQuarter] char(5) -- collate Latin1_General_100_BIN2
, [YearWeek] char(6) -- collate Latin1_General_100_BIN2
, [WeekDay] char(1) -- collate Latin1_General_100_BIN2
, [FirstDayOfWeekDate] date
, [FirstDayOfMonthDate] date
, [CalendarDayOfYear] char(3) -- collate Latin1_General_100_BIN2
, [YearDay] char(7) -- collate Latin1_General_100_BIN2
, [t_applicationId]       VARCHAR (32)
, [t_jobId]               VARCHAR (36)
, [t_jobDtm]              DATETIME
, [t_jobBy]        		  NVARCHAR (128)
, [t_extractionDtm]		  DATETIME
, [t_filePath]            NVARCHAR (1024)
, CONSTRAINT [PK_I_CalendarDate] PRIMARY KEY NONCLUSTERED (
    [CalendarDate]
  ) NOT ENFORCED
)
WITH (
  HEAP
)
