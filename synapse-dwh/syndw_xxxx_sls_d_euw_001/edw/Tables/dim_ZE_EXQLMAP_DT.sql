CREATE TABLE [edw].[dim_ZE_EXQLMAP_DT](
     [nk_ExQLmap]                VARCHAR(76) NOT NULL
    ,[GLAccountID]               VARCHAR(12) NOT NULL
    ,[FunctionalAreaID]          VARCHAR(64)
    ,[ExQLNode]                  VARCHAR(64)
    ,[ExQLAccount]               VARCHAR(256)
    ,[CONTIGENCY4]               VARCHAR(64)
    ,[CONTIGENCY5]               VARCHAR(64)
    ,[CONTIGENCY6]               VARCHAR(64)
    ,[CONTIGENCY7]               VARCHAR(64)
    ,[t_applicationId]           VARCHAR(32)
    ,[t_jobId]                   VARCHAR(36)
    ,[t_jobDtm]                  DATETIME
    ,[t_lastActionCd]            VARCHAR(1)
    ,[t_jobBy]                   NVARCHAR(128)
    ,[t_extractionDtm]           DATETIME
    CONSTRAINT [PK_dim_ZE_EXQLMAP_DT] PRIMARY KEY NONCLUSTERED ([nk_ExQLmap]) NOT ENFORCED
)
    WITH
        (
        DISTRIBUTION = REPLICATE, HEAP )
GO