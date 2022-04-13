CREATE TABLE [edw].[dim_CurrencyType] (
    [CurrencyTypeID]              CHAR(2)        NOT NULL,
    [CurrencyType]                NVARCHAR(20)   NOT NULL
, [t_applicationId]       VARCHAR (32)
, [t_jobId]               VARCHAR (36)
, [t_jobDtm]              DATETIME
, [t_lastActionCd]        VARCHAR   (1)
, [t_jobBy]               NVARCHAR(128)
,    CONSTRAINT [PK_dim_CurrencyType] PRIMARY KEY NONCLUSTERED ([CurrencyTypeID]) NOT ENFORCED
)
WITH
(
    DISTRIBUTION = REPLICATE,
    HEAP
)
GO
