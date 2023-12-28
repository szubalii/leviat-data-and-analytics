CREATE TABLE [map_AXBI].[SDDocumentCategory]
(
     [source_SalesTypeID]               BIGINT          NOT NULL
    ,[target_SDDocumentCategoryID]      NVARCHAR(4)     NULL
    --,[target_Language]                  CHAR(1) NOT NULL
    ,[target_SDDocumentCategoryName]    NVARCHAR (60)
    ,[t_applicationId]                  VARCHAR (32)    NULL
    ,[t_jobId]                          VARCHAR (36)    NULL
    ,[t_jobDtm]                         DATETIME        NULL
    --,[t_lastActionCd]                   VARCHAR (1)     NULL
    ,[t_jobBy]                          NVARCHAR (128)  NULL
    ,[t_filePath]                       NVARCHAR (1024) NULL
    ,CONSTRAINT [PK_map_SDDocumentCategory] PRIMARY KEY NONCLUSTERED (
        [source_SalesTypeID]
    ) NOT ENFORCED
)
WITH
(
    DISTRIBUTION = REPLICATE,
    HEAP
)
GO
