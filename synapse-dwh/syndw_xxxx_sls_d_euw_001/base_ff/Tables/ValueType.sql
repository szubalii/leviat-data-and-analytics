CREATE TABLE [base_ff].[ValueType]
(
  [ValueTypeID]           char(5)      NOT NULL
, [ValueType]             NVARCHAR(30) NULL
, [t_applicationId]       VARCHAR (32)
, [t_jobId]               VARCHAR (36)
, [t_jobDtm]              DATETIME
, [t_jobBy]        		  VARCHAR (128)
, [t_filePath]            NVARCHAR (1024)
,    CONSTRAINT [PK_ValueType] PRIMARY KEY NONCLUSTERED ([ValueTypeID]) NOT ENFORCED
)
WITH (
  HEAP
)
GO