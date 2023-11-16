CREATE TABLE base_ff.Budget_EPM (
	[CompanyCodeID]                 NVARCHAR(4),
    [ExQLReportingEntity]           NVARCHAR(20),
    [LocalCurrencyID]               NVARCHAR(3),
    [Date]                          DATE,
    [InOutID]                       NVARCHAR(6),
    [ReportedRevenue]               DECIMAL(15, 5),
    [t_applicationId] [varchar](32) NULL,
	[t_jobId] [varchar](36) NULL,
	[t_jobDtm] [datetime] NULL,
	[t_jobBy] [varchar](128) NULL,
	[t_filePath] [nvarchar](1024) NULL

)
WITH (HEAP, DISTRIBUTION = REPLICATE);