CREATE EXTERNAL FILE FORMAT eff_MasterDataConfigFileFormat
WITH (
    FORMAT_TYPE = DELIMITEDTEXT,
    FORMAT_OPTIONS (
        FIELD_TERMINATOR = ';',
        STRING_DELIMITER = '"',
        DATE_FORMAT = 'yyyy-MM-dd HH:mm:ss.fff',
        USE_TYPE_DEFAULT = TRUE,
        FIRST_ROW = 2
    )
)
