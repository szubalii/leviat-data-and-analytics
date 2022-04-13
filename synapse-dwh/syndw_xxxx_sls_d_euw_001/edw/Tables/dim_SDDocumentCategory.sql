CREATE TABLE [edw].[dim_SDDocumentCategory]
(
    [SDDocumentCategoryID] NVARCHAR(8)   NOT NULL,
    [SDDocumentCategory]   NVARCHAR(120) NULL
, [t_applicationId]       VARCHAR (32)
, [t_jobId]               VARCHAR (36)
, [t_jobDtm]              DATETIME
, [t_lastActionCd]        VARCHAR(1)
, [t_jobBy]               NVARCHAR(128)
, CONSTRAINT [PK_dim_SDDocumentCategory] PRIMARY KEY NONCLUSTERED ([SDDocumentCategoryID]) NOT ENFORCED
)
    WITH
        (
        DISTRIBUTION = REPLICATE, HEAP )
GO