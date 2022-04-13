CREATE TABLE [edw].[dim_SalesDocumentRjcnReason]
(
    [SalesDocumentRjcnReasonID] NVARCHAR(2)  NOT NULL,
    [SalesDocumentRjcnReason]   NVARCHAR(40) NULL,
    [t_applicationId]           VARCHAR(32),
    [t_jobId]                   VARCHAR(36),
    [t_jobDtm]                  DATETIME,
    [t_lastActionCd]            VARCHAR(1),
    [t_jobBy]                   NVARCHAR(128),
    CONSTRAINT [PK_dim_SalesDocumentRjcnReason] PRIMARY KEY NONCLUSTERED ([SalesDocumentRjcnReasonID]) NOT ENFORCED
)
    WITH
        (
        DISTRIBUTION = REPLICATE, HEAP )
GO