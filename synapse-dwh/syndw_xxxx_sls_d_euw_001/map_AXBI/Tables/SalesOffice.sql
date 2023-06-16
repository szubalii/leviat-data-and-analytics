CREATE TABLE [map_AXBI].[SalesOffice](
     [DataAreaID] NVARCHAR(8)
    ,[SalesOfficeID] NVARCHAR(8)
    ,[t_applicationId]   VARCHAR   (32)
    ,[t_jobId]           VARCHAR   (36)
    ,[t_jobDtm]         DATETIME
    ,[t_jobBy]          NVARCHAR  (128)
    ,[t_filePath]       NVARCHAR (1024)
    ,CONSTRAINT [PK_map_SalesOffice] PRIMARY KEY NONCLUSTERED ([DataAreaID]) NOT ENFORCED
)
WITH
(
    DISTRIBUTION = REPLICATE,
    HEAP
)
GO