CREATE TABLE [base_s4h_cax].[I_PurchasingDocumentTypeText]
(
    [MANDT]                      nchar(3) collate Latin1_General_100_BIN2    NOT NULL,
    [PurchasingDocumentType]     nvarchar(4) NOT NULL -- collate Latin1_General_100_BIN2 NOT NULL,
    [PurchasingDocumentCategory] nvarchar(1) NOT NULL -- collate Latin1_General_100_BIN2 NOT NULL,
    [Language]                   nchar(1) collate Latin1_General_100_BIN2    NOT NULL,
    [PurchasingDocumentTypeName] nvarchar(20) -- collate Latin1_General_100_BIN2,
    [t_applicationId]            VARCHAR (32), 
    [t_jobId]                    VARCHAR (36), 
    [t_jobDtm]                   DATETIME, 
    [t_jobBy]        		         NVARCHAR (128), 
    [t_extractionDtm]		         DATETIME, 
    [t_filePath]                 NVARCHAR (1024),
    CONSTRAINT [PK_I_PurchasingDocumentTypeText] PRIMARY KEY NONCLUSTERED (
    [MANDT], [PurchasingDocumentType], [PurchasingDocumentCategory], [Language]
  ) NOT ENFORCED
)
WITH (
  HEAP
)
