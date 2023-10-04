CREATE TABLE [edw].[dim_BillingDocumentType]
(
    [BillingDocumentTypeID]   NVARCHAR(8)  NOT NULL,
    [BillingDocumentType]     NVARCHAR(80) NULL,
    [SDDocumentCategoryID]    NVARCHAR(8)  NULL,
    [IncrementItemNumber]     CHAR(6), --      collate Latin1_General_100_BIN2 NULL,
    [BillingDocumentCategory] NVARCHAR(2)  NULL
, [t_applicationId]       VARCHAR (32)
, [t_jobId]               VARCHAR (36)
, [t_jobDtm]              DATETIME
, [t_lastActionCd]        VARCHAR(1)
, [t_jobBy]               NVARCHAR(128)
,    CONSTRAINT [PK_dim_BillingDocumentType] PRIMARY KEY NONCLUSTERED ([BillingDocumentTypeID]) NOT ENFORCED
)
    WITH
        (
        DISTRIBUTION = REPLICATE, HEAP )
GO