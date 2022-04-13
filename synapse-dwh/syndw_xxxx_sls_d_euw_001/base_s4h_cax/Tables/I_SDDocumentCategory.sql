CREATE TABLE [base_s4h_cax].[I_SDDocumentCategory](
  [SDDocumentCategory] nvarchar(4) NOT NULL
, [t_applicationId]       VARCHAR (32)
, [t_jobId]               VARCHAR (36)
, [t_jobDtm]              DATETIME
, [t_jobBy]        		  NVARCHAR (128)
, [t_extractionDtm]		  DATETIME
, [t_filePath]            NVARCHAR (1024)
, CONSTRAINT [PK_I_SDDocumentCategory] PRIMARY KEY NONCLUSTERED (
    [SDDocumentCategory]
  ) NOT ENFORCED
)
WITH (
  HEAP
)
