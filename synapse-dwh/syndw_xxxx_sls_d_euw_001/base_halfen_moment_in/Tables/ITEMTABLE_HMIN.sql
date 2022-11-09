CREATE TABLE [base_tx_ca_0_hlp].[ITEMTABLE_HMIN](
	[ITEMNAME]              [NVARCHAR](255)     NULL,
	[ITEMID]                [NVARCHAR](255)     NOT NULL,
	[CRHPRODUCTGROUPID]     [NVARCHAR](255)     NULL,
	[CRHPRODUCTGROUPNAME]   [NVARCHAR](255)     NULL,
	[MAINGROUPID]           [NVARCHAR](255)     NULL,
	[MAINGROUPNAME]         [NVARCHAR](255)     NULL,
	[PRODUCTPILLAR]         [NVARCHAR](255)     NULL,
	[t_applicationId]       [VARCHAR](32)       NULL,
    [t_jobId]               [VARCHAR](36)       NULL,
    [t_jobDtm]              [DATETIME],
    [t_jobBy]               [NVARCHAR](128)     NULL,
    [t_extractionDtm]       [DATETIME],
    [t_filePath]            [NVARCHAR](1024)    NULL,
	CONSTRAINT [PK_ITEMTABLE_HMIN] PRIMARY KEY NONCLUSTERED (
	[ITEMID]
)  NOT ENFORCED
) WITH (HEAP, DISTRIBUTION = ROUND_ROBIN)