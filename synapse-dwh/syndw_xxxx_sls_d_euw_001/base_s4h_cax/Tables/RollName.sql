CREATE TABLE [base_s4h_cax].[RollName]
(
    [TABNAME]         NVARCHAR(30) NOT NULL,
    [FIELDNAME]       NVARCHAR(30) NOT NULL,
    [AS4VERS]         CHAR(4) NOT NULL,
    [POSITION]        CHAR(4) NOT NULL,
    [ROLLNAME]        NVARCHAR(30),
    [t_applicationId] VARCHAR (32),
    [t_jobId]         VARCHAR(36),
    [t_jobDtm]        DATETIME,
    [t_jobBy]         NVARCHAR(128),
    [t_extractionDtm] DATETIME,
    [t_filePath]      NVARCHAR(1024),
    CONSTRAINT [PK_RollName]  PRIMARY KEY NONCLUSTERED (
        [TABNAME], [FIELDNAME], [AS4VERS], [POSITION]
    ) NOT ENFORCED
) WITH (
  HEAP
)
