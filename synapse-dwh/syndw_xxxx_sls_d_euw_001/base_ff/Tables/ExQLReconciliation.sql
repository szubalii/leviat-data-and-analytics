﻿CREATE TABLE [base_ff].[ExQLReconciliation] (
    [ReportingEntity]               NVARCHAR(40),
    [CompanyCode]                   NVARCHAR(4),
    [ExQLReportingEntity]           NVARCHAR(20),
    [YTD]                           DATE,
    [ExQLValueIn$MM]                DECIMAL(15, 3),
    [t_applicationId] [varchar](32) NULL,
	[t_jobId] [varchar](36) NULL,
	[t_jobDtm] [datetime] NULL,
	[t_jobBy] [varchar](128) NULL,
	[t_filePath] [nvarchar](1024) NULL,
    CONSTRAINT [PK_ExQLReconciliation] PRIMARY KEY NONCLUSTERED (
        [CompanyCode],
        [ExQLReportingEntity]
    ) NOT ENFORCED
)
WITH (HEAP, DISTRIBUTION = REPLICATE);