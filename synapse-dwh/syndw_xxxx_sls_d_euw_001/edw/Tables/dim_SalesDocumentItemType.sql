CREATE TABLE [edw].[dim_SalesDocumentItemType]
(
    [SalesDocumentItemTypeID] NVARCHAR(8)  NOT NULL,
    [SalesDocumentItemType]   NVARCHAR(40) NULL
, [t_applicationId]       VARCHAR (32)
, [t_jobId]               VARCHAR (36)
, [t_jobDtm]              DATETIME
, [t_lastActionCd]        VARCHAR(1)
, [t_jobBy]               NVARCHAR(128)
,   CONSTRAINT [PK_dim_SalesDocumentItemType] PRIMARY KEY NONCLUSTERED ([SalesDocumentItemTypeID]) NOT ENFORCED
)
    WITH
        (
        DISTRIBUTION = REPLICATE, HEAP )
GO