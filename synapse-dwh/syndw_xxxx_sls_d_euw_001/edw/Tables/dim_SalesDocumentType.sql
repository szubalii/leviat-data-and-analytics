CREATE TABLE [edw].[dim_SalesDocumentType]
(
    [SalesDocumentTypeID]     NVARCHAR(4)  NOT NULL,
    [SalesDocumentType]       NVARCHAR(20) NULL,
    [t_applicationId]         VARCHAR(32),
    [t_jobId]                 VARCHAR(36),
    [t_jobDtm]                DATETIME,
    [t_lastActionCd]          VARCHAR(1),
    [t_jobBy]                 NVARCHAR(128),
    CONSTRAINT [PK_dim_SalesDocumentType] PRIMARY KEY NONCLUSTERED ([SalesDocumentTypeID]) NOT ENFORCED
)
    WITH
        (
        DISTRIBUTION = REPLICATE, HEAP )
GO