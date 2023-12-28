CREATE TABLE [edw].[dim_PurchasingDocumentType]
(
    [PurchasingDocumentTypeID]      nvarchar(4) NOT NULL,
    [PurchasingDocumentCategoryID]  nvarchar(1) NOT NULL,
    [PurgDocFieldSelControlKey]     nvarchar(20),
    [PurgHasFlxblWorkflowApproval]  nvarchar(1),
    [PurchasingDocumentTypeName]    nvarchar(20),
    [t_applicationId]               VARCHAR(32),
    [t_jobId]                       VARCHAR(36),
    [t_jobDtm]                      DATETIME,
    [t_lastActionCd]                VARCHAR(1),
    [t_jobBy]                       NVARCHAR(128),
    CONSTRAINT [PK_dim_PurchasingDocumentType] PRIMARY KEY NONCLUSTERED ([PurchasingDocumentTypeID], [PurchasingDocumentCategoryID]) NOT ENFORCED
)
WITH
    (DISTRIBUTION = REPLICATE, HEAP )
GO