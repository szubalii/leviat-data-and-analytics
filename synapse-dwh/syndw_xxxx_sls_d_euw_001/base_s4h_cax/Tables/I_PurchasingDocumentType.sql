CREATE TABLE [base_s4h_cax].[I_PurchasingDocumentType]
(
    [MANDT]                        nchar(3) collate Latin1_General_100_BIN2    NOT NULL,
    [PurchasingDocumentCategory]   nvarchar(1) NOT NULL, -- collate Latin1_General_100_BIN2 NOT NULL,
    [PurchasingDocumentType]       nvarchar(4) NOT NULL, -- collate Latin1_General_100_BIN2 NOT NULL,
    [PurgDocFieldSelControlKey]    nvarchar(20), -- collate Latin1_General_100_BIN2,
    [PurgHasFlxblWorkflowApproval] nvarchar(1), -- collate Latin1_General_100_BIN2,
    [t_applicationId]              VARCHAR (32), 
    [t_jobId]                      VARCHAR (36), 
    [t_jobDtm]                     DATETIME, 
    [t_jobBy]        		           NVARCHAR (128), 
    [t_extractionDtm]		           DATETIME, 
    [t_filePath]                   NVARCHAR (1024), 
    CONSTRAINT [PK_I_PurchasingDocumentType] PRIMARY KEY NONCLUSTERED (
       [MANDT], [PurchasingDocumentCategory], [PurchasingDocumentType]
    ) NOT ENFORCED
)
WITH (
  HEAP
)
