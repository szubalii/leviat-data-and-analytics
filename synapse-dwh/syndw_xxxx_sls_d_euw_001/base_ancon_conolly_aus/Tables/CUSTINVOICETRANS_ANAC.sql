CREATE TABLE [base_ancon_conolly_aus].[CUSTINVOICETRANS_ANAC]
(
	[DATAAREAID]            [NVARCHAR](8)           NULL,
	[SALESID]               [NVARCHAR](20)          NULL,
	[INVOICEID]             [NVARCHAR](20)          NOT NULL,
	[LINENUM]               [SMALLINT]              NOT NULL,
	[ACCOUNTINGDATE]        [NVARCHAR](10)          NULL,
	[CUSTOMERNO]            [INT]                   NULL,
	[ITEMID]                [NVARCHAR](40)          NULL,
	[DELIVERYCOUNTRYID]     [INT]                   NULL,
	[QTY]                   [INT]                   NULL,
	[PRODUCTSALESLOCAL]     [DECIMAL](38,12)        NULL,
	[PRODUCTSALESEUR]       [DECIMAL](38,12)        NULL,
	[OTHERSALESLOCAL]       [DECIMAL](38,12)        NULL,
	[OTHERSALESEUR]         [DECIMAL](38,12)        NULL,
	[ALLOWANCESLOCAL]       [DECIMAL](38,12)        NULL,
	[ALLOWANCESEUR]         [DECIMAL](38,12)        NULL,
	[SALES100LOCAL]         [DECIMAL](38,12)        NULL,
	[SALES100EUR]           [DECIMAL](38,12)        NULL,
	[FREIGHTLOCAL]          [DECIMAL](38,12)        NULL,
	[FREIGHTEUR]            [DECIMAL](38,12)        NULL,
	[COSTAMOUNTLOCAL]       [DECIMAL](38,12)        NULL,
	[COSTAMOUNTEUR]         [DECIMAL](38,12)        NULL,
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