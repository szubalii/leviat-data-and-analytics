CREATE TABLE base_ff.CompliantGLAccounts (
	[SAPAccount]                   NVARCHAR(10),
    [SAPAccountName]               NVARCHAR(60),
    [Category]                     NVARCHAR(40),
    [Status]                       NVARCHAR(10),
    [t_applicationId] [varchar](32) NULL,
	[t_jobId] [varchar](36) NULL,
	[t_jobDtm] [datetime] NULL,
	[t_jobBy] [varchar](128) NULL,
	[t_filePath] [nvarchar](1024) NULL

)
WITH (HEAP, DISTRIBUTION = REPLICATE);