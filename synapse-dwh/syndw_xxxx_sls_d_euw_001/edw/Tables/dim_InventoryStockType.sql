CREATE TABLE [edw].[dim_InventoryStockType]
(
    [InventoryStockTypeID]          NVARCHAR(2) NOT NULL, --collate Latin1_General_100_BIN2  NOT NULL,
    [InventoryStockTypeName]        NVARCHAR(60),
    [t_applicationId]               VARCHAR(32),
    [t_extractionDtm]               DATETIME,
    [t_jobId]                       VARCHAR(36),
    [t_jobDtm]                      DATETIME,
    [t_lastActionCd]                VARCHAR(1),
    [t_jobBy]                       NVARCHAR(128)
,CONSTRAINT [PK_dim_InventoryStockType] PRIMARY KEY NONCLUSTERED ([InventoryStockTypeID]) NOT ENFORCED
)
WITH
    (DISTRIBUTION = REPLICATE, HEAP )
GO