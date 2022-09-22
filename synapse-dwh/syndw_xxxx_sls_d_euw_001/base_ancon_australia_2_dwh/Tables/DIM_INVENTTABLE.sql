CREATE TABLE [base_ancon_australia_2_dwh].[DIM_INVENTTABLE](
	[DW_Id] [bigint] NOT NULL,
	[DATAAREAID] [nvarchar](4) NULL,
	[ITEMID] [nvarchar](20) NULL,
	[ITEMNAME] [nvarchar](60) NULL,
	[ADUTYPECRHCA] [nvarchar](20) NULL,
	[ITEMGROUPID] [nvarchar](10) NULL,
	[DW_Batch] [bigint] NULL,
	[DW_SourceCode] [varchar](15) NOT NULL,
	[DW_TimeStamp] [datetime] NOT NULL,
	[t_applicationId] VARCHAR    (32)  NULL,
    [t_jobId]         VARCHAR    (36)  NULL,
    [t_jobDtm]        DATETIME,
    [t_jobBy]         NVARCHAR  (128)  NULL,
    [t_extractionDtm] DATETIME,
    [t_filePath]      NVARCHAR (1024)  NULL
 CONSTRAINT [PK_DIM_INVENTTABLE] PRIMARY KEY NONCLUSTERED 
(
	[DW_Id] ASC
)NOT ENFORCED
) WITH (HEAP, DISTRIBUTION = ROUND_ROBIN);