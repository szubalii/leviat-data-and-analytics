CREATE TABLE [edw].[dim_DeliveryDocumentType]
(
    [DeliveryDocumentTypeID]        NVARCHAR(4)    NOT NULL,
    [DeliveryDocumentType]          NVARCHAR(20),
    [SDDocumentCategory]            NVARCHAR(4),
    [PrecedingDocumentRequirement]  NVARCHAR(1),
    [t_applicationId]               VARCHAR(32)    NULL,
    [t_jobId]                       VARCHAR(36)    NULL,
    [t_jobDtm]                      DATETIME       NULL,
    [t_lastActionCd]                VARCHAR(1),
    [t_jobBy]                       NVARCHAR(128),
    CONSTRAINT [PK_dim_DeliveryDocumentType] PRIMARY KEY NONCLUSTERED ([DeliveryDocumentTypeID]) NOT ENFORCED
)
    WITH
        (
        DISTRIBUTION = REPLICATE, HEAP )
GO
