CREATE TABLE [edw].[dim_InventorySpecialStockType]
(
    [InventorySpecialStockTypeID]   NVARCHAR(1) NOT NULL, --collate Latin1_General_100_BIN2 NOT NULL,
    [InventorySpecialStockTypeName] NVARCHAR(20),
    [t_applicationId]               VARCHAR(32),
    [t_extractionDtm]               DATETIME,
    [t_jobId]                       VARCHAR(36),
    [t_jobDtm]                      DATETIME,
    [t_lastActionCd]                VARCHAR(1),
    [t_jobBy]                       NVARCHAR(128)
,CONSTRAINT [PK_InventorySpecialStockType] PRIMARY KEY NONCLUSTERED ([InventorySpecialStockTypeID]) NOT ENFORCED
)
WITH
    (DISTRIBUTION = REPLICATE, HEAP )
GO