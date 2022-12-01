﻿CREATE TABLE [base_halfen_moment_my].[CUSTINVOICETRANS_HMMY](
	[DATAAREAID]            [NVARCHAR](8)           NOT NULL,
	[SALESID]               [NVARCHAR](20)          NULL,
	[INVOICEID]             [NVARCHAR](20)          NOT NULL,
	[LINENUM]               [SMALLINT]              NOT NULL,
	[INVENTTRANSID]         [NVARCHAR](20)          NULL,
	[ACCOUNTINGDATE]        [DATETIME]              NOT NULL,
	[CUSTOMERNO]            [NVARCHAR](100)         NOT NULL,
	[ITEMID]                [NVARCHAR](100)         NOT NULL,
	[DELIVERYCOUNTRYID]     [NVARCHAR](2)           NOT NULL,
	[PACKINGSLIPID]         [NVARCHAR](20)          NULL,
	[QTY]                   [NUMERIC](38, 12)       NOT NULL,
	[PRODUCTSALESLOCAL]     [NUMERIC](38, 12)       NOT NULL,
	[PRODUCTSALESEUR]       [NUMERIC](38, 12)       NOT NULL,
	[OTHERSALESLOCAL]       [NUMERIC](38, 12)       NOT NULL,
	[OTHERSALESEUR]         [NUMERIC](38, 12)       NOT NULL,
	[ALLOWANCESLOCAL]       [NUMERIC](38, 12)       NOT NULL,
	[ALLOWANCESEUR]         [NUMERIC](38, 12)       NOT NULL,
	[SALES100LOCAL]         [NUMERIC](38, 12)       NOT NULL,
	[SALES100EUR]           [NUMERIC](38, 12)       NOT NULL,
	[FREIGHTLOCAL]          [NUMERIC](38, 12)       NOT NULL,
	[FREIGHTEUR]            [NUMERIC](38, 12)       NOT NULL,
	[COSTAMOUNTLOCAL]       [NUMERIC](38, 12)       NOT NULL,
	[COSTAMOUNTEUR]         [NUMERIC](38, 12)       NOT NULL,
	[t_applicationId]       [VARCHAR](32)           NULL,
    [t_jobId]               [VARCHAR](36)           NULL,
    [t_jobDtm]              [DATETIME],
    [t_jobBy]               [NVARCHAR](128)         NULL,
    [t_extractionDtm]       [DATETIME],
    [t_filePath]            [NVARCHAR](1024)        NULL,
	CONSTRAINT [PK_CUSTINVOICETRANS_HMMY] PRIMARY KEY NONCLUSTERED (
        [INVOICEID],[LINENUM]
    ) NOT ENFORCED
) WITH (HEAP, DISTRIBUTION = ROUND_ROBIN)
