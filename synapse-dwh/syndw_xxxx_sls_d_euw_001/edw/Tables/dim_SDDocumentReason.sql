CREATE TABLE [edw].[dim_SDDocumentReason]
(
    [SDDocumentReasonID]   NVARCHAR(6)  NOT NULL,
    [SDDocumentReason]     NVARCHAR(80) NULL,
    [RetroBillingUsage]    NVARCHAR(2)  NULL,
    [SelfBillingValueItem] NVARCHAR(2)  NULL
, [t_applicationId]       VARCHAR (32)
, [t_jobId]               VARCHAR (36)
, [t_jobDtm]              DATETIME
, [t_lastActionCd]        VARCHAR(1)
, [t_jobBy]               NVARCHAR(128)
, CONSTRAINT [PK_dim_SDDocumentReason] PRIMARY KEY NONCLUSTERED ([SDDocumentReasonID]) NOT ENFORCED
)
    WITH
        (
        DISTRIBUTION = REPLICATE, HEAP )
GO