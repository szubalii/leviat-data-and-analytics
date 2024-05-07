CREATE TABLE [map_AXBI].[SalesOrganization]
(
    [source_DataAreaID]            NVARCHAR(8)    NOT NULL,
    [source_UDFSystem]             NVARCHAR(20)   NOT NULL,
    [source_UDFOpCo]               NVARCHAR(20),
    [source_UDFCountryCode]        VARCHAR(3),
    [source_UDFLegacyID]           VARCHAR(3),
    [target_CompanyCodeID]         NVARCHAR(4)    NULL,
    [target_CompanyCodeName]       NVARCHAR(20)   NULL,
    [target_SalesOrganizationID]   NVARCHAR(4)    NULL,     --, [target_Language]                 char(1)
    [target_SalesOrganizationName] NVARCHAR(50),
    [CountryID]                    NVARCHAR(3),
    [CountryName]                  NVARCHAR(50),
    [RegionID]                     NVARCHAR(10),
    [RegionName]                   NVARCHAR(80),
    [Access_Control_Unit]          NVARCHAR(20),
    [IsMigrated]                   CHAR(1)        NULL,
    [t_applicationId]              VARCHAR(32)    NULL,
    [t_jobId]                      VARCHAR(36)    NULL,
    [t_jobDtm]                     DATETIME       NULL,
    [t_jobBy]                      NVARCHAR(128)  NULL,
    [t_filePath]                   NVARCHAR(1024) NULL,
    CONSTRAINT [PK_map_SalesOrganization] PRIMARY KEY NONCLUSTERED (
                                                                    [source_DataAreaID], [source_UDFSystem]
        ) NOT ENFORCED
)
WITH
(
    DISTRIBUTION = REPLICATE,
    HEAP
)
GO
