CREATE TABLE [base_dw_halfen_0_hlp].[PRODUCTLINE](
	[PRODUCTLINEKEY] [tinyint] NOT NULL,
	[PRODUCTLINEID] [nvarchar](10) NOT NULL,
	[PRODUCTLINEDESC] [nvarchar](60) NOT NULL,
	[PRODUCTRANGEID] [nvarchar](10) NOT NULL,
	[CRHPRODUCTGROUPID] [nvarchar](10) NOT NULL,
	[t_applicationId] VARCHAR    (32)  NULL,
    [t_jobId]         VARCHAR    (36)  NULL,
    [t_jobDtm]        DATETIME,
    [t_jobBy]         NVARCHAR  (128)  NULL,
    [t_extractionDtm] DATETIME,
    [t_filePath]      NVARCHAR (1024)  NULL
) WITH (HEAP, DISTRIBUTION = ROUND_ROBIN);