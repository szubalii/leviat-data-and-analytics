CREATE TABLE [map_AXBI].[StockUnit]
( 
    [AXUnit]            NVARCHAR(3)   NOT NULL,
    [AXUnitname]        NVARCHAR(30)  NOT NULL,
    [SAPUnit]           NVARCHAR(3)   NOT NULL,
    [SAPUoM]            NVARCHAR(4)   NOT NULL,
    [t_applicationId]   VARCHAR(32)    NULL,
    [t_jobId]           VARCHAR(36)    NULL,
    [t_jobDtm]          DATETIME       NULL,
    [t_jobBy]           NVARCHAR(128)  NULL,
    [t_filePath]        NVARCHAR(1024) NULL,
    CONSTRAINT [PK_StoclUnit] PRIMARY KEY NONCLUSTERED ([AXUnit],[AXUnitname],[SAPUnit],[SAPUoM]) NOT ENFORCED
)
WITH
(
    DISTRIBUTION = REPLICATE,
    HEAP
)
GO