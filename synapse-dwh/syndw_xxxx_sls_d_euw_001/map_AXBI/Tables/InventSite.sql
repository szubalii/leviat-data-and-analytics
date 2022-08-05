CREATE TABLE [map_AXBI].[InventSite]
( 
    [SITEID]            NVARCHAR(5)    NOT NULL,
    [DATAAREAID]        NVARCHAR(4)    NOT NULL,
    [NAME]              NVARCHAR(40)   NOT NULL,
    [t_applicationId]   VARCHAR(32)    NULL,
    [t_jobId]           VARCHAR(36)    NULL,
    [t_jobDtm]          DATETIME       NULL,
    [t_jobBy]           NVARCHAR(128)  NULL,
    [t_filePath]        NVARCHAR(1024) NULL,
    CONSTRAINT [PK_InventSite] PRIMARY KEY NONCLUSTERED ([SITEID],[DATAAREAID],[NAME]) NOT ENFORCED
)
WITH
(
    DISTRIBUTION = REPLICATE,
    HEAP
)
GO