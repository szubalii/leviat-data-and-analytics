CREATE TABLE [base_s4h_cax].[I_ProductGroupText_2](
  [MANDT] char(3) collate Latin1_General_100_BIN2 NOT NULL
, [ProductGroup] nvarchar(9) NOT NULL
, [Language] char(1) collate  Latin1_General_100_BIN2 NOT NULL
, [ProductGroupName] nvarchar(20)
, [ProductGroupText] nvarchar(60)
, [t_applicationId]       VARCHAR (32)
, [t_jobId]               VARCHAR (36)
, [t_jobDtm]              DATETIME
, [t_jobBy]        		  NVARCHAR (128)
, [t_extractionDtm]		  DATETIME
, [t_filePath]            NVARCHAR (1024)
, CONSTRAINT [PK_I_ProductGroupText_2] PRIMARY KEY NONCLUSTERED (
    [MANDT], [ProductGroup], [Language]
  ) NOT ENFORCED
)
WITH (
  HEAP
)
