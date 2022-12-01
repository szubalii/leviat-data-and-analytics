CREATE TABLE [base_isedio].[ITEMTABLE_ISUK_orig](
	[DATAAREAID]            [nvarchar](255)     NULL,
	[ITEMID]                [nvarchar](255)     NOT NULL,
	[ITEMNAME]              [nvarchar](255)     NULL,
	[MMITCL]                [nvarchar](255)     NULL,
	[PRODUCTGROUPID]        [nvarchar](255)     NULL,
	[t_applicationId]       [VARCHAR](32)       NULL,
    [t_jobId]               [VARCHAR](36)       NULL,
    [t_jobDtm]              [DATETIME],
    [t_jobBy]               [NVARCHAR](128)     NULL,
    [t_extractionDtm]       [DATETIME],
    [t_filePath]            [NVARCHAR](1024)    NULL,
	CONSTRAINT [PK_ITEMTABLE_ISUK_orig] PRIMARY KEY NONCLUSTERED (
	[ITEMID]
)  NOT ENFORCED
) WITH (HEAP, DISTRIBUTION = ROUND_ROBIN)