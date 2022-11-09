﻿CREATE TABLE [base_isedio_aus].[CUSTINVOICETRANS_ISAU](
	[Dataareaid]            [NVARCHAR](8)           NULL,
	[Salesid]               [NVARCHAR](20)          NULL,
	[Invoiceid]             [NVARCHAR](20)          NOT NULL,
	[Linenum]               [SMALLINT]              NOT NULL,
	[Accountingdate]        [DATETIME]              NULL,
	[CustomerNo]            [NVARCHAR](20)          NULL,
	[Itemid]                [NVARCHAR](255)         NULL,
	[DeliveryCountryID]     [NVARCHAR](20)          NULL,
	[Qty]                   [DECIMAL](38, 12)       NULL,
	[ProductSalesLocal]     [DECIMAL](38, 12)       NULL,
	[ProductSalesEUR]       [DECIMAL](38, 12)       NULL,
	[OtherSalesLocal]       [DECIMAL](38, 12)       NULL,
	[OtherSalesEUR]         [DECIMAL](38, 12)       NULL,
	[AllowancesLocal]       [DECIMAL](38, 12)       NULL,
	[AllowancesEUR]         [DECIMAL](38, 12)       NULL,
	[Sales100Local]         [DECIMAL](38, 12)       NULL,
	[Sales100EUR]           [DECIMAL](38, 12)       NULL,
	[FreightLocal]          [DECIMAL](38, 12)       NULL,
	[FreightEUR]            [DECIMAL](38, 12)       NULL,
	[CostAmountLocal]       [DECIMAL](38, 12)       NULL,
	[CostAmountEUR]         [DECIMAL](38, 12)       NULL,
	[t_applicationId]       [VARCHAR](32)           NULL,
    [t_jobId]               [VARCHAR](36)           NULL,
    [t_jobDtm]              [DATETIME],
    [t_jobBy]               [NVARCHAR](128)         NULL,
    [t_extractionDtm]       [DATETIME],
    [t_filePath]            [NVARCHAR](1024)        NULL,
	CONSTRAINT [PK_CUSTINVOICETRANS_ISAU] PRIMARY KEY NONCLUSTERED (
        [Invoiceid],[Linenum]
    ) NOT ENFORCED
) WITH (HEAP, DISTRIBUTION = ROUND_ROBIN)
