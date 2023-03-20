CREATE TABLE [intm_axbi].[dim_ITEMGROUP](
	[DATAAREAID] [nvarchar](8) NOT NULL,
	[ITEMGROUPID] [nvarchar](60) NOT NULL,
	[ITEMGROUPNAME] [nvarchar](100) NOT NULL,
	[t_applicationId] VARCHAR    (32)  NULL,
    [t_jobId]         VARCHAR    (36)  NULL,
    [t_jobDtm]        DATETIME,
    [t_jobBy]         NVARCHAR  (128)  NULL,
    [t_extractionDtm] DATETIME NULL
) WITH (HEAP, DISTRIBUTION = REPLICATE);