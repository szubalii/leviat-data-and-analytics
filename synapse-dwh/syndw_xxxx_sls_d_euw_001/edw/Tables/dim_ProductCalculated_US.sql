CREATE TABLE [edw].[dim_ProductCalculated_US]
(
 [ProductIDCalculated] [nvarchar](255) NOT NULL 
,[ProductCalculated] [nvarchar](280)
,[ProductID_NameCalculated] [nvarchar] (536)
,[ProductPillarIDCalculated] [nvarchar](10)
,[ProductPillarCalculated] [nvarchar](50)
,[ProductGroupIDCalculated] [nvarchar](10)
,[ProductGroupCalculated] [nvarchar](100)
,[MainGroupIDCalculated] [nvarchar](10)
,[MainGroupCalculated] [nvarchar](50)
,[isReviewed] tinyint
,[mappingType] nvarchar(10)
,[axbiItemNo] [nvarchar](255)
,[axbiItemName] [nvarchar](280)
,[axbiProductPillarIDCalculated] [nvarchar](10)
,[axbiProductPillarCalculated] [nvarchar](50)
,[axbiProductGroupIDCalculated] [nvarchar](10)
,[axbiProductGroupCalculated] [nvarchar](100)
,[axbiMainGroupIDCalculated] [nvarchar](10)
,[axbiMainGroupCalculated] [nvarchar](50)
,[t_applicationId]       VARCHAR (32)
,[t_jobId]               VARCHAR(36)    NULL
,[t_jobDtm]              DATETIME       NULL
,[t_jobBy]               NVARCHAR(128)
,[t_lastActionCd]        VARCHAR(1)
,[t_extractionDtm]       DATETIME       NULL
,CONSTRAINT [PK_dim_ProductCalculated_US] PRIMARY KEY NONCLUSTERED ([ProductIDCalculated]) NOT ENFORCED
)
WITH
    (DISTRIBUTION = REPLICATE, HEAP )
GO