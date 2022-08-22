CREATE TABLE [map_AXBI].[InventSite]
( 
    [source_SITEID]            NVARCHAR(5)    NOT NULL, 
    [source_DATAAREAID]        NVARCHAR(4)    NOT NULL,
    [source_NAME]              NVARCHAR(40)   NOT NULL,
    [target_PlantID]           NVARCHAR(4)    NULL,
    [t_applicationId]   VARCHAR(32)    NULL,
    [t_jobId]           VARCHAR(36)    NULL,
    [t_jobDtm]          DATETIME       NULL,
    [t_jobBy]           NVARCHAR(128)  NULL,
    [t_filePath]        NVARCHAR(1024) NULL,
    CONSTRAINT [PK_InventSite] PRIMARY KEY NONCLUSTERED ([source_SITEID],[source_DATAAREAID],[source_NAME]) NOT ENFORCED
)
WITH
(
    DISTRIBUTION = REPLICATE,
    HEAP
)
GO