CREATE TABLE [base_ff].[ConfigurableProductCharacteristic]
( 
    [CharacteristicName]        NVARCHAR(30)   NOT NULL,
    [CharacteristicDescription] NVARCHAR(30)   NOT NULL,
    [CharacteristicCategory]    NVARCHAR(30)   NULL,
    [t_applicationId]           VARCHAR(32)    NULL,
    [t_jobId]                   VARCHAR(36)    NULL,
    [t_jobDtm]                  DATETIME       NULL,
    [t_jobBy]                   NVARCHAR(128)  NULL,
    [t_filePath]                NVARCHAR(1024) NULL,
    CONSTRAINT [PK_ConfigurableProductCharacteristic] PRIMARY KEY NONCLUSTERED ([CharacteristicName]) NOT ENFORCED
)
WITH
(
    DISTRIBUTION = REPLICATE,
    HEAP
)
GO