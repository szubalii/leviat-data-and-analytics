CREATE TABLE [edw].[dim_CustomerCalculated_US]
([CustomerIDCalculated] [nvarchar](255) NOT NULL, 
[CustomerCalculated] [nvarchar](200),
[CustomerPillarCalculated] [nvarchar](20),
[isReviewed] tinyint,
[mappingType] nvarchar(10),
[axbiCustomeraccount] [nvarchar](255),
[axbiCustomerName] [nvarchar](200),
[axbiCustomerPillarCalculated] [nvarchar](20),
[t_applicationId]       VARCHAR (32),
[t_jobId]               VARCHAR(36)    NULL,
[t_jobDtm]              DATETIME       NULL,
[t_jobBy]               NVARCHAR(128),
[t_lastActionCd]        VARCHAR(1),
[t_extractionDtm]       DATETIME       NULL,
CONSTRAINT [PK_dim_CustomerCalculated_US] PRIMARY KEY NONCLUSTERED ([CustomerIDCalculated],[t_applicationId]) NOT ENFORCED
)
WITH
    (DISTRIBUTION = REPLICATE, HEAP )
GO