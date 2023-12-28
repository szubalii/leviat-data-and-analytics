CREATE TABLE [base_s4h_cax].[I_PurgDocumentItemCategoryText]
-- Purchasing Document Item Category Text
(
    [MANDT]                          nchar(3) NOT NULL, -- collate Latin1_General_100_BIN2 NOT NULL,
    [PurchasingDocumentItemCategory] nvarchar(1) NOT NULL, -- collate Latin1_General_100_BIN2 NOT NULL,
    [Language]                       nchar(1) NOT NULL, -- collate Latin1_General_100_BIN2 NOT NULL,
    [PurgDocItemCategoryName]        nvarchar(20), -- collate Latin1_General_100_BIN2,
    [PurgDocExternalItemCategory]    nvarchar(1), -- collate Latin1_General_100_BIN2,
    [t_applicationId]                VARCHAR(32),    
    [t_jobId]                        VARCHAR(36),
    [t_jobDtm]                       DATETIME,
    [t_jobBy]                        NVARCHAR(128),
    [t_extractionDtm]                DATETIME,
    [t_filePath]                     NVARCHAR(1024),
    CONSTRAINT [PK_I_PurgDocumentItemCategoryText] PRIMARY KEY NONCLUSTERED ([MANDT], [PurchasingDocumentItemCategory], [Language]) NOT ENFORCED
)
WITH (
    HEAP
    )