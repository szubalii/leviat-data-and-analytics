CREATE TABLE [map_AXBI].[BillingDocumentItem](
     [ProductID] nvarchar(80)
    ,[FinNetAmountColumnName] nvarchar(80)
    ,[t_applicationId]   VARCHAR   (32)
    ,[t_jobId]           VARCHAR   (36)
    ,[t_jobDtm]         DATETIME
    ,[t_jobBy]          NVARCHAR  (128)
    ,[t_filePath]       NVARCHAR (1024)
    ,CONSTRAINT [PK_map_BillingDocumentItem] PRIMARY KEY NONCLUSTERED ([ProductID]) NOT ENFORCED
)
WITH
(
    DISTRIBUTION = REPLICATE,
    HEAP
)
GO
