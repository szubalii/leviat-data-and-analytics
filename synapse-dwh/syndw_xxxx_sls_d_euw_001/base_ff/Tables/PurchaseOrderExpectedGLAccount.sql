CREATE TABLE base_ff.PurchaseOrderExpectedGLAccount
(

    [GLAccountID]                  NVARCHAR(10) NOT NULL,
    [t_applicationId] [varchar](32) NULL,
	[t_jobId] [varchar](36) NULL,
	[t_jobDtm] [datetime] NULL,
	[t_jobBy] [varchar](128) NULL,
	[t_filePath] [nvarchar](1024) NULL,
    CONSTRAINT [PK_PurchaseOrderExpectedGLAccount] PRIMARY KEY NONCLUSTERED ([GLAccountID]) NOT ENFORCED
)
WITH (HEAP, DISTRIBUTION = REPLICATE);