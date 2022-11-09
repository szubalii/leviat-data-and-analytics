CREATE TABLE [base_ancon_uk].[MAPPING_ITEMGROUP_ANUK](
	[ITEMGROUPID]       [NVARCHAR](60)      NOT NULL,
	[ITEMGROUPNAME]     [NVARCHAR](100)     NOT NULL,
	[PRODUCTGROUPID]    [NVARCHAR](10)      NOT NULL,
	[t_applicationId]   [VARCHAR](32)       NULL,
    [t_jobId]           [VARCHAR](36)       NULL,
    [t_jobDtm]          [DATETIME],
    [t_jobBy]           [NVARCHAR](128)     NULL,
    [t_extractionDtm]   [DATETIME],
    [t_filePath]        [NVARCHAR](1024)    NULL,
	CONSTRAINT [PK_MAPPING_ITEMGROUP_ANUK] PRIMARY KEY NONCLUSTERED (
	[ITEMGROUPID]
)  NOT ENFORCED
) WITH (HEAP, DISTRIBUTION = ROUND_ROBIN)