CREATE TABLE [base_tx_crh_2_dwh].[DIM_CUSTINVOICEJOUR](
	[DW_Id] [bigint] IDENTITY(1,1) NOT NULL,
	[DATAAREAID] [nvarchar](4) NULL,
	[INVOICEDATE] [datetime] NULL,
	[INVOICEID] [nvarchar](20) NULL,
	[INVOICEACCOUNT] [nvarchar](20) NULL,
	[DLVMODE] [nvarchar](10) NULL,
	[DLVZIPCODE] [nvarchar](10) NULL,
	[ORDERACCOUNT] [nvarchar](20) NULL,
	[DW_Batch] [bigint] NULL,
	[DW_SourceCode] [varchar](15) NOT NULL,
	[DW_TimeStamp] [datetime] NOT NULL,
 CONSTRAINT [PK_DIM_CUSTINVOICEJOUR] PRIMARY KEY NONCLUSTERED 
(
	[DW_Id] ASC
)NOT ENFORCED
)