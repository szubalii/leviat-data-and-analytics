CREATE TABLE [base_halfen_moment_sg].[CUSTTABLE_HMSG](
	[DATAAREAID]            [NVARCHAR](8)           NOT NULL,
	[ACCOUNTNUM]            [NVARCHAR](100)         NOT NULL,
	[NAME]                  [NVARCHAR](200)         NOT NULL,
	[INOUT]                 [NVARCHAR](1)           NOT NULL,
	[CUSTOMERPILLAR]        [NVARCHAR](20)          NOT NULL,
	[COMPANYCHAINID]        [NVARCHAR](60)          NOT NULL,
	[DIMENSION3_]           [NVARCHAR](20)          NOT NULL,
	[t_applicationId]       [VARCHAR](32)           NULL,
    [t_jobId]               [VARCHAR](36)           NULL,
    [t_jobDtm]              [DATETIME],
    [t_jobBy]               [NVARCHAR](128)         NULL,
    [t_extractionDtm]       [DATETIME],
    [t_filePath]            [NVARCHAR](1024)        NULL,
	CONSTRAINT [PK_CUSTTABLE_HMSG] PRIMARY KEY NONCLUSTERED (
	[ACCOUNTNUM]
) NOT ENFORCED
) WITH (HEAP, DISTRIBUTION = ROUND_ROBIN)
