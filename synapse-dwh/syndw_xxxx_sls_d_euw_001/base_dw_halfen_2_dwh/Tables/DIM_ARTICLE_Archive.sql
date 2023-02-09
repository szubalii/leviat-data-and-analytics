CREATE TABLE [base_dw_halfen_2_dwh].[DIM_ARTICLE_Archive]
(
	[DW_Id] [bigint] NOT NULL,
	[Itemno] [nvarchar](40) NULL,
	[Itemdescription] [nvarchar](280) NULL,
	[Productline] [nvarchar](20) NULL,
	[Productrange] [nvarchar](20) NULL,
	[Productgroup] [nvarchar](20) NULL,
	[Productsub_group] [nvarchar](20) NULL,
	[Mainproductclass] [nvarchar](20) NULL,
	[Productclass] [nvarchar](20) NULL,
	[Itemno_description] [varchar](500) NULL,
	[DW_Id_Product_Range] [bigint] NULL,
	[Productrangerange_description] [varchar](500) NULL,
	[DW_Id_Product_Line] [bigint] NULL,
	[Productline_line_description] [varchar](500) NULL,
	[DW_Id_Product_Group] [bigint] NULL,
	[Productgroupproduct_group_description] [varchar](50) NULL,
	[DW_Id_Product_Sub_Group] [bigint] NULL,
	[Productsub_groupsub_group_description] [varchar](500) NULL,
	[DW_Id_Product_Class] [bigint] NULL,
	[Productclassproductclass_description] [varchar](500) NULL,
	[CalculationType] [bigint] NULL,
	[Calculationtypedescription] [nvarchar](1999) NULL,
	[Itemtype] [int] NULL,
	[Itemtypedescription] [nvarchar](1999) NULL,
	[Itemgroup] [nvarchar](20) NULL,
	[Itemgroupdescription] [nvarchar](140) NULL,
	[StopExplode] [int] NULL,
	[StopExplodedescription] [varchar](10) NULL,
	[Status] [nvarchar](30) NULL,
	[PrimaryVendor] [nvarchar](20) NULL,
	[Intracode] [nvarchar](10) NULL,
	[Intracodename] [nvarchar](250) NULL,
	[Intracode_Name] [nvarchar](200) NULL,
	[CRHProductgroupid] [nvarchar](10) NULL,
	[CRHMAINGROUPID] [nvarchar](10) NULL,
	[CRHPRODUCTPILLARID] [nvarchar](10) NULL,
	[DW_Batch] [bigint] NULL,
	[DW_SourceCode] [varchar](15) NOT NULL,
	[DW_TimeStamp] [datetime] NOT NULL,
	[t_applicationId] [varchar](32) NULL,
	[t_jobId] [varchar](36) NULL,
	[t_jobDtm] [datetime] NULL,
	[t_jobBy] [nvarchar](128) NULL,
	[t_extractionDtm] [datetime] NULL,
	[t_filePath] [nvarchar](1024) NULL
   CONSTRAINT [PK_DIM_ARTICLE_Archive] PRIMARY KEY NONCLUSTERED (
        [DW_Id] ASC
    ) NOT ENFORCED
)
WITH
(
	DISTRIBUTION = HASH ([Itemno]),
	CLUSTERED COLUMNSTORE INDEX
);