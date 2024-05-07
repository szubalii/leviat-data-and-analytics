CREATE TABLE [base_s4h_cax].[I_PurchasingOrganization]
-- Purchasing Organization
(
  [MANDT]                      nchar(3) NOT NULL, --collate Latin1_General_100_BIN2    NOT NULL,
  [PurchasingOrganization]     nvarchar(4) NOT NULL, --collate Latin1_General_100_BIN2 NOT NULL,
  [PurchasingOrganizationName] nvarchar(20), --collate Latin1_General_100_BIN2,
  [CompanyCode]                nvarchar(4), --collate Latin1_General_100_BIN2,
  [t_applicationId]            VARCHAR(32),
  [t_jobId]                    VARCHAR(36),
  [t_jobDtm]                   DATETIME,
  [t_jobBy]                    NVARCHAR(128),
  [t_extractionDtm]            DATETIME,
  [t_filePath]                 NVARCHAR(1024),
  CONSTRAINT [PK_I_PurchasingOrganization] PRIMARY KEY NONCLUSTERED ([MANDT], [PurchasingOrganization]) NOT ENFORCED
)
WITH (HEAP)
