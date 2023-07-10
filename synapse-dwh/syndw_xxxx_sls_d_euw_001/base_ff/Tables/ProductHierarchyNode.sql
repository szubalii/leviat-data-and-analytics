CREATE TABLE [base_ff].[ProductHierarchyNode] (
    [ProductID]                    NVARCHAR(64) NOT NULL
,   [old_ProductHierarchyNode]     NVARCHAR(64) NOT NULL
,   [new_ProductHierarchyNode]     NVARCHAR(64) NOT NULL
,   [t_applicationId]    VARCHAR   (32)
,   [t_jobId]            VARCHAR   (36)
,   [t_jobDtm]          DATETIME
,   [t_jobBy]            VARCHAR  (128)
,   [t_filePath]        NVARCHAR (1024)
,   CONSTRAINT [PK_ProductHierarchyNodeMapping] PRIMARY KEY NONCLUSTERED ([MaterialID],[ProductHierarchy]) NOT ENFORCED
)
WITH (
    DISTRIBUTION = REPLICATE,
    HEAP
);