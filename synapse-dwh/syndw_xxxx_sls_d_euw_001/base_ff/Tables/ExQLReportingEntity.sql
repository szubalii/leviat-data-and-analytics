CREATE TABLE base_ff.ExQLReportingEntity (

	[CompanyCodeID]     NVARCHAR(5) NULL,
	[ProfitCenterID]    NVARCHAR(10) NULL,
    [ExQLReportingEntity]    NVARCHAR(20) NULL,
    [t_applicationId] [varchar](32) NULL,
	[t_jobId] [varchar](36) NULL,
	[t_jobDtm] [datetime] NULL,
	[t_jobBy] [varchar](128) NULL,
	[t_filePath] [nvarchar](1024) NULL

)
WITH (HEAP, DISTRIBUTION = REPLICATE);