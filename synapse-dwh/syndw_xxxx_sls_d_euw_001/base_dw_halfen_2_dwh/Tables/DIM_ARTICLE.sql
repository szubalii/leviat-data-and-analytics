CREATE TABLE [base_dw_halfen_2_dwh].[DIM_ARTICLE](
	[DW_Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Item no] [nvarchar](40) NULL,
	[Item description] [nvarchar](280) NULL,
	[Product line] [nvarchar](20) NULL,
	[Product range] [nvarchar](20) NULL,
	[Product group] [nvarchar](20) NULL,
	[Product sub_group] [nvarchar](20) NULL,
	[Main product class] [nvarchar](20) NULL,
	[Product class] [nvarchar](20) NULL,
	[Item no_description] [varchar](500) NULL,
	[DW_Id_Product_Range] [bigint] NULL,
	[Product range range_description] [varchar](500) NULL,
	[DW_Id_Product_Line] [bigint] NULL,
	[Product line_line_description] [varchar](500) NULL,
	[DW_Id_Product_Group] [bigint] NULL,
	[Product group product_group_description] [varchar](50) NULL,
	[DW_Id_Product_Sub_Group] [bigint] NULL,
	[Product sub_group sub_group_description] [varchar](500) NULL,
	[DW_Id_Product_Class] [bigint] NULL,
	[Product class productclass_description] [varchar](500) NULL,
	[Calculation Type] [bigint] NULL,
	[Calculation type description] [nvarchar](1999) NULL,
	[Itemtype] [int] NULL,
	[Itemtype description] [nvarchar](1999) NULL,
	[Itemgroup] [nvarchar](20) NULL,
	[Itemgroup description] [nvarchar](140) NULL,
	[Stop Explode] [int] NULL,
	[Stop Explode description] [varchar](10) NULL,
	[Status] [nvarchar](30) NULL,
	[Primary Vendor] [nvarchar](20) NULL,
	[Intracode] [nvarchar](10) NULL,
	[Intracodename] [nvarchar](250) NULL,
	[Intracode_Name] [nvarchar](200) NULL,
	[CRHProductgroupid] [nvarchar](10) NULL,
	[CRHMAINGROUPID] [nvarchar](10) NULL,
	[CRHPRODUCTPILLARID] [nvarchar](10) NULL,
	[DW_Batch] [bigint] NULL,
	[DW_SourceCode] [varchar](15) NOT NULL,
	[DW_TimeStamp] [datetime] NOT NULL,
 CONSTRAINT [PK_DIM_ARTICLE] PRIMARY KEY NONCLUSTERED 
(
	[DW_Id] ASC
)NOT ENFORCED
)
GO
ALTER TABLE [base_dw_halfen_2_dwh].[DIM_ARTICLE] ADD  CONSTRAINT [DF_DIM_ARTICLE_DW_SourceCode]  DEFAULT ('Unknown') FOR [DW_SourceCode]
GO
ALTER TABLE [base_dw_halfen_2_dwh].[DIM_ARTICLE] ADD  CONSTRAINT [DF_DIM_ARTICLE_DW_TimeStamp]  DEFAULT (getdate()) FOR [DW_TimeStamp]
GO