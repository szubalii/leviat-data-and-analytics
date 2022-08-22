CREATE TABLE [map_AXBI].[StockUnit]
( 
    [source_UnitID]     NVARCHAR(3)    NOT NULL,
    [source_UnitName]   NVARCHAR(30)   NOT NULL,
    [target_UnitID]     NVARCHAR(3)    NOT NULL,
    [target_UnitName]   NVARCHAR(4)    NOT NULL,
    [t_applicationId]   VARCHAR(32)    NULL,
    [t_jobId]           VARCHAR(36)    NULL,
    [t_jobDtm]          DATETIME       NULL,
    [t_jobBy]           NVARCHAR(128)  NULL,
    [t_filePath]        NVARCHAR(1024) NULL,
    CONSTRAINT [PK_StockUnit] PRIMARY KEY NONCLUSTERED ([source_UnitID],[source_UnitName],[target_UnitID],[target_UnitName]) NOT ENFORCED
)
WITH
(
    DISTRIBUTION = REPLICATE,
    HEAP
)
GO