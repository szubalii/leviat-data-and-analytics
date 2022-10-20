CREATE TABLE [base_tx_ca_0_hlp].[INVOICEDFREIGHT_ANUK](
	[Accountingdate] [datetime] NULL,
	[InvoicedFreightLocal] [decimal](38, 12) NULL,
	[PackingSlipID] [nvarchar](20) NULL
)  NOT ENFORCED
) WITH (HEAP, DISTRIBUTION = ROUND_ROBIN)