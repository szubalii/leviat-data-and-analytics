CREATE TABLE [edw].[dim_OverallSDDocumentRjcnStatus]
(
    [OverallSDDocumentRjcnStatusID] nvarchar(1) NOT NULL,
    [OverallSDDocumentRjcnStatus]      nvarchar(20),
    [t_applicationId]                 VARCHAR(32),
    [t_jobId]                         VARCHAR(36),
    [t_jobDtm]                        DATETIME,
    [t_lastActionCd]                  VARCHAR(1),
    [t_jobBy]                         NVARCHAR(128),
    CONSTRAINT [PK_dim_OverallSDDocumentRjcnStatus] PRIMARY KEY NONCLUSTERED ([OverallSDDocumentRjcnStatusID]) NOT ENFORCED
)
    WITH
        (
        DISTRIBUTION = REPLICATE, HEAP )
GO