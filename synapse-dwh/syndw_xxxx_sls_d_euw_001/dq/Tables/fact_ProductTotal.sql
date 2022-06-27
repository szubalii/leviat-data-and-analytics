CREATE TABLE [dq].[fact_ProductTotal]
(
    [ProductTotals]      INT,
    [ErrorTotals]       INT,
    [t_jobId]           VARCHAR (36),
    [t_jobDtm]          DATETIME,
    [t_lastActionCd]    VARCHAR(1),
    [t_jobBy]           NVARCHAR(128),
    CONSTRAINT [PK_ProductsDate] PRIMARY KEY NONCLUSTERED ([t_jobDtm]) NOT ENFORCED
)
WITH
(
    DISTRIBUTION = REPLICATE,
    HEAP
)
GO
