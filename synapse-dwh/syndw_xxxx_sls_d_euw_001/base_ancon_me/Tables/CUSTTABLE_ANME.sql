CREATE TABLE [base_tx_ca_0_hlp].[CUSTTABLE_ANME](
	[CUSTOMERID]            [NVARCHAR](255)         NOT NULL,
	[CUSTOMERNAME]          [NVARCHAR](255)         NULL,
	[INOUT]                 [NVARCHAR](255)         NULL,
	[CUSTOMERPILLAR]        [NVARCHAR](255)         NULL,
	[DELIVERYCOUNTRYID]     [NVARCHAR](255)         NULL,
	[t_applicationId]       [VARCHAR](32)           NULL,
    [t_jobId]               [VARCHAR](36)           NULL,
    [t_jobDtm]              [DATETIME],
    [t_jobBy]               [NVARCHAR](128)         NULL,
    [t_extractionDtm]       [DATETIME],
    [t_filePath]            [NVARCHAR](1024)        NULL,
	CONSTRAINT [PK_CUSTTABLE_ANME] PRIMARY KEY NONCLUSTERED (
	[CUSTOMERID]
) NOT ENFORCED
) WITH (HEAP, DISTRIBUTION = ROUND_ROBIN)