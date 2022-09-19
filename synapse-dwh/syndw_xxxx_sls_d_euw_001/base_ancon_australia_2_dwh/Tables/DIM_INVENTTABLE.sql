CREATE TABLE [base_ancon_australia_2_dwh].[DIM_INVENTTABLE](
	[DW_Id] [bigint] IDENTITY(1,1) NOT NULL,
	[DATAAREAID] [nvarchar](4) NULL,
	[ITEMID] [nvarchar](20) NULL,
	[ITEMNAME] [nvarchar](60) NULL,
	[ADUTYPECRHCA] [nvarchar](20) NULL,
	[ITEMGROUPID] [nvarchar](10) NULL,
	[DW_Batch] [bigint] NULL,
	[DW_SourceCode] [varchar](15) NOT NULL,
	[DW_TimeStamp] [datetime] NOT NULL,
 CONSTRAINT [PK_DIM_INVENTTABLE] PRIMARY KEY NONCLUSTERED 
(
	[DW_Id] ASC
)NOT ENFORCED
)
GO
ALTER TABLE [base_ancon_australia_2_dwh].[DIM_INVENTTABLE] ADD  CONSTRAINT [DF_DIM_INVENTTABLE_DW_SourceCode]  DEFAULT ('Unknown') FOR [DW_SourceCode]
GO
ALTER TABLE [base_ancon_australia_2_dwh].[DIM_INVENTTABLE] ADD  CONSTRAINT [DF_DIM_INVENTTABLE_DW_TimeStamp]  DEFAULT (getdate()) FOR [DW_TimeStamp]
GO