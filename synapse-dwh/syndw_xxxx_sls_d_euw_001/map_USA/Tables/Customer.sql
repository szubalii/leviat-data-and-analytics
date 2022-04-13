CREATE TABLE [map_USA].[Customer]
(
     [Customer]                 NVARCHAR(40)        NULL
    ,[CompanyID]                NVARCHAR(24)        NULL
    ,[UniqueCustomerNumber]     NVARCHAR(65)        NOT NULL
    ,[CustName]                 NVARCHAR(60)        NULL
    ,[Parent_Name]              NVARCHAR(60)        NULL
    ,[CustSegment]              NVARCHAR(40)        NULL
    ,[CustCategory]             NVARCHAR(40)        NULL
    ,[SalesGroup]               NVARCHAR(40)        NULL
    ,[RSM]                      NVARCHAR(20)        NULL
    ,[LineDisc]                 NVARCHAR(20)        NULL
    ,[STATE]                    NVARCHAR(20)        NULL
    ,[DateOpened]               DATETIME            NULL
    ,[CreatedDate]              DATETIME            NULL
    ,[LTMsales]                 NVARCHAR(20)        NULL
    ,[NewHalfenCust]            NVARCHAR(20)        NULL
    ,[CSG]                      CHAR(3)             NULL
    ,[InsideOutside]            CHAR(1)             NULL
    ,[InsideFlag]               CHAR(1)             NULL
    ,[Region]                   NVARCHAR(40)        NULL
    ,[CustomerPillar]           NVARCHAR(40)        NULL
    ,[Country]                  NVARCHAR(20)        NULL
    ,[t_applicationId]          VARCHAR(32)         NULL
    ,[t_jobId]                  VARCHAR(36)         NULL
    ,[t_jobDtm]                 DATETIME            NULL
    ,[t_jobBy]                  NVARCHAR(128)       NULL
    ,[t_filePath]               NVARCHAR(1024)      NULL
    ,CONSTRAINT [PK_map_USA_Customer] PRIMARY KEY NONCLUSTERED ([UniqueCustomerNumber]) NOT ENFORCED
)
WITH
(
    DISTRIBUTION = REPLICATE,
    HEAP
)
GO