CREATE TABLE base_ff.OrderStatus (

	[SalesDocumentTypeID]  NVARCHAR(4),
	[SalesDocumentType]  NVARCHAR(20),
    [Status_Open]  NVARCHAR(17),
	[Status_Closed] NVARCHAR(17),
    [t_applicationId] [varchar](32) NULL,
	[t_jobId] [varchar](36) NULL,
	[t_jobDtm] [datetime] NULL,
	[t_jobBy] [varchar](128) NULL,
	[t_filePath] [nvarchar](1024) NULL

)
WITH (HEAP, DISTRIBUTION = REPLICA