CREATE EXTERNAL TABLE utilities.ext_MasterDataConfig (
    [ADLSDirectory] NVARCHAR(100),
    [ADLSFileName] NVARCHAR(100) NOT NULL,
    [FieldDelimiter] CHAR(1),
    [BaseSchemaName] NVARCHAR(100),
    [BaseTableName] NVARCHAR(100)
)
WITH (
    LOCATION='/master-data-config.csv',
    DATA_SOURCE = eds_FlatFiles,
    FILE_FORMAT = eff_MasterDataConfigFileFormat,
    REJECT_TYPE = VALUE,
    REJECT_VALUE = 0
);
