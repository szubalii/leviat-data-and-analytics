CREATE TABLE [base_ff].[CurrencyType] (
    [CurrencyTypeID]              CHAR(2)        NOT NULL,
    [CurrencyType]                NVARCHAR(20)   NOT NULL
, [t_applicationId]       VARCHAR (32)
, [t_jobId]               VARCHAR (36)
, [t_jobDtm]              DATETIME
, [t_jobBy]        		  VARCHAR (128)
, [t_filePath]            NVARCHAR (1024)
,    CONSTRAINT [PK_CurrencyType] PRIMARY KEY NONCLUSTERED ([CurrencyTypeID]) NOT ENFORCED
)
WITH (
  HEAP
)
GO
