CREATE TABLE [base_s4h_cax].[_active](
  [PrimaryKeyField_1]  NVARCHAR(2) NOT NULL,
  [PrimaryKeyField_2]  NVARCHAR(4) NOT NULL,
  [NonPrimaryKeyField_1] NVARCHAR(4),
  [t_applicationId]    VARCHAR(32),
  [t_jobId]            VARCHAR(36),
  [t_jobDtm]           DATETIME,
  [t_jobBy]            NVARCHAR(128),
  [t_extractionDtm]    DATETIME,
  [t_filePath]         NVARCHAR(1024),
  [t_lastActionBy]     VARCHAR(128),
  [t_lastActionCd]     CHAR(1),
  [t_lastActionDtm]    DATETIME,
  CONSTRAINT [PK_active] PRIMARY KEY NONCLUSTERED (
    [PrimaryKeyField_1], [PrimaryKeyField_2]
  ) NOT ENFORCED
)
WITH (
  HEAP
)