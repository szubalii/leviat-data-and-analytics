CREATE TABLE [base_s4h_cax].[I_CalendarMonthName] (
-- Calendar Month Name
  [CalendarMonth]         varchar(10) NOT NULL -- collate Latin1_General_100_BIN2 NOT NULL
, [CalendarMonthName]     nvarchar(60)
, [t_applicationId]       VARCHAR (32)
, [t_jobId]               VARCHAR (36)
, [t_jobDtm]              DATETIME
, [t_jobBy]        		  NVARCHAR (128)
, [t_extractionDtm]		  DATETIME
, [t_filePath]            NVARCHAR (1024)
    CONSTRAINT [PK_I_CalendarMonthName] PRIMARY KEY NONCLUSTERED ([CalendarMonth]) NOT ENFORCED
)
WITH
(
    DISTRIBUTION = ROUND_ROBIN,
    HEAP
)
GO
