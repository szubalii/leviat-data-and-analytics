CREATE TABLE [map_AXBI].[SalesDocumentType]
(
     [source_SalesTypeID]               BIGINT          NOT NULL
    ,[target_SalesDocumentTypeID]       NVARCHAR(4)     NULL
    --,[target_Language]                
    ,[target_SalesDocumentTypeName]     nvarchar(20)
    ,[t_applicationId]                  VARCHAR (32)    NULL
    ,[t_jobId]                          VARCHAR (36)    NULL
    ,[t_jobDtm]                         DATETIME        NULL
    --,[t_lastActionCd]                   VARCHAR (1)     NULL
    ,[t_jobBy]                          NVARCHAR (128)  NULL
    ,[t_filePath]                       NVARCHAR (1024) NULL
    ,CONSTRAINT [PK_map_SalesDocumentType] PRIMARY KEY NONCLUSTERED ([source_SalesTypeID]) NOT ENFORCED
)
WITH
(
    DISTRIBUTION = REPLICATE,
    HEAP
)
GO
