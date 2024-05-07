CREATE TABLE [base_s4h_cax].[I_PurgDocumentCategoryText]
-- Purchasing Document Category Text
(
    [PurchasingDocumentCategory]     nvarchar(1) NOT NULL, -- collate Latin1_General_100_BIN2 NOT NULL,
    [Language]                       nchar(1) NOT NULL, -- collate Latin1_General_100_BIN2    NOT NULL,
    [PurchasingDocumentCategoryName] nvarchar(60), -- collate Latin1_General_100_BIN2,
    [t_applicationId]                VARCHAR(32),    
    [t_jobId]                        VARCHAR(36),
    [t_jobDtm]                       DATETIME,
    [t_jobBy]                        NVARCHAR(128),
    [t_extractionDtm]                DATETIME,
    [t_filePath]                     NVARCHAR(1024),
    CONSTRAINT [PK_I_PurgDocumentCategoryText] PRIMARY KEY NONCLUSTERED ([PurchasingDocumentCategory], [Language]) NOT ENFORCED
)
WITH (
    HEAP
    )