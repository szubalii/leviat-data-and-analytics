CREATE TABLE [dq].[Rule]
(
    [RuleCodeID]                NVARCHAR(50) NOT NULL,
    [RuleBusinessDescription]   NVARCHAR(300),
    [RuleClass]                 NVARCHAR(20),
    [DataArea]                  NVARCHAR(20),
    [t_applicationId]           VARCHAR (32),
    [t_jobId]                   VARCHAR(36),
    [t_jobDtm]                  DATETIME,
    [t_jobBy]                   VARCHAR(128),
    [t_filePath]                NVARCHAR(1024),
    CONSTRAINT [PK_Rule] PRIMARY KEY NONCLUSTERED ([RuleCodeID]) NOT ENFORCED
)
WITH
    (HEAP)
GO
