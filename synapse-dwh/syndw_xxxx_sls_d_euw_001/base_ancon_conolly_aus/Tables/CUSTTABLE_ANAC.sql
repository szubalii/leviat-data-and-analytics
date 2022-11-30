CREATE TABLE [base_ancon_conolly_aus].[CUSTTABLE_ANAC](
	[DATAAREAID]            [NVARCHAR](255)         NULL,
	[ACCOUNTNUM]            [INT]                   NOT NULL,
	[NAME]                  [NVARCHAR](255)         NULL,
	[INOUT]                 [NVARCHAR](1)           NULL,
	[CUSTOMERPILLAR]        [NVARCHAR](20)          NULL,
	[t_applicationId]       [VARCHAR](32)           NULL,
    [t_jobId]               [VARCHAR](36)           NULL,
    [t_jobDtm]              [DATETIME],
    [t_jobBy]               [NVARCHAR](128)         NULL,
    [t_extractionDtm]       [DATETIME],
    [t_filePath]            [NVARCHAR](1024)        NULL,
	CONSTRAINT [PK_CUSTTABLE_ANAC] PRIMARY KEY NONCLUSTERED (
	[ACCOUNTNUM]
) NOT ENFORCED
) WITH (HEAP, DISTRIBUTION = ROUND_ROBIN)