CREATE TABLE [edw].[dim_ZE_EXQLMAP_DT](
     [sk_ExQLmap]                VARCHAR(76)
    ,[GLAccount]                 VARCHAR(12) NOT NULL
    ,[FunctionalArea]            VARCHAR(64)
    ,[ExQLNode]                  VARCHAR(64)
    ,[ExQLAccount]               VARCHAR(256)
    ,[t_applicationId]           VARCHAR(32)
    ,[t_jobId]                   VARCHAR(36)
    ,[t_jobDtm]                  DATETIME
    ,[t_lastActionCd]            VARCHAR(1)
    ,[t_jobBy]                   NVARCHAR(128)
    ,[t_extractionDtm]           DATETIME
    CONSTRAINT [PK_dim_ZE_EXQLMAP_DT] PRIMARY KEY NONCLUSTERED ([sk_ExQLmap]) NOT ENFORCED
)
    WITH
        (
        DISTRIBUTION = REPLICATE, HEAP )
GO