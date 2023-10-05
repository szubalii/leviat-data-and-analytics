CREATE TABLE [base_s4h_cax].[I_FiscalCalendarDate](
  [TS_SEQUENCE_NUMBER] INTEGER NOT NULL
, [ODQ_CHANGEMODE] CHAR(1)
, [ODQ_ENTITYCNTR] NUMERIC(19,0)
, [MANDT] char(3) NOT NULL -- collate Latin1_General_100_BIN2 NOT NULL
, [FiscalYearVariant] nvarchar(2) NOT NULL
, [CalendarDate] date NOT NULL
, [FiscalYear] char(4) -- collate Latin1_General_100_BIN2
, [FiscalYearStartDate] date
, [FiscalYearEndDate] date
, [FiscalPeriod] char(3) -- collate Latin1_General_100_BIN2
, [FiscalPeriodStartDate] date
, [FiscalPeriodEndDate] date
, [FiscalQuarter] char(1) -- collate Latin1_General_100_BIN2
, [FiscalQuarterStartDate] date
, [FiscalQuarterEndDate] date
, [FiscalWeek] char(2) -- collate Latin1_General_100_BIN2
, [FiscalWeekStartDate] date
, [FiscalWeekEndDate] date
, [FiscalYearPeriod] char(7) -- collate Latin1_General_100_BIN2
, [FiscalYearQuarter] char(5) -- collate Latin1_General_100_BIN2
, [FiscalYearWeek] char(6) -- collate Latin1_General_100_BIN2
, [FiscalYearConsecutiveNumber] int
, [FiscalPeriodConsecutiveNumber] int
, [FiscalQuarterConsecutiveNumber] int
, [FiscalWeekConsecutiveNumber] int
, [t_applicationId]       VARCHAR (32)
, [t_jobId]               VARCHAR (36)
, [t_jobDtm]              DATETIME
, [t_jobBy]        		  NVARCHAR (128)
, [t_extractionDtm]		  DATETIME
, [t_filePath]            NVARCHAR (1024)
, CONSTRAINT [PK_I_FiscalCalendarDate] PRIMARY KEY NONCLUSTERED (
    [TS_SEQUENCE_NUMBER], [MANDT], [FiscalYearVariant], [CalendarDate]
  ) NOT ENFORCED
)
WITH (
  HEAP
)
