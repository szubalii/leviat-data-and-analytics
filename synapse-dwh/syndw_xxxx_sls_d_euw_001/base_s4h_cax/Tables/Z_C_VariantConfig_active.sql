﻿CREATE TABLE [base_s4h_cax].[Z_C_VariantConfig_active](
  [SalesDocument]               NVARCHAR(20) NOT NULL
, [SalesDocumentItem]           NVARCHAR(24) collate Latin1_General_100_BIN2 NOT NULL
, [ProductID]                   NVARCHAR(40)
, [ProductExternalID]           NVARCHAR(40)
, [Configuration]               NVARCHAR(18)
, [Instance]                    NVARCHAR(22)
, [LastChangeDate]              DATETIME2
, [CharacteristicName]          NVARCHAR(30)
, [CharacteristicDescription]   NVARCHAR(30)
, [DecimalValueFrom]            DECIMAL (31, 14)
, [CharValue]                   NVARCHAR(70)
, [CharValueDescription]        NVARCHAR(70)
, [t_applicationId]             VARCHAR(32)
, [t_jobId]                     VARCHAR(36)
, [t_jobDtm]                    DATETIME
, [t_jobBy]                     VARCHAR(128)
, [t_extractionDtm]             DATETIME
, [t_lastActionBy]              VARCHAR(128)
, [t_lastActionCd]              CHAR(1)
, [t_lastActionDtm]             DATETIME
, [t_filePath]                  NVARCHAR(1024)
, CONSTRAINT [PK_Z_C_VariantConfig_active] PRIMARY KEY NONCLUSTERED (
    [SalesDocument],[SalesDocumentItem]
  ) NOT ENFORCED
)
WITH (
  DISTRIBUTION = HASH ([SalesDocument]), CLUSTERED COLUMNSTORE INDEX
)