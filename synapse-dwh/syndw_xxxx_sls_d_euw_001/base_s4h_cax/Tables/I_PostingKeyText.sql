CREATE TABLE [base_s4h_cax].[I_PostingKeyText](
-- I_PostingKeyText is defined as delta-enabled in the CDS-view definition, but doesn't actually
-- support the ODP delta mechanism. Therefore, the delta-specific fields are commented out. 
--  [TS_SEQUENCE_NUMBER] INTEGER NOT NULL
--, [ODQ_CHANGEMODE] CHAR(1)
--, [ODQ_ENTITYCNTR] NUMERIC(19,0)
--, 
  [MANDT] char(3) NOT NULL -- collate Latin1_General_100_BIN2 NOT NULL
, [Language] char(1) NOT NULL -- collate Latin1_General_100_BIN2 NOT NULL
, [PostingKey] nvarchar(2) NOT NULL
, [PostingKeyName] nvarchar(20)
, [t_applicationId]       VARCHAR (32)
, [t_jobId]               VARCHAR (36)
, [t_jobDtm]              DATETIME
, [t_jobBy]        		  NVARCHAR (128)
, [t_extractionDtm]		  DATETIME
, [t_filePath]            NVARCHAR (1024)
, CONSTRAINT [PK_I_PostingKeyText] PRIMARY KEY NONCLUSTERED (
    --[TS_SEQUENCE_NUMBER], 
    [MANDT], [Language], [PostingKey]
  ) NOT ENFORCED
)
WITH (
  HEAP
)
