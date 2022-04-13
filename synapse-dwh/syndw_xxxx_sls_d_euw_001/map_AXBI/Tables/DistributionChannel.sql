CREATE TABLE [map_AXBI].[DistributionChannel]
(
     --sk_DistributionChannel int IDENTITY(1,1) NOT NULL
    --,axBi_SalesDistrictID nvarchar(20) NULL
     source_DistributionChannelID 
    ,target_DistributionChannelID nvarchar(12) NULL
    ,[t_applicationId]       VARCHAR (32)
    ,[t_jobId]               VARCHAR (36)
    ,[t_lastDtm]             DATETIME
    ,[t_lastActionCd]        VARCHAR(128)
    ,[t_lastActionBy]        NVARCHAR(1024)
    ,CONSTRAINT [PK_map_DistributionChannel] PRIMARY KEY NONCLUSTERED ([source_DistributionChannelID],[target_DistributionChannelID]) NOT ENFORCED
)
WITH
(
    DISTRIBUTION = ROUND_ROBIN,
    HEAP
)
GO
