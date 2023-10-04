CREATE TABLE [base_s4h_cax].[I_PurgDocumentItemCategory]
-- Purchasing Document Item Category
(
    [MANDT]                          NCHAR(3) collate Latin1_General_100_BIN2    NOT NULL,
    [PurchasingDocumentItemCategory] NVARCHAR(1) NOT NULL -- collate Latin1_General_100_BIN2 NOT NULL,
    [GoodsReceiptIsExpected]         NVARCHAR(1) -- collate Latin1_General_100_BIN2,
    [GoodsReceiptIsNonValuated]      NVARCHAR(1) -- collate Latin1_General_100_BIN2,
    [InvoiceIsExpected]              NVARCHAR(1) -- collate Latin1_General_100_BIN2,
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
