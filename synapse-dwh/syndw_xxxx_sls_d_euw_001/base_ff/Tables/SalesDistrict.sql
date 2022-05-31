CREATE TABLE [base_ff].[SalesDistrict]
(
    [SalesOrganizationID] NVARCHAR(8)  NOT NULL,
    [CountryID]           NVARCHAR(6)  NOT NULL,
    [ZipCodeFrom]         NVARCHAR(10) NOT NULL,
    [ZipCodeTo]           NVARCHAR(10),
    [SalesDistrictID]     NVARCHAR(6),
    [t_applicationId]            VARCHAR(32)    NULL,
    [t_jobId]                    VARCHAR(36)    NULL,
    [t_jobDtm]                   DATETIME       NULL,
    [t_jobBy]                    NVARCHAR(128)  NULL,
    [t_filePath]                 NVARCHAR(1024) NULL,
    CONSTRAINT [PK_SalesDistrict] PRIMARY KEY NONCLUSTERED ([SalesOrganizationID], [CountryID], [ZipCodeFrom]) NOT ENFORCED,
)
WITH (
  HEAP
)
GO