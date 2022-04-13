CREATE TABLE [edw].[dim_BillingDocumentCategory]
(
    [BillingDocumentCategoryID] NVARCHAR(1)   NOT NULL,
    [BillingDocumentCategory]   NVARCHAR(120) NULL
, [t_applicationId]       VARCHAR (32)
, [t_jobId]               VARCHAR (36)
, [t_jobDtm]              DATETIME
, [t_lastActionCd]        VARCHAR(1)
, [t_jobBy]               NVARCHAR(128)
, CONSTRAINT [PK_dim_BillingDocumentCategory] PRIMARY KEY NONCLUSTERED ([BillingDocumentCategoryID]) NOT ENFORCED
)
    WITH
        (
        DISTRIBUTION = REPLICATE, HEAP )
GO