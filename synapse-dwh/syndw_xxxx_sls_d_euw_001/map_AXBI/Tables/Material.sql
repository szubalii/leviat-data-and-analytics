CREATE TABLE [map_AXBI].[Material]
( -- column types need to be recognised
     [source]                   NVARCHAR  (255)
    ,[source_Material]          NVARCHAR   (20) NOT NULL
    ,[source_MaterialPrefixed]  NVARCHAR   (20) NOT NULL 
    ,[target_Material]          NVARCHAR   (40) 
    ,[target_MaterialName]      NVARCHAR   (40)
    ,[target_MaterialType]      NVARCHAR    (4)
    ,[t_applicationId]           VARCHAR   (32) NULL
    ,[t_jobId]                   VARCHAR   (36) NULL
    ,[t_jobDtm]                 DATETIME        NULL
    ,[t_jobBy]                  NVARCHAR  (128) NULL
    ,[t_filePath]               NVARCHAR (1024) NULL
    ,CONSTRAINT [PK_map_Material] PRIMARY KEY NONCLUSTERED ([source_MaterialPrefixed]) NOT ENFORCED
)
WITH
(
    DISTRIBUTION = REPLICATE,
    HEAP
)
GO