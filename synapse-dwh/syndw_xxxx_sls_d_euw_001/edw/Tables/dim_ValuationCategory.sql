CREATE TABLE [edw].[dim_ValuationCategory]
(
    [ValuationCategoryID] NCHAR(1) NOT NULL, --collate Latin1_General_100_BIN2 NOT NULL,
    [ValuationCategory]   NVARCHAR(25),
    [t_applicationId]     VARCHAR(32),
    [t_jobId]             VARCHAR(36),
    [t_jobDtm]            DATETIME,
    [t_lastActionCd]      VARCHAR(1),
    [t_jobBy]             NVARCHAR(128),
    CONSTRAINT [PK_dim_ValuationCategory] PRIMARY KEY NONCLUSTERED ([ValuationCategoryID]) NOT ENFORCED
) WITH
(DISTRIBUTION = REPLICATE, HEAP )
GO