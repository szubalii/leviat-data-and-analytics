CREATE TABLE [edw].[dim_SalesDocumentItemCategory]
(
    [SalesDocumentItemCategoryID] NVARCHAR(8)  NOT NULL,
    [SalesDocumentItemCategory]   NVARCHAR(40) NULL,
    [BillingRelevanceCode]        NVARCHAR(2)  NULL,
    [ScheduleLineIsAllowed]       NVARCHAR(2)  NULL,
    [PricingRelevance]            NVARCHAR(2)  NULL,
    [TextDeterminationProcedure]  NVARCHAR(4)  NULL
, [t_applicationId]       VARCHAR (32)
, [t_jobId]               VARCHAR (36)
, [t_jobDtm]              DATETIME
, [t_lastActionCd]        VARCHAR(1)
, [t_jobBy]               NVARCHAR(128)
, CONSTRAINT [PK_dim_SalesDocumentItemCategory] PRIMARY KEY NONCLUSTERED ([SalesDocumentItemCategoryID]) NOT ENFORCED
)
    WITH
        (
        DISTRIBUTION = REPLICATE, HEAP )
GO