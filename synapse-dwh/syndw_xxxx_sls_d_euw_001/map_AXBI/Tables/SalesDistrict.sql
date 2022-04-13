CREATE TABLE [map_AXBI].[SalesDistrict]
(
     [source_CountryCode]         NVARCHAR (6)
    ,[source_ZipCode]             NVARCHAR (10)
    ,[source_CityRegion]          NVARCHAR (30)
    ,[source_SalesDistrictKey]    NVARCHAR (8)    NOT NULL
    ,[target_SalesDistrictID]     NVARCHAR (6)    NULL
    ,[t_applicationId]            VARCHAR (32)    NULL
    ,[t_jobId]                    VARCHAR (36)    NULL
    ,[t_jobDtm]                   DATETIME        NULL
    --,[t_lastActionCd]             VARCHAR (1)     NULL
    ,[t_jobBy]                    NVARCHAR (128)  NULL
    ,[t_filePath]                 NVARCHAR (1024) NULL
    ,CONSTRAINT [PK_map_SalesDistrict] PRIMARY KEY NONCLUSTERED ([source_SalesDistrictKey]) NOT ENFORCED
)
WITH
(
    DISTRIBUTION = REPLICATE,
    HEAP
)
GO