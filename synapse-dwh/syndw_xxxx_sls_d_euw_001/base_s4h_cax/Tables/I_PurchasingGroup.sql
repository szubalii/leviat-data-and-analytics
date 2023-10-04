CREATE TABLE [base_s4h_cax].[I_PurchasingGroup]
-- Purchasing Group
(
  [MANDT]                      nchar(3) NOT NULL, --collate Latin1_General_100_BIN2    NOT NULL,
  [PurchasingGroup]            nvarchar(3) NOT NULL, --collate Latin1_General_100_BIN2 NOT NULL,
  [PurchasingGroupName]        nvarchar(18), -- collate Latin1_General_100_BIN2,
  [PurchasingGroupPhoneNumber] nvarchar(12), -- collate Latin1_General_100_BIN2,
  [FaxNumber]                  nvarchar(31), -- collate Latin1_General_100_BIN2,
  [PhoneNumber]                nvarchar(30), -- collate Latin1_General_100_BIN2,
  [PhoneNumberExtension]       nvarchar(10), -- collate Latin1_General_100_BIN2,
  [EmailAddress]               nvarchar(241), -- collate Latin1_General_100_BIN2,
  [t_applicationId]            VARCHAR(32),
  [t_jobId]                    VARCHAR(36),
  [t_jobDtm]                   DATETIME,
  [t_jobBy]                    NVARCHAR(128),
  [t_extractionDtm]            DATETIME,
  [t_filePath]                 NVARCHAR(1024),
    CONSTRAINT [PK_I_PurchasingGroup] PRIMARY KEY NONCLUSTERED ([MANDT], [PurchasingGroup]) NOT ENFORCED
)
    WITH (
        HEAP
        )
