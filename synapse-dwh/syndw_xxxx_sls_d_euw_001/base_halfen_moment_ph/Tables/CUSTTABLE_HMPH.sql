CREATE TABLE [base_halfen_moment_ph].[CUSTTABLE_HMPH](
	[CUSTOMERNAME]          [NVARCHAR](255)         NULL,
	[CUSTOMERID]            [NVARCHAR](100)         NOT NULL,
	[INOUT]                 [NVARCHAR](1)           NULL,
	[CLASSIFICATION_PH]     [NVARCHAR](255)         NULL,
	[CUSTOMERPILLAR]        [NVARCHAR](20)          NULL,
	[DELIVERYCOUNTRYID]     [NVARCHAR](10)          NULL,
	[t_applicationId]       [VARCHAR](32)           NULL,
    [t_jobId]               [VARCHAR](36)           NULL,
    [t_jobDtm]              [DATETIME],
    [t_jobBy]               [NVARCHAR](128)         NULL,
    [t_extractionDtm]       [DATETIME],
    [t_filePath]            [NVARCHAR](1024)        NULL,
	CONSTRAINT [PK_CUSTTABLE_HMPH] PRIMARY KEY NONCLUSTERED (
	[CUSTOMERID]
) NOT ENFORCED
) WITH (HEAP, DISTRIBUTION = ROUND_ROBIN)
