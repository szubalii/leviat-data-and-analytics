CREATE TABLE [base_ff].[ProductHierarchyNodeMapping] (
    [OldProductHierarchyNode]     NVARCHAR(20) NOT NULL
,   [NewProductHierarchyNode]     NVARCHAR(28) NOT NULL
,   [t_applicationId]    VARCHAR   (32)
,   [t_jobId]            VARCHAR   (36)
,   [t_jobDtm]          DATETIME
,   [t_jobBy]            VARCHAR  (128)
,   [t_filePath]        NVARCHAR (1024)
)
WITH (
    DISTRIBUTION = REPLICATE,
    HEAP
);