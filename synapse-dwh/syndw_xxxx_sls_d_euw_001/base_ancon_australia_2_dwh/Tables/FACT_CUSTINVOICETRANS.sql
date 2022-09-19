CREATE TABLE [base_ancon_australia_2_dwh].[FACT_CUSTINVOICETRANS](
	[DW_Id] [bigint] IDENTITY(1,1) NOT NULL,
	[DATAAREAID] [nvarchar](4) NULL,
	[SALESID] [nvarchar](20) NULL,
	[INVOICEID] [nvarchar](20) NULL,
	[LINENUM] [decimal](38, 12) NULL,
	[INVOICEDATE] [datetime] NULL,
	[ITEMID] [nvarchar](20) NULL,
	[DLVCOUNTRYREGIONID] [nvarchar](10) NULL,
	[QTY] [decimal](38, 12) NULL,
	[LINEAMOUNT] [decimal](38, 12) NULL,
	[LINEAMOUNTMST] [decimal](38, 12) NULL,
	[CUSTOMERNO] [nvarchar](20) NULL,
	[CostAmount] [decimal](38, 12) NULL,
	[INVENTTRANSID] [nvarchar](24) NULL,
	[ORIGSALESID] [nvarchar](20) NULL,
	[DIMENSION] [nvarchar](10) NULL,
	[DIMENSION2_] [nvarchar](10) NULL,
	[DIMENSION3_] [nvarchar](10) NULL,
	[DIMENSION4_] [nvarchar](10) NULL,
	[DIMENSION5_] [nvarchar](10) NULL,
	[DIMENSION6_] [nvarchar](10) NULL,
	[DW_Batch] [bigint] NULL,
	[DW_SourceCode] [varchar](15) NOT NULL,
	[DW_TimeStamp] [datetime] NOT NULL,
 CONSTRAINT [PK_FACT_CUSTINVOICETRANS] PRIMARY KEY NONCLUSTERED 
(
	[DW_Id] ASC
)NOT ENFORCED
)
GO
ALTER TABLE [base_ancon_australia_2_dwh].[FACT_CUSTINVOICETRANS] ADD  CONSTRAINT [DF_FACT_CUSTINVOICETRANS_DW_SourceCode]  DEFAULT ('Unknown') FOR [DW_SourceCode]
GO
ALTER TABLE [base_ancon_australia_2_dwh].[FACT_CUSTINVOICETRANS] ADD  CONSTRAINT [DF_FACT_CUSTINVOICETRANS_DW_TimeStamp]  DEFAULT (getdate()) FOR [DW_TimeStamp]
GO