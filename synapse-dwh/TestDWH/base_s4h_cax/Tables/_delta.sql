CREATE TABLE [base_s4h_cax].[_delta](
  [TS_SEQUENCE_NUMBER] INTEGER NOT NULL,
  [ODQ_CHANGEMODE]     CHAR(1),
  [ODQ_ENTITYCNTR]     NUMERIC(19, 0),
  [PrimaryKeyField_1]  NVARCHAR(2) NOT NULL,
  [PrimaryKeyField_2]  NVARCHAR(4) NOT NULL,
  [NonPrimaryKeyField_1] NVARCHAR(4),
  [t_applicationId]    VARCHAR(32),
  [t_jobId]            VARCHAR(36),
  [t_jobDtm]           DATETIME,
  [t_jobBy]            NVARCHAR(128),
  [t_extractionDtm]    DATETIME,
  [t_filePath]         NVARCHAR(1024),
  CONSTRAINT [PK_delta] PRIMARY KEY NONCLUSTERED (
    [TS_SEQUENCE_NUMBER], [PrimaryKeyField_1], [PrimaryKeyField_2]
  ) NOT ENFORCED
)
WITH (
  HEAP
)