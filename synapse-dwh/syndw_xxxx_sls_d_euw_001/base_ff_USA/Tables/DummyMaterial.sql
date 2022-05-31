CREATE TABLE [base_ff_USA].[DummyMaterial] (
        [COMP]                          NVARCHAR(24)
    ,   [MaterialID]                    NVARCHAR(80)
    ,   [PCAT]                          NVARCHAR(40)
    ,   [ProductPillarID]               CHAR(2)
    ,   [ProductPillar]                 NVARCHAR(40)
    ,   [CAProductGroupID]              NVARCHAR(10)
    ,   [t_applicationId]               VARCHAR(32)
    ,   [t_jobId]                       VARCHAR(36)
    ,   [t_jobDtm]                      DATETIME
    ,   [t_jobBy]                       VARCHAR(128)
    ,   [t_filePath]                    NVARCHAR(1024)
    ,   CONSTRAINT [PK_USA_DummyMaterial] PRIMARY KEY NONCLUSTERED ([COMP],[MaterialID],[PCAT],[CAProductGroupID]) NOT ENFORCED
)
WITH (
  HEAP
)
GO