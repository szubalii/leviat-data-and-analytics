CREATE TABLE [base_ff].[ProductHierarchyNode] (
    [MaterialID]                    NVARCHAR(64) NOT NULL
,   [ProductHierarchy]              NVARCHAR(64) NOT NULL
,   [ProductHierarchyNew]           NVARCHAR(64) NOT NULL
,   [t_applicationId]    VARCHAR   (32)
,   [t_jobId]            VARCHAR   (36)
,   [t_jobDtm]          DATETIME
,   [t_jobBy]            VARCHAR  (128)
,   [t_extractionDtm]   DATETIME
,   [t_filePath]        NVARCHAR (1024)
,   CONSTRAINT [PK_ProductHierarchyNodeMapping] PRIMARY KEY NONCLUSTERED ([MaterialID],[ProductHierarchy]) NOT ENFORCED
)
WITH (
    DISTRIBUTION = REPLICATE,
    HEAP
);