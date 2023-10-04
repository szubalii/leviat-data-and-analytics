CREATE TABLE [base_s4h_cax].[I_PurchasingDocumentStatusText]
-- MM: Status Description of Purchasing Document
(
    [PurchasingDocumentStatus]     nvarchar(2) NOT NULL, -- collate Latin1_General_100_BIN2 NOT NULL,
    [Language]                     nchar(1) NOT NULL, -- collate Latin1_General_100_BIN2    NOT NULL,
    [PurchasingDocumentStatusName] nvarchar(60), -- collate Latin1_General_100_BIN2,
    [t_applicationId]              VARCHAR(32),
    [t_jobId]                      VARCHAR(36),
    [t_jobDtm]                     DATETIME,
    [t_jobBy]                      NVARCHAR(128),
    [t_extractionDtm]              DATETIME,
    [t_filePath]                   NVARCHAR(1024),
    CONSTRAINT [PK_I_PurchasingDocumentStatusText] PRIMARY KEY NONCLUSTERED ([PurchasingDocumentStatus], [Language]) NOT ENFORCED
)
WITH (HEAP)
