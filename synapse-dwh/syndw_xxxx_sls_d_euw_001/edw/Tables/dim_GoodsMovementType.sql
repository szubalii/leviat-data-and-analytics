CREATE TABLE [edw].[dim_GoodsMovementType]
(
    [GoodsMovementTypeID]    nvarchar(3) NOT NULL,
    [GoodsMovementTypeName]  nvarchar(20),
    [IsReversalMovementType] nvarchar(1),
    [t_applicationId]        VARCHAR(32),
    [t_jobId]                VARCHAR(36),
    [t_jobDtm]               DATETIME,
    [t_lastActionCd]         VARCHAR(1),
    [t_jobBy]                NVARCHAR(128),
    CONSTRAINT [PK_dim_GoodsMovementType] PRIMARY KEY NONCLUSTERED ([GoodsMovementTypeID]) NOT ENFORCED
)
WITH
    (DISTRIBUTION = REPLICATE, HEAP )
GO