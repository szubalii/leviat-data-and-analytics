CREATE TABLE [map_AXBI].[BusinessPartner]
(
     [XRefType]         NVARCHAR  (100) NOT NULL 
    ,[source_XRefID]    NVARCHAR   (40) NOT NULL
    ,[target_XRefID]    NVARCHAR   (10)
    ,[t_applicationId]   VARCHAR   (32)
    ,[t_jobId]           VARCHAR   (36)
    ,[t_jobDtm]         DATETIME
    ,[t_jobBy]          NVARCHAR  (128)
    ,[t_filePath]       NVARCHAR (1024)
    ,CONSTRAINT [PK_map_BusinessPartner] PRIMARY KEY NONCLUSTERED (
         [XRefType] 
        ,[source_XRefID]
     ) NOT ENFORCED
)
WITH
(
    DISTRIBUTION = REPLICATE,
    HEAP
)
GO
