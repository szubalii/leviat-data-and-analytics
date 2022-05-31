CREATE TABLE [map_AXBI].[Brand]
( 
    [source_DataAreaID] NVARCHAR (8)   NOT NULL,
    [BrandID]           NVARCHAR(3), -- NOT NULL, Temp fix for deployment
    [Brand]             NVARCHAR(20)   NOT NULL,
    [t_applicationId]   VARCHAR(32)    NULL,
    [t_jobId]           VARCHAR(36)    NULL,
    [t_jobDtm]          DATETIME       NULL,
    [t_jobBy]           NVARCHAR(128)  NULL,
    [t_filePath]        NVARCHAR(1024) NULL,
    CONSTRAINT [PK_map_Brand] PRIMARY KEY NONCLUSTERED ([source_DataAreaID]) NOT ENFORCED
)
WITH
(
    DISTRIBUTION = REPLICATE,
    HEAP
)
GO