CREATE TABLE [base_s4h_cax].[I_ProductCategoryText](
  [Language] char(1) NOT NULL -- collate Latin1_General_100_BIN2 NOT NULL
, [ProductCategory] nvarchar(2) NOT NULL
, [Name] nvarchar(60)
, [t_applicationId]       VARCHAR (32)
, [t_jobId]               VARCHAR (36)
, [t_jobDtm]              DATETIME
, [t_jobBy]        		  NVARCHAR (128)
, [t_extractionDtm]		  DATETIME
, [t_filePath]            NVARCHAR (1024)
, CONSTRAINT [PK_I_ProductCategoryText] PRIMARY KEY NONCLUSTERED (
    [Language], [ProductCategory]
  ) NOT ENFORCED
)
WITH (
  HEAP
)
