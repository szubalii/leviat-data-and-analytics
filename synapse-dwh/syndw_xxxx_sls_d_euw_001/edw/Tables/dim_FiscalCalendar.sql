CREATE TABLE [edw].[dim_FiscalCalendarDate] (
    
    [FiscalYearVariant] NVARCHAR(2) NOT NULL  -- Fiscal Year Variant
  , [CalendarDate] DATE NOT NULL  -- Calendar Date
  , [FiscalYear] CHAR(4)  -- Fiscal Year
  , [FiscalYearStartDate] DATE  -- Start Date of Fiscal Year
  , [FiscalYearEndDate] DATE  -- End Date of Fiscal Year
  , [FiscalPeriod] CHAR(3)  -- Fiscal Period
  , [FiscalPeriodStartDate] DATE  -- Start Date of Fiscal Period
  , [FiscalPeriodEndDate] DATE  -- End Date of Fiscal Period
  , [FiscalQuarter] CHAR(1)  -- Fiscal Quarter
  , [FiscalQuarterStartDate] DATE  -- Start Date of Fiscal Quarter
  , [FiscalQuarterEndDate] DATE  -- End Date of Fiscal Quarter
  , [FiscalWeek] CHAR(2)  -- Fiscal Week
  , [FiscalWeekStartDate] DATE  -- Start Date of Fiscal Week
  , [FiscalWeekEndDate] DATE  -- End Date of Fiscal Week
  , [FiscalYearPeriod] CHAR(7)  -- Fiscal Year + Fiscal Period
  , [FiscalYearQuarter] CHAR(5)  -- Fiscal Year + Fiscal Quarter
  , [FiscalYearWeek] CHAR(6)  -- Fiscal Year + Fiscal Week
  , [FiscalYearConsecutiveNumber] INT  -- Fiscal Year (Integer)
  , [FiscalPeriodConsecutiveNumber] INT  -- Fiscal Year Period (Numbering)
  , [FiscalQuarterConsecutiveNumber] INT  -- Fiscal Year Quarter (Numbering)
  , [FiscalWeekConsecutiveNumber] INT  -- Fiscal Year Week (Numbering)
  , [t_applicationId] VARCHAR (32)  -- Application ID
  , [t_jobId] VARCHAR (36)  -- Job ID
  , [t_jobDtm] DATETIME  -- Job Date Time
  , [t_lastActionCd]  VARCHAR(1)
  , [t_jobBy] VARCHAR (128)  -- Job executed by
  , CONSTRAINT [PK_dim_FiscalCalendarDate] PRIMARY KEY NONCLUSTERED(
      [MANDT]
    , [FiscalYearVariant]
    , [CalendarDate]
  ) NOT ENFORCED
) WITH (
  DISTRIBUTION = REPLICATE, HEAP
)
