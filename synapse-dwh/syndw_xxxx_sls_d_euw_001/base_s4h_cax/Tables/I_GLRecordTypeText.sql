CREATE TABLE [base_s4h_cax].[I_GLRecordTypeText](
  [Language] char(1) NOT NULL -- collate Latin1_General_100_BIN2 NOT NULL
, [GLRecordType] nvarchar(1) NOT NULL
, [GLRecordTypeName] nvarchar(60)
, [t_applicationId]       VARCHAR (32)
, [t_jobId]               VARCHAR (36)
, [t_jobDtm]              DATETIME
, [t_jobBy]        		  NVARCHAR (128)
, [t_extractionDtm]		  DATETIME
, [t_filePath]            NVARCHAR (1024)
, CONSTRAINT [PK_I_GLRecordTypeText] PRIMARY KEY NONCLUSTERED (
    [Language], [GLRecordType]
  ) NOT ENFORCED
)
WITH (
  HEAP
)
