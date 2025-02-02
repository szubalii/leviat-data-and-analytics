﻿CREATE TABLE [dq].[dim_Rule]
(
    [RuleID]                    NVARCHAR(50) NOT NULL,
    [DataArea]                  NVARCHAR(20),
    [RuleClass]                 NVARCHAR(20),
    [RuleGroup]                 NVARCHAR(40),
    [RuleBusinessDescription]   NVARCHAR(400),
    [RuleTechnicalDefinition]   NVARCHAR(400),
    [FieldNameChecked]          NVARCHAR(300),
    [RAGStatus]                 CHAR(1),
    [t_applicationId]           VARCHAR (32),
    [t_jobId]                   VARCHAR(36),
    [t_jobDtm]                  DATETIME,
    [t_jobBy]                   VARCHAR(128),
    [t_filePath]                NVARCHAR(1024),
    CONSTRAINT [PK_RuleID] PRIMARY KEY NONCLUSTERED ([RuleID]) NOT ENFORCED
)
WITH
(
    DISTRIBUTION = REPLICATE,
    HEAP
)
GO
