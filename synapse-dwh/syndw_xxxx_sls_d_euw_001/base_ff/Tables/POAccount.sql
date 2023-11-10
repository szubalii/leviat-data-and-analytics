CREATE TABLE base_ff.POAccount
(

    [GLAccountID]                  NVARCHAR(10) NOT NULL,
    [GLAccountDescription]         NVARCHAR(128),
    [t_applicationId] [varchar](32) NULL,
	[t_jobId] [varchar](36) NULL,
	[t_jobDtm] [datetime] NULL,
	[t_jobBy] [varchar](128) NULL,
	[t_filePath] [nvarchar](1024) NULL,
    CONSTRAINT [PK_POAccount] PRIMARY KEY NONCLUSTERED ([GLAccountID]) NOT ENFORCED
)
WITH (HEAP, DISTRIBUTION = REPLICATE);