CREATE TABLE [base_tx_ca_0_hlp].[CUSTINVOICETRANS_ANAC]
(
	[DATAAREAID]            [NVARCHAR](8)           NULL,
	[SALESID]               [NVARCHAR](20)          NULL,
	[INVOICEID]             [NVARCHAR](20)          NOT NULL,
	[LINENUM]               [FLOAT]                 NOT NULL,
	[ACCOUNTINGDATE]        [NVARCHAR](10)          NULL,
	[CUSTOMERNO]            [DECIMAL](18, 0)        NULL,
	[ITEMID]                [NVARCHAR](40)          NULL,
	[DELIVERYCOUNTRYID]     [NVARCHAR](20)          NULL,
	[QTY]                   [FLOAT]                 NULL,
	[PRODUCTSALESLOCAL]     [FLOAT]                 NULL,
	[PRODUCTSALESEUR]       [FLOAT]                 NULL,
	[OTHERSALESLOCAL]       [FLOAT]                 NULL,
	[OTHERSALESEUR]         [FLOAT]                 NULL,
	[ALLOWANCESLOCAL]       [FLOAT]                 NULL,
	[ALLOWANCESEUR]         [FLOAT]                 NULL,
	[SALES100LOCAL]         [FLOAT]                 NULL,
	[SALES100EUR]           [FLOAT]                 NULL,
	[FREIGHTLOCAL]          [FLOAT]                 NULL,
	[FREIGHTEUR]            [FLOAT]                 NULL,
	[COSTAMOUNTLOCAL]       [FLOAT]                 NULL,
	[COSTAMOUNTEUR]         [FLOAT]                 NULL,
	[t_applicationId]       [VARCHAR](32)           NULL,
    [t_jobId]               [VARCHAR](36)           NULL,
    [t_jobDtm]              [DATETIME],
    [t_jobBy]               [NVARCHAR](128)         NULL,
    [t_extractionDtm]       [DATETIME],
    [t_filePath]            [NVARCHAR](1024)        NULL,
	CONSTRAINT [PK_CUSTINVOICETRANS_ANAC] PRIMARY KEY NONCLUSTERED (
        [INVOICEID],[LINENUM]
    ) NOT ENFORCED
) WITH (HEAP, DISTRIBUTION = ROUND_ROBIN)