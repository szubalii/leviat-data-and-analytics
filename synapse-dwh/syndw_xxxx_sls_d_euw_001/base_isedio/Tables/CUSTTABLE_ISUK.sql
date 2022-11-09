CREATE TABLE [base_isedio].[CUSTTABLE_ISUK](
	[DATAAREAID]        [NVARCHAR](255)         NULL,
	[CUSTOMERID]        [NVARCHAR](255)         NOT NULL,
	[CUSTOMERNAME]      [NVARCHAR](255)         NULL,
	[INOUT]             [NVARCHAR](255)         NULL,
	[CUSTOMERPILLAR]    [NVARCHAR](255)         NULL,
	[DIMENSION3_]       [NVARCHAR](255)         NULL,
	[t_applicationId]   [VARCHAR](32)           NULL,
    [t_jobId]           [VARCHAR](36)           NULL,
    [t_jobDtm]          [DATETIME],
    [t_jobBy]           [NVARCHAR](128)         NULL,
    [t_extractionDtm]   [DATETIME],
    [t_filePath]        [NVARCHAR](1024)        NULL,
	CONSTRAINT [PK_CUSTTABLE_ISUK] PRIMARY KEY NONCLUSTERED (
	[CUSTOMERID]
) NOT ENFORCED
) WITH (HEAP, DISTRIBUTION = ROUND_ROBIN)