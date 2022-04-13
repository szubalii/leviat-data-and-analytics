CREATE TABLE [base_ff].[CustomerCalculated]
([CustomerIDCalculated] [nvarchar](255) NOT NULL, 
[CustomerCalculated] [nvarchar](200),
[CustomerPillarCalculated] [nvarchar](20),
[isReviewed] tinyint,
[mappingType] nvarchar(10),
[axbiCustomeraccount] [nvarchar](255),
[axbiCustomerName] [nvarchar](200),
[axbiCustomerPillarCalculated] [nvarchar](20),
[t_applicationId]  VARCHAR (32),
[t_jobId]          VARCHAR (36),
[t_jobDtm]         DATETIME,
[t_jobBy]          VARCHAR (128),
[t_extractionDtm]  DATETIME,
[t_filePath]       NVARCHAR (1024),
CONSTRAINT [PK_CustomerCalculated] PRIMARY KEY NONCLUSTERED ([CustomerIDCalculated]) NOT ENFORCED
)
WITH (
  HEAP
)
GO
