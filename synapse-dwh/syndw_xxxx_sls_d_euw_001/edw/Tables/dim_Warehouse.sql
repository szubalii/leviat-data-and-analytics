CREATE TABLE [edw].[dim_Warehouse](
  [WarehouseId] nvarchar(3) NOT NULL
, [Warehouse] nvarchar(25)
, [t_applicationId]       VARCHAR (32)
, [t_jobId]               VARCHAR (36)
, [t_jobDtm]              DATETIME
, [t_lastActionCd]        VARCHAR(1)
, [t_jobBy]               NVARCHAR(128)
, CONSTRAINT [PK_dim_Warehouse] PRIMARY KEY NONCLUSTERED ([WarehouseId]) NOT ENFORCED
)
    WITH
        (
        DISTRIBUTION = REPLICATE, HEAP )
GO