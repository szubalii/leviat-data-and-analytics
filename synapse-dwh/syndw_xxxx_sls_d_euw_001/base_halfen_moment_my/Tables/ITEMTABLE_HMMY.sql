﻿CREATE TABLE [base_halfen_moment_my].[ITEMTABLE_HMMY](
	[DATAAREAID]            [NVARCHAR](255)     NOT NULL,
	[ITEMID]                [NVARCHAR](255)     NOT NULL,
	[ITEMNAME]              [NVARCHAR](255)     NOT NULL,
	[PRODUCTGROUPID]        [NVARCHAR](255)     NOT NULL,
	[ITEMGROUPID]           [NVARCHAR](255)     NOT NULL,
	[t_applicationId]       [VARCHAR](32)       NULL,
    [t_jobId]               [VARCHAR](36)       NULL,
    [t_jobDtm]              [DATETIME],
    [t_jobBy]               [NVARCHAR](128)     NULL,
    [t_extractionDtm]       [DATETIME],
    [t_filePath]            [NVARCHAR](1024)    NULL,
	CONSTRAINT [PK_ITEMTABLE_HMMY] PRIMARY KEY NONCLUSTERED (
	[ITEMID]
)  NOT ENFORCED
) WITH (HEAP, DISTRIBUTION = ROUND_ROBIN)