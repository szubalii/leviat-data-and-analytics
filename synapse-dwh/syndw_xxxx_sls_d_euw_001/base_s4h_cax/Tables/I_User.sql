CREATE TABLE [base_s4h_cax].[I_User](
  [MANDT] char(3) NOT NULL -- collate Latin1_General_100_BIN2 NOT NULL
, [UserID] nvarchar(12) NOT NULL
, [UserDescription] nvarchar(80)
, [IsTechnicalUser] nvarchar(1)
, [BusinessPartnerUUID] binary(16)
, [t_applicationId]       VARCHAR (32)
, [t_jobId]               VARCHAR (36)
, [t_jobDtm]              DATETIME
, [t_jobBy]        		  NVARCHAR (128)
, [t_extractionDtm]		  DATETIME
, [t_filePath]            NVARCHAR (1024)
, CONSTRAINT [PK_I_User] PRIMARY KEY NONCLUSTERED (
    [MANDT], [UserID]
  ) NOT ENFORCED
)
WITH (
  HEAP
)
