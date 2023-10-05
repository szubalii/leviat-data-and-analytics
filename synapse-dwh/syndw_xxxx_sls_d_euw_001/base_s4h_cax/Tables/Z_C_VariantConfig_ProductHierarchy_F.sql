CREATE TABLE [base_s4h_cax].[Z_C_VariantConfig_ProductHierarchy_F](
  [SalesDocument]               NVARCHAR(20) NOT NULL
, [SalesDocumentItem]           NVARCHAR(24) NOT NULL -- collate Latin1_General_100_BIN2 NOT NULL
, [ProductID]                   NVARCHAR(40)
, [ProductExternalID]           NVARCHAR(40)
, [Configuration]               NVARCHAR(18)
, [Instance]                    NVARCHAR(22)
, [LastChangeDate]              DATE
, [CharacteristicName]          NVARCHAR(30) NOT NULL
, [CharacteristicDescription]   NVARCHAR(30)
, [DecimalValueFrom]            DECIMAL (31, 14)
, [CharValue]                   NVARCHAR(70) NOT NULL
, [CharValueDescription]        NVARCHAR(70)
, [t_applicationId]             VARCHAR(32)
, [t_jobId]                     VARCHAR(36)
, [t_jobDtm]                    DATETIME
, [t_jobBy]                     VARCHAR(128)
, [t_filePath]                  NVARCHAR(1024)
, [t_extractionDtm]             DATETIME
, CONSTRAINT [PK_Z_C_VariantConfig_ProductHierarchy_F] PRIMARY KEY NONCLUSTERED (
    [SalesDocument],[SalesDocumentItem], [CharacteristicName], [CharValue] 
  ) NOT ENFORCED
)
WITH (
  DISTRIBUTION = HASH ([SalesDocument]), CLUSTERED COLUMNSTORE INDEX
)