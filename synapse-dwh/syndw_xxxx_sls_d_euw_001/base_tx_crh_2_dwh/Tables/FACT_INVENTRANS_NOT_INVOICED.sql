CREATE TABLE [base_tx_crh_2_dwh].[FACT_INVENTRANS_NOT_INVOICED](
	[DW_Id] [bigint] IDENTITY(1,1) NOT NULL,
	[DATAAREAID] [nvarchar](4) NULL,
	[DATEPHYSICAL] [datetime] NULL,
	[DATEFINANCIAL] [datetime] NULL,
	[ITEMID] [nvarchar](20) NULL,
	[INVENTDIMID] [nvarchar](20) NULL,
	[QTY] [decimal](38, 12) NULL,
	[TRANSTYPE] [int] NULL,
	[STATUSISSUE] [int] NULL,
	[INVENTTRANSID] [nvarchar](24) NULL,
	[INVOICEID] [nvarchar](20) NULL,
	[COSTAMOUNTPOSTED] [decimal](38, 12) NULL,
	[COSTAMOUNTADJUSTMENT] [decimal](38, 12) NULL,
	[STATUSRECEIPT] [int] NULL,
	[COSTAMOUNTPHYSICAL] [decimal](38, 12) NULL,
	[CostAmount] [decimal](38, 18) NULL,
	[Cost of Sales] [decimal](38, 2) NULL,
	[Physical Quanity] [decimal](38, 2) NULL,
	[Inbound Qty] [decimal](38, 2) NULL,
	[Outbound Qty] [decimal](38, 2) NULL,
	[Ordered in total] [decimal](38, 2) NULL,
	[Ordered Reseverd] [decimal](38, 2) NULL,
	[Total Available] [decimal](38, 2) NULL,
	[Physical Reserved] [decimal](38, 2) NULL,
	[On Order] [decimal](38, 2) NULL,
	[Available physical] [decimal](38, 2) NULL,
	[INVENTSIZEID] [nvarchar](10) NULL,
	[TRANSREFID] [nvarchar](20) NULL,
	[VALUEMST] [decimal](38, 12) NULL,
	[ValueCalc] [decimal](38, 2) NULL,
	[INVOICEACCOUNT] [nvarchar](20) NULL,
	[SALESGROUP] [nvarchar](10) NULL,
	[BuildingSiteId] [nvarchar](20) NULL,
	[PACKINGSLIPID] [nvarchar](20) NULL,
	[LINEAMOUNTSALESLINE] [decimal](38, 12) NULL,
	[PriceCustpackingslip] [decimal](38, 12) NULL,
	[Country_DwId] [bigint] NULL,
	[Dimension] [nvarchar](10) NULL,
	[DW_Batch] [bigint] NULL,
	[DW_SourceCode] [varchar](15) NOT NULL,
	[DW_TimeStamp] [datetime] NOT NULL,
 CONSTRAINT [PK_FACT_INVENTRANS_NOT_INVOICED] PRIMARY KEY NONCLUSTERED 
(
	[DW_Id] ASC
)NOT ENFORCED
)
GO
ALTER TABLE [base_tx_crh_2_dwh].[FACT_INVENTRANS_NOT_INVOICED] ADD  CONSTRAINT [DF_FACT_INVENTRANS_NOT_INVOICED_DW_SourceCode]  DEFAULT ('Unknown') FOR [DW_SourceCode]
GO
ALTER TABLE [base_tx_crh_2_dwh].[FACT_INVENTRANS_NOT_INVOICED] ADD  CONSTRAINT [DF_FACT_INVENTRANS_NOT_INVOICED_DW_TimeStamp]  DEFAULT (getdate()) FOR [DW_TimeStamp]
GO
