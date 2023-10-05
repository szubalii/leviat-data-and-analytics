CREATE TABLE [edw].[fact_ProductHierarchyVariantConfigCharacteristic_active]
(
[SalesDocument]                NVARCHAR(20) NOT NULL
,[SalesDocumentItem]           NVARCHAR(24) NOT NULL -- collate Latin1_General_100_BIN2 NOT NULL
,[ProductID]                   NVARCHAR(40)
,[ProductExternalID]           NVARCHAR(40)
,[ProductSurrogateKey]         NVARCHAR(117)
,[Configuration]               NVARCHAR(18)
,[Instance]                    NVARCHAR(22)
,[LastChangeDate]              DATETIME2
,[CharacteristicName]          NVARCHAR(30) NOT NULL
,[CharacteristicDescription]   NVARCHAR(30)
,[DecimalValueFrom]            DECIMAL (31, 14)
,[CharValue]                   NVARCHAR(70) NOT NULL
,[CharValueDescription]        NVARCHAR(70)
,[t_applicationId]             VARCHAR(32)
,[t_jobId]                     VARCHAR(36)
,[t_jobDtm]                    DATETIME
,[t_lastActionCd]              VARCHAR(1)
,[t_jobBy]                     NVARCHAR(128)
,[t_extractionDtm]             DATETIME
,CONSTRAINT [PK_fact_ProductHierarchyVariantConfigCharacteristic_active] PRIMARY KEY NONCLUSTERED (
[SalesDocument],[SalesDocumentItem], [CharacteristicName], [CharValue]
) NOT ENFORCED
)
WITH
    (DISTRIBUTION = REPLICATE, HEAP )
GO