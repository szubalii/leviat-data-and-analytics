CREATE TABLE [edw].[dim_UserAddress]
-- General CDS View for Address
(

  [UserName] nvarchar(12) NOT NULL
, [UserID] nvarchar(10) 
, [UserClass] nvarchar(12) 
, [t_applicationId]       VARCHAR (32)
, [t_jobId]               VARCHAR (36)
, [t_jobDtm]             DATETIME
, [t_jobBy]        NVARCHAR (128)
, [t_lastActionCd]           VARCHAR(1)
, [t_extractionDtm]             DATETIME
, CONSTRAINT [PK_dim_UserAddress] PRIMARY KEY NONCLUSTERED([UserName]) NOT ENFORCED 
)
WITH ( 
	DISTRIBUTION = REPLICATE,  HEAP
)
