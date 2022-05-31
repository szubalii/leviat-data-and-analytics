CREATE TABLE [edw].[dim_InventoryTransactionType]
(
    [InventoryTransactionTypeID]   nvarchar(2) NOT NULL,
    [InventoryTransactionTypeText] nvarchar(40),
    [IsPhysicalInventoryRelevant]  nvarchar(1),
    [IsMaterialDocumentRelevant]   nvarchar(1),
    [IsReservationRelevant]        nvarchar(1),
    [t_applicationId]              VARCHAR(32),
    [t_jobId]                      VARCHAR(36),
    [t_jobDtm]                     DATETIME,
    [t_lastActionCd]               VARCHAR(1),
    [t_jobBy]                      NVARCHAR(128)
,CONSTRAINT [PK_dim_InventoryTransactionType] PRIMARY KEY NONCLUSTERED ([InventoryTransactionTypeID]) NOT ENFORCED
)
WITH
    (DISTRIBUTION = REPLICATE, HEAP )
GO