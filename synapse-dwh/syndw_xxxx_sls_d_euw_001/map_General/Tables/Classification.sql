CREATE TABLE [map_General].[Classification]
( 
    [MaterialGroupName] NVARCHAR (64)   NOT NULL
    ,[Classification]    NVARCHAR(8)     NOT NULL
    ,[t_applicationId]           VARCHAR   (32) NULL
    ,[t_jobId]                   VARCHAR   (36) NULL
    ,[t_jobDtm]                 DATETIME        NULL
    ,[t_jobBy]                  NVARCHAR  (128) NULL
    ,[t_filePath]               NVARCHAR (1024) NULL
    ,CONSTRAINT [PK_map_Classification] PRIMARY KEY NONCLUSTERED ([MaterialGroupName]) NOT ENFORCED
)
WITH
(
    DISTRIBUTION = REPLICATE,
    HEAP
)
GO