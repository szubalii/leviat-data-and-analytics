CREATE TABLE [base_dw_halfen_0_hlp].[ARTICLE](
	[ITEMID] [nvarchar](40) NOT NULL,
	[ITEMNAME] [nvarchar](280) NOT NULL,
	[HALPRODUCTRANGEID] [nvarchar](20) NOT NULL, 
	[HALPRODUCTLINEID] [nvarchar](20) NOT NULL,
	[HALSTATISTICGROUPID] [nvarchar](20) NOT NULL,
	[HPLMAINSTATISTICGROUPID] [nvarchar](20) NOT NULL,
	[HPLSTATISTICGROUPID] [nvarchar](20) NOT NULL,
	[HPLMAINSTATISTICGROUPLONG] [nvarchar](20) NULL,
    [t_applicationId] VARCHAR    (32)  NULL,
    [t_jobId]         VARCHAR    (36)  NULL,
    [t_jobDtm]        DATETIME,
    [t_jobBy]         NVARCHAR  (128)  NULL,
    [t_extractionDtm] DATETIME,
    [t_filePath]      NVARCHAR (1024)  NULL
) WITH
(
    DISTRIBUTION = ROUND_ROBIN,
    HEAP
)
GO
