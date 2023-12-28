CREATE TABLE [base_s4h_cax].[I_FactoryCalWorkingDaysPerYr](
  [FactoryCalendar] nvarchar(2) NOT NULL
, [CalendarYear] char(4) NOT NULL -- collate Latin1_General_100_BIN2 NOT NULL
, [Month01WorkingDaysString] nvarchar(31)
, [Month02WorkingDaysString] nvarchar(31)
, [Month03WorkingDaysString] nvarchar(31)
, [Month04WorkingDaysString] nvarchar(31)
, [Month05WorkingDaysString] nvarchar(31)
, [Month06WorkingDaysString] nvarchar(31)
, [Month07WorkingDaysString] nvarchar(31)
, [Month08WorkingDaysString] nvarchar(31)
, [Month09WorkingDaysString] nvarchar(31)
, [Month10WorkingDaysString] nvarchar(31)
, [Month11WorkingDaysString] nvarchar(31)
, [Month12WorkingDaysString] nvarchar(31)
, [FactoryCalYearStartDayValue] char(5) -- collate Latin1_General_100_BIN2
, [NumberOfNonWorkingDays] char(3) -- collate Latin1_General_100_BIN2
, [NumberOfWorkingDays] char(3) -- collate Latin1_General_100_BIN2
, [t_applicationId]       VARCHAR (32)
, [t_jobId]               VARCHAR (36)
, [t_jobDtm]              DATETIME
, [t_jobBy]        		  NVARCHAR (128)
, [t_extractionDtm]		  DATETIME
, [t_filePath]            NVARCHAR (1024)
, CONSTRAINT [PK_I_FactoryCalWorkingDaysPerYr] PRIMARY KEY NONCLUSTERED (
    [FactoryCalendar], [CalendarYear]
  ) NOT ENFORCED
)
WITH (
  HEAP
)
