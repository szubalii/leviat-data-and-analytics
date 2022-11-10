CREATE TABLE [base_halfen_moment_ph].[CUSTINVOICETRANS_HMPH](
	[Dataareaid]            [NVARCHAR](8)           NULL,
	[Accountingdate]        [DATETIME]              NULL,
	[Invoiceid]             [NVARCHAR](20)          NULL,
	[Itemid]                [NVARCHAR](100)         NULL,
	[Qty]                   [INT]                   NULL,
	[CustomerNo]            [NVARCHAR](100)         NULL,
	[Customername]          [NVARCHAR](200)         NULL,
	[DeliveryCountryID]     [NVARCHAR](3)           NULL,
	[ProductSalesLocal]     [DECIMAL](38, 12)       NULL,
	[OtherSalesLocal]       [DECIMAL](38, 12)       NULL,
	[CostAmountLocal]       [DECIMAL](38, 12)       NULL,
	[Leer]                  [NVARCHAR](10)          NULL,
	[Margin_%]              [NVARCHAR](20)          NULL,
	[t_applicationId]       [VARCHAR](32)           NULL,
    [t_jobId]               [VARCHAR](36)           NULL,
    [t_jobDtm]              [DATETIME],
    [t_jobBy]               [NVARCHAR](128)         NULL,
    [t_extractionDtm]       [DATETIME],
    [t_filePath]            [NVARCHAR](1024)        NULL
) WITH (HEAP, DISTRIBUTION = ROUND_ROBIN)

