CREATE TABLE [intm_axbi].[fact_CUSTINVOICETRANS](
	[DATAAREAID] [nvarchar](8) NOT NULL,
	[SALESID] [nvarchar](20) NOT NULL,
	[INVOICEID] [nvarchar](20) NOT NULL,
	[LINENUM] [numeric](7, 2) NOT NULL,
	[INVENTTRANSID] [nvarchar](20) NOT NULL,
	[ACCOUNTINGDATE] [datetime] NOT NULL,
	[CUSTOMERNO] [nvarchar](100) NOT NULL,
	[ITEMID] [nvarchar](100) NOT NULL,
	[DELIVERYCOUNTRYID] [nvarchar](2) NOT NULL,
	[PACKINGSLIPID] [nvarchar](20) NOT NULL,
	[QTY] [numeric](38, 12) NOT NULL,
	[PRODUCTSALESLOCAL] [numeric](38, 12) NOT NULL,
	[PRODUCTSALESEUR] [numeric](38, 12) NOT NULL,
	[OTHERSALESLOCAL] [numeric](38, 12) NOT NULL,
	[OTHERSALESEUR] [numeric](38, 12) NOT NULL,
	[ALLOWANCESLOCAL] [numeric](38, 12) NOT NULL,
	[ALLOWANCESEUR] [numeric](38, 12) NOT NULL,
	[SALES100LOCAL] [numeric](38, 12) NOT NULL,
	[SALES100EUR] [numeric](38, 12) NOT NULL,
	[FREIGHTLOCAL] [numeric](38, 12) NOT NULL,
	[FREIGHTEUR] [numeric](38, 12) NOT NULL,
	[COSTAMOUNTLOCAL] [numeric](38, 12) NOT NULL,
	[COSTAMOUNTEUR] [numeric](38, 12) NOT NULL,
	[t_applicationId] VARCHAR    (32)  NULL,
    [t_jobId]         VARCHAR    (36)  NULL,
    [t_jobDtm]        DATETIME,
    [t_jobBy]         NVARCHAR  (128)  NULL,
    [t_extractionDtm] DATETIME
    CONSTRAINT [PK_fact_CUSTINVOICETRANS] PRIMARY KEY NONCLUSTERED ([DATAAREAID],[INVOICEID],[LINENUM]) NOT ENFORCED
)
WITH (
    DISTRIBUTION = HASH ([INVOICEID]), CLUSTERED COLUMNSTORE INDEX
);