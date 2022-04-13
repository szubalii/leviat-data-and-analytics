CREATE TABLE [map_AXBI].[SalesEmployee]
( -- column types need to be recognised
     [source_SalesPersonID]              NVARCHAR (10)   NOT NULL
    ,[source_SalesPersonName]            NVARCHAR (140)
    ,[target_SalesEmployeeID]            CHAR(8) 
    ,[target_SalesEmployeeFullName]      NVARCHAR (80) 
    ,[target_ExternalSalesAgentID]       CHAR(10)
    ,[target_ExternalSalesAgentFullName] NVARCHAR(80)
    ,[t_applicationId]                   VARCHAR (32)    NULL
    ,[t_jobId]                           VARCHAR (36)    NULL
    ,[t_jobDtm]                          DATETIME        NULL
    --,[t_lastActionCd]                    VARCHAR (1)     NULL
    ,[t_jobBy]                           NVARCHAR (128)  NULL
    ,[t_filePath]                        NVARCHAR (1024) NULL
    ,CONSTRAINT [PK_map_SalesEmployee] PRIMARY KEY NONCLUSTERED ([source_SalesPersonID]) NOT ENFORCED
)
WITH
(
    DISTRIBUTION = REPLICATE,
    HEAP
)
GO

