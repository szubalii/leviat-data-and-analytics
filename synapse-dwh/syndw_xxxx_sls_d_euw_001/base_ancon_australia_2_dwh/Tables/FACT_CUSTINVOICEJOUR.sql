CREATE TABLE [base_ancon_australia_2_dwh].[FACT_CUSTINVOICEJOUR](
	[DW_Id] [bigint] IDENTITY(1,1) NOT NULL,
	[DATAAREAID] [nvarchar](4) NULL,
	[ORDERACCOUNT] [nvarchar](20) NULL,
	[SALESID] [nvarchar](20) NULL,
	[INVOICEID] [nvarchar](20) NULL,
	[INVOICEDATE] [datetime] NULL,
	[NUMBERSEQUENCEGROUP] [nvarchar](10) NULL,
	[DW_Batch] [bigint] NULL,
	[DW_SourceCode] [varchar](15) NOT NULL,
	[DW_TimeStamp] [datetime] NOT NULL
 CONSTRAINT [PK_FACT_CUSTINVOICEJOUR] PRIMARY KEY NONCLUSTERED 
(
	[DW_Id] ASC
) NOT ENFORCED )
GO
ALTER TABLE [base_ancon_australia_2_dwh].[FACT_CUSTINVOICEJOUR] ADD  CONSTRAINT [DF_FACT_CUSTINVOICEJOUR_DW_SourceCode]  DEFAULT ('Unknown') FOR [DW_SourceCode]
GO
ALTER TABLE [base_ancon_australia_2_dwh].[FACT_CUSTINVOICEJOUR] ADD  CONSTRAINT [DF_FACT_CUSTINVOICEJOUR_DW_TimeStamp]  DEFAULT (getdate()) FOR [DW_TimeStamp]
GO