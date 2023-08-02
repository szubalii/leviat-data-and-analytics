CREATE TABLE [base_ff].[EClassCodes]
( 
    [MaterialGroupID]           NVARCHAR (16)  NOT NULL
    ,[EClassCode]                NVARCHAR(8)    NOT NULL
    ,[EClassCategory]            NVARCHAR(64)
    ,[EClassCategoryDescription] NVARCHAR(128)
    ,[Category_L1]               NVARCHAR(128)
    ,[Category_L2]               NVARCHAR(128)
    ,[Category_L3]               NVARCHAR(128)
    ,[Category_L4]               NVARCHAR(128)
    ,[t_applicationId]           VARCHAR   (32) NULL
    ,[t_jobId]                   VARCHAR   (36) NULL
    ,[t_jobDtm]                 DATETIME        NULL
    ,[t_jobBy]                  NVARCHAR  (128) NULL
    ,[t_filePath]               NVARCHAR (1024) NULL
    ,CONSTRAINT [PK_EClassCodes] PRIMARY KEY NONCLUSTERED ([MaterialGroupID]) NOT ENFORCED
)
WITH
(
    DISTRIBUTION = REPLICATE,
    HEAP 
)
GO