CREATE TABLE [intm_axbi].[dim_ITEMTABLE](
	[DATAAREAID] [nvarchar](8) NOT NULL,
	[ITEMID] [nvarchar](255) NOT NULL,
	[ITEMNAME] [nvarchar](280) NOT NULL,
	[PRODUCTGROUPID] [nvarchar](10) NOT NULL,
	[ITEMGROUPID] [nvarchar](60) NOT NULL,
	[t_applicationId] VARCHAR    (32)  NULL,
    [t_jobId]         VARCHAR    (36)  NULL,
    [t_jobDtm]        DATETIME,
    [t_jobBy]         NVARCHAR  (128)  NULL,
    [t_extractionDtm] DATETIME NULL
    CONSTRAINT [PK_dim_ITEMTABLE] PRIMARY KEY NONCLUSTERED (
        [DATAAREAID],[ITEMID]
    ) NOT ENFORCED
) WITH (HEAP, DISTRIBUTION = REPLICATE);