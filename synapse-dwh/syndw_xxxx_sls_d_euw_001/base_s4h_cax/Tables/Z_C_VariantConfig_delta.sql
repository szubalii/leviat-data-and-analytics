CREATE TABLE [base_s4h_cax].[Z_C_VariantConfig_delta](
  [TS_SEQUENCE_NUMBER]          INTEGER NOT NULL
, [ODQ_CHANGEMODE]              CHAR(1)
, [ODQ_ENTITYCNTR]              NUMERIC(19, 0)
, [SalesDocument]               NVARCHAR(20) NOT NULL
, [SalesDocumentItem]           NVARCHAR(24) NOT NULL -- collate Latin1_General_100_BIN2 NOT NULL
, [ProductID]                   NVARCHAR(40)
, [ProductExternalID]           NVARCHAR(40)
, [Configuration]               NVARCHAR(18)
, [Instance]                    NVARCHAR(22)
, [LastChangeDate]              DATE
, [CharacteristicName]          NVARCHAR(30) NOT NULL
, [CharacteristicDescription]   NVARCHAR(30)
, [DecimalValueFrom]            DECIMAL(31, 14)
, [CharValue]                   NVARCHAR(70) NOT NULL
, [CharValueDescription]        NVARCHAR(70)
, [t_applicationId]             VARCHAR (32)
, [t_jobId]                     VARCHAR (36)
, [t_jobDtm]                    DATETIME
, [t_jobBy]                     NVARCHAR (128)
, [t_extractionDtm]             DATETIME
, [t_filePath]                  NVARCHAR (1024) NOT NULL
, CONSTRAINT [PK_Z_C_VariantConfig_delta] PRIMARY KEY NONCLUSTERED (
    [TS_SEQUENCE_NUMBER],[SalesDocument],[SalesDocumentItem],[CharacteristicName], [CharValue] 
  ) NOT ENFORCED
)
WITH (
  HEAP
)
