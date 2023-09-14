CREATE TABLE [base_s4h_cax].[RollName]
(
    [TabName]         NVARCHAR(30) NOT NULL,
    [FieldName]       NVARCHAR(30) NOT NULL,
    [AS4Vers]         CHAR(4) NOT NULL,
    [Position]        CHAR(4) NOT NULL,
    [RollName]        NVARCHAR(30),
    [t_applicationId] VARCHAR (32),
    [t_jobId]         VARCHAR(36),
    [t_jobDtm]        DATETIME,
    [t_jobBy]         NVARCHAR(128),
    [t_extractionDtm] DATETIME,
    [t_filePath]      NVARCHAR(1024),
    CONSTRAINT [PK_RollName]  PRIMARY KEY NONCLUSTERED (
        [TabName], [FieldName], [AS4Vers], [Position]
    ) NOT ENFORCED
) WITH (
  HEAP
)
