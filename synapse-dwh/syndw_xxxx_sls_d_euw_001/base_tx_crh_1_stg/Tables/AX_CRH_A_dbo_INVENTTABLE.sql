CREATE TABLE [base_tx_crh_1_stg].[AX_CRH_A_dbo_INVENTTABLE](
	[DW_Id] [bigint] NOT NULL,
	[ADUASCHWITEMGROUP2] [nvarchar](10) NULL,
	[ADUASCHWITEMGROUP2DESCRIPTION] [nvarchar](60) NULL,
	[ADUASCHWITEMGROUP3] [varchar](50) NULL,
	[ADUASCHWITEMGROUP4] [nvarchar](10) NULL,
	[ADUASCHWITEMGROUP4DESCRIPTION] [nvarchar](60) NULL,
	[DATAAREAID] [nvarchar](4) NULL,
	[ITEMID] [nvarchar](20) NULL,
	[ITEMGROUPID] [nvarchar](10) NULL,
	[ItemGroupName] [nvarchar](60) NULL,
	[ITEMNAME] [nvarchar](60) NULL,
	[ADUTYPEMATERIAL] [nvarchar](20) NULL,
	[ADUTYPECRHCA] [nvarchar](20) NULL,
	[ITEMTYPE] [int] NULL,
	[ADUITEMCLASSIFICATION] [int] NULL,
	[ADUCATAREF] [nvarchar](10) NULL,
	[ADUINNOVATIVE] [int] NULL,
	[ADUMARKETLAUNCHDATE] [datetime] NULL,
	[PRODPOOLID] [nvarchar](10) NULL,
	[DIMGROUPID] [nvarchar](10) NULL,
	[DimGroupFrance] [varchar](50) NULL,
	[BOMUNITID] [nvarchar](10) NULL,
	[Stock Unit] [varchar](10) NULL,
	[Purchase Unit] [varchar](10) NULL,
	[Sales Unit] [varchar](10) NULL,
	[NETWEIGHT] [decimal](38, 12) NULL,
	[INVENTSIZEID] [nvarchar](10) NULL,
	[REQGROUPID] [nvarchar](10) NULL,
	[QSS] [varchar](50) NULL,
	[Stock Price] [decimal](38, 2) NULL,
	[Purchase Price] [decimal](38, 2) NULL,
	[ABCVALUE] [int] NULL,
	[ABCREVENUE] [int] NULL,
	[ABCCONTRIBUTIONMARGIN] [int] NULL,
	[MININVENTONHAND] [decimal](38, 12) NULL,
	[MAXINVENTONHAND] [decimal](38, 12) NULL,
	[Stock Price Unit] [decimal](38, 2) NULL,
	[Purchase Price Unit] [decimal](38, 2) NULL,
	[Sales Price Unit] [decimal](38, 2) NULL,
	[Inventory Stopped] [int] NULL,
	[Purchase Stopped] [int] NULL,
	[Sales Stopped] [int] NULL,
	[Stopped3] [varchar](3) NULL,
	[Active/Inactive] [varchar](8) NULL,
	[Inventory Stopped YN] [varchar](3) NULL,
	[Purchase Stopped YN] [varchar](3) NULL,
	[Sales Stopped YN] [varchar](3) NULL,
	[DW_Batch] [bigint] NULL,
	[DW_SourceCode] [varchar](15) NOT NULL,
	[DW_TimeStamp] [datetime] NOT NULL,
 CONSTRAINT [PK_AX_CRH_A_dbo_INVENTTABLE] PRIMARY KEY NONCLUSTERED 
(
	[DW_Id] ASC
)NOT ENFORCED
) WITH (HEAP, DISTRIBUTION = ROUND_ROBIN);