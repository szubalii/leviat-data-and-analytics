CREATE TABLE [base_tx_ca_0_hlp].[CUSTINVOICETRANS_ANME](
	[Accountingdate]        [DATETIME]              NULL,
	[Invoiceid]             [NVARCHAR](20)          NOT NULL,
	[Salesid]               [NVARCHAR](20)          NULL,
	[Linenum]               [SMALLINT]              NOT NULL,
	[Itemname]              [NVARCHAR](200)         NULL,
	[Itemid]                [NVARCHAR](40)          NULL,
	[Qty]                   [DECIMAL](38, 12)       NULL,
	[Customername]          [NVARCHAR](200)         NULL,
	[CustomerNo]            [NVARCHAR](20)          NULL,
	[DeliveryCountryID]     [NVARCHAR](3)           NULL,
	[ProductSalesLocal]     [DECIMAL](38, 12)       NULL,
	[OtherSalesLocal]       [DECIMAL](38, 12)       NULL,
	[FreightLocal]          [DECIMAL](38, 12)       NULL,
	[Cost_per_Quickbook]    [DECIMAL](38, 12)       NULL,
	[CostAmountLocal]       [DECIMAL](38, 12)       NULL,
	[Leer]                  [NVARCHAR](10)          NULL,
	[Margin_%]              [NVARCHAR](10)          NULL,
	[Quickbook_check]       [DECIMAL](38, 12)       NULL,
	[t_applicationId]       [VARCHAR](32)           NULL,
    [t_jobId]               [VARCHAR](36)           NULL,
    [t_jobDtm]              [DATETIME],
    [t_jobBy]               [NVARCHAR](128)         NULL,
    [t_extractionDtm]       [DATETIME],
    [t_filePath]            [NVARCHAR](1024)        NULL,
	CONSTRAINT [PK_CUSTINVOICETRANS_ANME] PRIMARY KEY NONCLUSTERED (
        [Invoiceid],[Linenum]
    ) NOT ENFORCED
) WITH (HEAP, DISTRIBUTION = ROUND_ROBIN)
