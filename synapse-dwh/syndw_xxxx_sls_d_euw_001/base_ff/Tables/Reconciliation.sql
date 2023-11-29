CREATE TABLE [base_ff].[Reconciliation] (
    [ReportingEntity]               NVARCHAR(40),
    [CompanyCode]                   NVARCHAR(4),
    [ExQLReportingEntity]           NVARCHAR(20),
    [nk_ExQL_Reconciliation]        NVARCHAR(24),
    [YTD]                           DATE,
    [HFMvaluesIN$M]                 DECIMAL(15, 3),
    [t_applicationId] [varchar](32) NULL,
	[t_jobId] [varchar](36) NULL,
	[t_jobDtm] [datetime] NULL,
	[t_jobBy] [varchar](128) NULL,
	[t_filePath] [nvarchar](1024) NULL

)
WITH (HEAP, DISTRIBUTION = REPLICATE);