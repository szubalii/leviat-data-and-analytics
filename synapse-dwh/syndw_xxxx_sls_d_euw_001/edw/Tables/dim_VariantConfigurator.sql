CREATE TABLE [edw].[dim_VariantConfigurator]
(
    [SalesDocument]                 NVARCHAR(20) NOT NULL,
    [SalesDocumentItem]             NVARCHAR(24) collate Latin1_General_100_BIN2 NOT NULL,
    [ProductID]                     NVARCHAR(40),
    [ProductExternalID]             NVARCHAR(40),
    [CharacteristicName]            NVARCHAR(30) NOT NULL,
    [CharacteristicDescription]     NVARCHAR(30), 
    [t_applicationId]               VARCHAR(32),
    [t_extractionDtm]               DATETIME,
    [t_jobId]                       VARCHAR(36),
    [t_jobDtm]                      DATETIME,
    [t_lastActionCd]                varchar(1),
    [t_jobBy]                       VARCHAR(128),
    CONSTRAINT [PK_dim_VariantConfigurator] PRIMARY KEY NONCLUSTERED
        ([SalesDocument],
         [SalesDocumentItem],
         [CharacteristicName])
        NOT ENFORCED
)
    WITH
        (
        DISTRIBUTION = REPLICATE, HEAP )
GO