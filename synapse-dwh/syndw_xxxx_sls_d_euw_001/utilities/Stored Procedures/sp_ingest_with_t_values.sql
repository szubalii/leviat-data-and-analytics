CREATE PROC [utilities].[sp_ingest_with_t_values]
    @container_name NVARCHAR (50),
    @directory_path NVARCHAR(128),
    @file_name      NVARCHAR(128),
    @schema_name    NVARCHAR(128),
    @table_name     NVARCHAR(128),
    @application_id NVARCHAR (23),
    @job_id         NVARCHAR (36),
    @job_dtm            CHAR (23),
    @job_by         NVARCHAR(128),
    @update_mode     VARCHAR  (5),
    @extraction_type VARCHAR  (5),
    @client_field    VARCHAR  (5),
    @client_id       VARCHAR  (5)
AS
BEGIN

    DECLARE
        @container_name NVARCHAR(100) = 's4h-caa-200',
        @directory_path NVARCHAR(100) = 'DIMENSION/I_Country/Theobald/ODP/Full/In/2023/01/09',--'NULL/T149T/Theobald/Table/Full/In/2023/01/09',
        @file_name      NVARCHAR(100) = 'I_Country_2023_01_09_13_12_04_741.parquet',--'T149T_2023_01_09_09_37_56_050.parquet',
        @schema_name    NVARCHAR(100) = 'base_s4h_cax',
        @table_name     NVARCHAR(100) = 'I_Country',--'T149T',
        @application_id NVARCHAR(100) = 's4h-caa-200',
        @job_id         NVARCHAR(100) = 'ad74e8e7-2f8b-4485-8a09-4b674afdfb54',
        @job_dtm            CHAR (23) = FORMAT(GETUTCDATE(), 'yyyy-MM-dd HH:mm:ss.fff'),
        @job_by         NVARCHAR(100) = 'df-mpors-d-euw-001',
        @update_mode     VARCHAR  (5) = 'Full',
        @extraction_type VARCHAR  (5) = 'ODP',
        @client_field    VARCHAR  (5) = 'MANDT',
        @client_id       VARCHAR  (5) = '200';

    DECLARE
        -- Get the date from the file name and convert it to a string
        @extraction_dtm_char VARCHAR(23) = CONVERT(
            VARCHAR,
            [utilities].[svf_getDateFromFileName](@file_name),
            21),
        -- generate the complete file path based on container, directory, and file name
        @file_path VARCHAR(1024) = CONCAT_WS('/',
            @container_name,
            @directory_path,
            @file_name
        ),
        @columnList VARCHAR(MAX),
        @script NVARCHAR(MAX);

    IF OBJECT_ID('tempdb..#t_field_values', 'U') IS NOT NULL
        DROP TABLE [tempdb].[#t_field_values]
    
    -- Store the technical system field with their values in a temp table
    CREATE TABLE #t_field_values
    WITH (DISTRIBUTION = ROUND_ROBIN)
    AS 
        SELECT 't_applicationId' AS t_field_name, 1 AS id, @application_id AS default_value
        UNION ALL SELECT 't_jobId', 2, @job_id
        UNION ALL SELECT 't_jobDtm', 3, @job_dtm
        UNION ALL SELECT 't_jobBy', 4, @job_by
        UNION ALL SELECT 't_filePath', 5, @file_path
        UNION ALL SELECT 't_extractionDtm', 6, @extraction_dtm_char
    
    -- also store MANDT with its value in case of S4H extraction of type ODP
    IF @extraction_type = 'ODP'
        INSERT INTO #t_field_values
        VALUES (@client_field, 0, @client_id)

    -- SELECT * FROM #t_field_values;

    -- Construct the technical field mapping with default values
    DECLARE @tFieldList VARCHAR(MAX) = (
        SELECT
            STRING_AGG(
                CONCAT(t_field_name,  ' DEFAULT ''', default_value, ''''),
                ', '
            ) WITHIN GROUP ( ORDER BY id)
        FROM
            #t_field_values
    )

    -- select @tFieldList

    -- Retrieve the list of columns based on the table to ingest data to
    -- Also add the technical fields with correct default values
    SET @columnList = (
        SELECT
            CONCAT(
                STRING_AGG(
                    CONCAT('[', c.name, ']')
                    , ', '
                )  WITHIN GROUP ( ORDER BY c.column_id ASC ),
                ', ', 
                @tFieldList
            ) AS ColumnList
        FROM
            sys.columns AS c
        LEFT JOIN
            sys.tables AS t
            ON
                t.object_id = c.object_id
        LEFT JOIN
            sys.schemas AS s
            ON
                s.schema_id = t.schema_id
        WHERE
            s.name = @schema_name
            AND
            t.name = @table_name
            AND
            c.name NOT IN (
                SELECT t_field_name FROM #t_fields
            )
    );

    -- Create the COPY INTO script
    -- TODO ingest into temp table, then rename both tables
    -- TODO update storageaccount
    SET @script = N'
        -- IF OBJECT_ID([' + @schema_name + '].[' + @table_name + '_tmp]) IS NOT NULL
        --     DROP TABLE [' + @schema_name + '].[' + @table_name + '_tmp];

        -- CREATE TABLE [' + @schema_name + '].[' + @table_name + '_tmp]
        -- WITH
        -- (
        --     DISTRIBUTION = ROUND_ROBIN
        -- )
        -- AS SELECT * FROM [' + @schema_name + '].[' + @table_name + '] WHERE 1=0;

        IF OBJECT_ID(''[' + @schema_name + '].[' + @table_name + ']'') IS NOT NULL AND ''' + @update_mode + ''' <> ''Delta''
            TRUNCATE TABLE [' + @schema_name + '].[' + @table_name + '];

        COPY INTO [' + @schema_name + '].[' + @table_name + '] (' + @columnList + ')
        FROM ''https://stmporsdeuw001.dfs.core.windows.net:443/' + @file_path + '''
        WITH (
            IDENTITY_INSERT=''OFF'',
            CREDENTIAL=(IDENTITY=''Managed Identity''),
            FILE_TYPE=''PARQUET'',
            COMPRESSION=''Snappy''
        )
        OPTION (
            LABEL=''Ingest [' + @schema_name + '].[' + @table_name + ']; ADF RunId: ' + @job_id + '''
        )
    ';

    select @script;
    
    EXEC sp_executesql @script;

END

IF OBJECT_ID('[base_s4h_cax].[I_Country]') IS NOT NULL AND 'Full' <> 'Delta'
    TRUNCATE TABLE [base_s4h_cax].[I_Country];
    
COPY INTO [base_s4h_cax].[I_Country] (
    [COUNTRY],
    [CountryThreeLetterISOCode],
    [CountryThreeDigitISOCode],
    [CountryCurrency],
    [IndexBasedCurrency],
    [HardCurrency],
    [TaxCalculationProcedure],
    [CountryAlternativeCode],
    MANDT DEFAULT '200',
    t_applicationId DEFAULT 's4h-caa-200',
    t_jobId DEFAULT 'ad74e8e7-2f8b-4485-8a09-4b674afdfb54',
    t_jobDtm DEFAULT '2023-01-11 11:08:27.753',
    t_jobBy DEFAULT 'df-mpors-d-euw-001',
    t_filePath DEFAULT 's4h-caa-200/DIMENSION/I_Country/Theobald/ODP/Full/In/2023/01/09/I_Country_2023_01_09_13_12_04_741.parquet',
    t_extractionDtm DEFAULT '2023-01-09 13:12:04.740')
FROM 'https://stmporsdeuw001.dfs.core.windows.net:443/s4h-caa-200/DIMENSION/I_Country/Theobald/ODP/Full/In/2023/01/09/I_Country_2023_01_09_13_12_04_741.parquet'
 WITH (
    IDENTITY_INSERT='OFF',
    CREDENTIAL=(IDENTITY='Managed Identity'),
    FILE_TYPE='PARQUET',
    COMPRESSION='Snappy'
)
OPTION (
    LABEL='Ingest I_Country, ADF RunId: ad74e8e7-2f8b-4485-8a09-4b674afdfb54'
)