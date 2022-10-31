CREATE TABLE [edw].[dim_UserAddress]
-- General CDS View for Address
(

  [UserName] nvarchar(12) collate Latin1_General_100_BIN2 NOT NULL
, [UserID] nvarchar(10) collate Latin1_General_100_BIN2
, [UserClass] nvarchar(12) collate Latin1_General_100_BIN2
, [t_applicationId]       VARCHAR (32)
, [t_jobId]               VARCHAR (36)
, [t_jobDtm]             DATETIME
, [t_jobBy]        NVARCHAR (128)
, [t_filePath]            NVARCHAR (1024)
, [t_extractionDtm]             DATETIME
, CONSTRAINT [dim_UserAddress] PRIMARY KEY NONCLUSTERED([UserName]) NOT ENFORCED 
)
WITH ( 
  HEAP
)
