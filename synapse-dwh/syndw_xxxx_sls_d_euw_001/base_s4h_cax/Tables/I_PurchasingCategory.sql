CREATE TABLE [base_s4h_cax].[I_PurchasingCategory]
-- Purchasing Category
(
    [MANDT]                        nchar(3) collate Latin1_General_100_BIN2 NOT NULL,
    [PurgCatUUID]                  binary(16)                               NOT NULL,
    [PurchasingCategory]           nvarchar(20) collate Latin1_General_100_BIN2,
    [PurgCatName]                  nvarchar(60) collate Latin1_General_100_BIN2,
    [CreationDateTime]             decimal(21, 7),
    [CreatedByUser]                nvarchar(60) collate Latin1_General_100_BIN2,
    [LastChangeDateTime]           decimal(21, 7),
    [LastChangedByUser]            nvarchar(60) collate Latin1_General_100_BIN2,
    [Language]                     nchar(1) collate Latin1_General_100_BIN2,
    [PurgCatIsInactive]            nvarchar(1) collate Latin1_General_100_BIN2,
    [PurgCatTranslationOvrlStatus] char(2) collate Latin1_General_100_BIN2,
    [SLCTranslationStatus]         char(2) collate Latin1_General_100_BIN2,
    [t_applicationId]              VARCHAR(32),    
    [t_jobId]                      VARCHAR(36),
    [t_jobDtm]                     DATETIME,
    [t_jobBy]                      NVARCHAR(128),
    [t_extractionDtm]              DATETIME,
    [t_filePath]                   NVARCHAR(1024),
    CONSTRAINT [PK_I_PurchasingCategory] PRIMARY KEY NONCLUSTERED ([MANDT], [PurgCatUUID]) NOT ENFORCED
)
WITH (HEAP)
