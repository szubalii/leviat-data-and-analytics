CREATE TABLE [base_ff].[ConfigurableProduct]
( 
    [ProductID]                 NVARCHAR(40)   NOT NULL,
    [ProductHierarchyNode]      NVARCHAR(18)   NOT NULL,
    [t_applicationId]           VARCHAR(32)    NULL,
    [t_jobId]                   VARCHAR(36)    NULL,
    [t_jobDtm]                  DATETIME       NULL,
    [t_jobBy]                   NVARCHAR(128)  NULL,
    [t_filePath]                NVARCHAR(1024) NULL,
    CONSTRAINT [PK_ConfigurableProduct] PRIMARY KEY NONCLUSTERED ([ProductID]) NOT ENFORCED
)
WITH
(
    DISTRIBUTION = REPLICATE,
    HEAP
)
GO