CREATE TABLE [base_dw_halfen_0_hlp].[CALENDAR](
	[DATAAREAID] [nvarchar](8) NULL,
	[CALENDARDATE] [datetime] NULL,
	[YEAR] [smallint] NULL,
	[MONTH] [smallint] NULL,
	[DAY] [smallint] NULL,
	[WEEKDAY] [smallint] NULL,
	[WEEKDAY_A] [nchar](3) NULL,
	[DAYOFYEAR] [smallint] NULL,
	[DATEFLAG] [nchar](1) NULL,
	[WORKDAY_ACT] [smallint] NULL,
	[WORKDAY_SUM] [smallint] NULL,
	[DISTRIBUTIONCOMPANYGROUP] [nvarchar](50) NULL
)