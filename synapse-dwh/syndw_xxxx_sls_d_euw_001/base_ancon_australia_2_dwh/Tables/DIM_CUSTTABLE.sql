CREATE TABLE [base_ancon_australia_2_dwh].[DIM_CUSTTABLE](
	[DW_Id] [bigint] IDENTITY(1,1) NOT NULL,
	[ACCOUNTNUM] [nvarchar](20) NULL,
	[DATAAREAID] [nvarchar](4) NULL,
	[NAME] [nvarchar](60) NULL,
	[STATISTICSGROUP] [nvarchar](10) NULL,
	[DIMENSION3_] [nvarchar](10) NULL,
	[DIMENSION] [nvarchar](10) NULL,
	[DIMENSION2_] [nvarchar](10) NULL,
	[DIMENSION4_] [nvarchar](10) NULL,
	[DIMENSION5_] [nvarchar](10) NULL,
	[DIMENSION6_] [nvarchar](10) NULL,
	[DW_Batch] [bigint] NULL,
	[DW_SourceCode] [varchar](15) NOT NULL,
	[DW_TimeStamp] [datetime] NOT NULL,
 CONSTRAINT [PK_DIM_CUSTTABLE] PRIMARY KEY NONCLUSTERED 
(
	[DW_Id] ASC
)NOT ENFORCED
)