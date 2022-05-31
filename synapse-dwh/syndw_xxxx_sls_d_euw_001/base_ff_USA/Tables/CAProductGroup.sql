CREATE TABLE [base_ff_USA].[CAProductGroup]
(       
        [MainGroupID]              CHAR(1)                 NOT NULL
    ,   [MainGroup]                NVARCHAR(40)            NULL
    ,   [CAProductGroupID]         CHAR(4)                 NOT NULL
    ,   [CAProductGroupName]       NVARCHAR(80)            NULL
    ,   [t_applicationId]          VARCHAR(32)             NULL
    ,   [t_jobId]                  VARCHAR(36)             NULL
    ,   [t_jobDtm]                 DATETIME
    ,   [t_jobBy]                  NVARCHAR(128)           NULL
    ,   [t_filePath]               NVARCHAR(1024)          NULL
    ,   CONSTRAINT [PK_CAProductGroup] PRIMARY KEY NONCLUSTERED ([MainGroupID],[CAProductGroupID]) NOT ENFORCED
)
WITH
    (
    HEAP
    );