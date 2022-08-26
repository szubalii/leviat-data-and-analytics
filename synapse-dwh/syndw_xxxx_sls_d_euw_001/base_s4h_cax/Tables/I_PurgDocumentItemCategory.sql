CREATE TABLE [base_s4h_cax].[I_PurgDocumentItemCategory]
-- Purchasing Document Item Category
(
    [MANDT]                          nchar(3) collate Latin1_General_100_BIN2    NOT NULL,
    [PurchasingDocumentItemCategory] nvarchar(1) collate Latin1_General_100_BIN2 NOT NULL,
    [GoodsReceiptIsExpected]         nvarchar(1) collate Latin1_General_100_BIN2,
    [GoodsReceiptIsNonValuated]      nvarchar(1) collate Latin1_General_100_BIN2,
    [InvoiceIsExpected]              nvarchar(1) collate Latin1_General_100_BIN2,
    [t_applicationId]                VARCHAR(32),
    [t_jobId]                        VARCHAR(36),
    [t_jobDtm]                       DATETIME,
    [t_jobBy]                        NVARCHAR(128),
    [t_extractionDtm]                DATETIME,
    [t_filePath]                     NVARCHAR(1024),
    CONSTRAINT [PK_I_PurgDocumentItemCategory] PRIMARY KEY NONCLUSTERED([MANDT], [PurchasingDocumentItemCategory]) NOT ENFORCED 
)
WITH ( 
  HEAP
)
