﻿-- This procedure handles ingestion of parquet files from ADLS into the staging (base) layer in Synapse.
-- As Azure Data Factory doesn't allow to generate the correct COPY INTO SQL query for adding DEFAULT values
-- for technical system field values (t_*), this procedure has been created to handle that.

-- This also means that no separate stored procedure needs to be executed to update the technical field values
-- from ADF. 

CREATE PROC [utilities].[sp_ingest_with_t_values]
    @container_name         NVARCHAR  (63),
    @directory_path         NVARCHAR (128),
    @file_name              NVARCHAR (128),
    @file_structure         NVARCHAR (MAX),
    @schema_name            NVARCHAR (128),
    @table_name             NVARCHAR (128),
    @application_id          VARCHAR  (32),
    @job_id                  VARCHAR  (36),
    @job_dtm                    CHAR  (23),
    @job_by                 NVARCHAR (128),
    @update_mode             VARCHAR   (5),
    @extraction_type         VARCHAR   (5),
    @extraction_timestamp       CHAR  (23),
    @client_field            VARCHAR (127),
    @client_id                  CHAR   (3)
AS
BEGIN

    -- Test for T149T
    -- DECLARE
    --     @container_name NVARCHAR(100) = 's4h-caa-200',
    --     @directory_path NVARCHAR(100) = 'NULL/T149T/Theobald/Table/Full/In/2023/01/09',
    --     @file_name      NVARCHAR(100) = 'T149T_2023_01_09_09_37_56_050.parquet',
    --     @schema_name    NVARCHAR(100) = 'base_s4h_cax',
    --     @table_name     NVARCHAR(100) = 'T149T',
    --     @application_id NVARCHAR(100) = 's4h-caa-200',
    --     @job_id         NVARCHAR(100) = 'ad74e8e7-2f8b-4485-8a09-4b674afdfb54',
    --     @job_dtm            CHAR (23) = FORMAT(GETUTCDATE(), 'yyyy-MM-dd HH:mm:ss.fff'),
    --     @job_by         NVARCHAR(100) = 'df-mpors-d-euw-001',
    --     @update_mode     VARCHAR  (5) = 'Full',
    --     @extraction_type VARCHAR  (5) = 'Table',
    --     @client_field    VARCHAR  (5) = 'MANDT',
    --     @client_id       VARCHAR  (5) = '200';

    -- Test for I_Country
    -- DECLARE
    --     @container_name NVARCHAR(100) = 's4h-caa-200',
    --     @directory_path NVARCHAR(100) = 'DIMENSION/I_Country/Theobald/ODP/Full/In/2023/01/09',
    --     @file_name      NVARCHAR(100) = 'I_Country_2023_01_09_13_12_04_741.parquet',
    --     @schema_name    NVARCHAR(100) = 'base_s4h_cax',
    --     @table_name     NVARCHAR(100) = 'I_Country',
    --     @application_id NVARCHAR(100) = 's4h-caa-200',
    --     @job_id         NVARCHAR(100) = 'ad74e8e7-2f8b-4485-8a09-4b674afdfb54',
    --     @job_dtm            CHAR (23) = FORMAT(GETUTCDATE(), 'yyyy-MM-dd HH:mm:ss.fff'),
    --     @job_by         NVARCHAR(100) = 'df-mpors-d-euw-001',
    --     @update_mode     VARCHAR  (5) = 'Full',
    --     @extraction_type VARCHAR  (5) = 'ODP',
    --     @client_field    VARCHAR  (5) = 'MANDT',
    --     @client_id       VARCHAR  (5) = '200';

    -- DECLARE 
    --   @schema_name NVARCHAR(100) = 'base_s4h_cax',
    --   @table_name NVARCHAR(100) = 'I_ProductPlant',
    --   @directory_path NVARCHAR(100) = 'NULL/I_ProductPlant/Theobald/Table/Full/In/2023/01/17',
    --   @file_name NVARCHAR(100) = 'I_ProductPlant_2023_01_17_15_40_29_087.parquet',
    --   @file_structure NVARCHAR(MAX) = '[
    --     {
    --         "name": "MANDT",
    --         "type": "String"
    --     },
    --     {
    --         "name": "PRODUCT",
    --         "type": "String"
    --     },
    --     {
    --         "name": "PLANT",
    --         "type": "String"
    --     },
    --     {
    --         "name": "MAINTENANCESTATUSNAME",
    --         "type": "String"
    --     },
    --     {
    --         "name": "ISMARKEDFORDELETION",
    --         "type": "String"
    --     },
    --     {
    --         "name": "ISINTERNALBATCHMANAGED",
    --         "type": "String"
    --     },
    --     {
    --         "name": "PROFILECODE",
    --         "type": "String"
    --     },
    --     {
    --         "name": "PROFILEVALIDITYSTARTDATE",
    --         "type": "DateTime"
    --     },
    --     {
    --         "name": "ABCINDICATOR",
    --         "type": "String"
    --     },
    --     {
    --         "name": "PRODUCTISCRITICALPRT",
    --         "type": "String"
    --     },
    --     {
    --         "name": "PURCHASINGGROUP",
    --         "type": "String"
    --     },
    --     {
    --         "name": "GOODSISSUEUNIT",
    --         "type": "String"
    --     },
    --     {
    --         "name": "MRPTYPE",
    --         "type": "String"
    --     },
    --     {
    --         "name": "MRPRESPONSIBLE",
    --         "type": "String"
    --     },
    --     {
    --         "name": "PLANNEDDELIVERYDURATIONINDAYS",
    --         "type": "Decimal"
    --     },
    --     {
    --         "name": "GOODSRECEIPTDURATION",
    --         "type": "Decimal"
    --     },
    --     {
    --         "name": "PERIODTYPE",
    --         "type": "String"
    --     },
    --     {
    --         "name": "PROCUREMENTTYPE",
    --         "type": "String"
    --     },
    --     {
    --         "name": "SPECIALPROCUREMENTTYPE",
    --         "type": "String"
    --     },
    --     {
    --         "name": "SAFETYSTOCKQUANTITY",
    --         "type": "Decimal"
    --     },
    --     {
    --         "name": "MINIMUMLOTSIZEQUANTITY",
    --         "type": "Decimal"
    --     },
    --     {
    --         "name": "MAXIMUMLOTSIZEQUANTITY",
    --         "type": "Decimal"
    --     },
    --     {
    --         "name": "FIXEDLOTSIZEQUANTITY",
    --         "type": "Decimal"
    --     },
    --     {
    --         "name": "PRODUCTIONSUPERVISOR",
    --         "type": "String"
    --     },
    --     {
    --         "name": "OVERDELIVTOLERANCELIMIT",
    --         "type": "Decimal"
    --     },
    --     {
    --         "name": "UNDERDELIVTOLERANCELIMIT",
    --         "type": "Decimal"
    --     },
    --     {
    --         "name": "HASPOSTTOINSPECTIONSTOCK",
    --         "type": "String"
    --     },
    --     {
    --         "name": "STOCKINTRANSFERQUANTITY",
    --         "type": "Decimal"
    --     },
    --     {
    --         "name": "ISBATCHMANAGEMENTREQUIRED",
    --         "type": "String"
    --     },
    --     {
    --         "name": "AVAILABILITYCHECKTYPE",
    --         "type": "String"
    --     },
    --     {
    --         "name": "FISCALYEARVARIANT",
    --         "type": "String"
    --     },
    --     {
    --         "name": "SOURCEOFSUPPLYCATEGORY",
    --         "type": "String"
    --     },
    --     {
    --         "name": "COMMODITY",
    --         "type": "String"
    --     },
    --     {
    --         "name": "COUNTRYOFORIGIN",
    --         "type": "String"
    --     },
    --     {
    --         "name": "REGIONOFORIGIN",
    --         "type": "String"
    --     },
    --     {
    --         "name": "PROFITCENTER",
    --         "type": "String"
    --     },
    --     {
    --         "name": "STOCKINTRANSITQUANTITY",
    --         "type": "Decimal"
    --     },
    --     {
    --         "name": "PRODUCTIONINVTRYMANAGEDLOC",
    --         "type": "String"
    --     },
    --     {
    --         "name": "SERIALNUMBERPROFILE",
    --         "type": "String"
    --     },
    --     {
    --         "name": "PRODUCTCONFIGURATION",
    --         "type": "String"
    --     },
    --     {
    --         "name": "PRODUCTISCONFIGURABLE",
    --         "type": "String"
    --     },
    --     {
    --         "name": "CONFIGURABLEPRODUCT",
    --         "type": "String"
    --     },
    --     {
    --         "name": "ISNEGATIVESTOCKALLOWED",
    --         "type": "String"
    --     },
    --     {
    --         "name": "CONSUMPTIONREFERENCEPRODUCT",
    --         "type": "String"
    --     },
    --     {
    --         "name": "CONSUMPTIONREFERENCEPLANT",
    --         "type": "String"
    --     },
    --     {
    --         "name": "CONSUMPTIONREFUSAGEENDDATE",
    --         "type": "DateTime"
    --     },
    --     {
    --         "name": "CONSUMPTIONQTYMULTIPLIER",
    --         "type": "Decimal"
    --     },
    --     {
    --         "name": "ISCOPRODUCT",
    --         "type": "String"
    --     },
    --     {
    --         "name": "STOCKDETERMINATIONGROUP",
    --         "type": "String"
    --     },
    --     {
    --         "name": "PRODUCTIONSCHEDULINGPROFILE",
    --         "type": "String"
    --     },
    --     {
    --         "name": "PRODUCTUNITGROUP",
    --         "type": "String"
    --     },
    --     {
    --         "name": "MATERIALFREIGHTGROUP",
    --         "type": "String"
    --     },
    --     {
    --         "name": "PRODUCTLOGISTICSHANDLINGGROUP",
    --         "type": "String"
    --     },
    --     {
    --         "name": "DISTRCNTRDISTRIBUTIONPROFILE",
    --         "type": "String"
    --     },
    --     {
    --         "name": "PRODUCTCFOPCATEGORY",
    --         "type": "String"
    --     },
    --     {
    --         "name": "CONSUMPTIONTAXCTRLCODE",
    --         "type": "String"
    --     },
    --     {
    --         "name": "FISCALMONTHCURRENTPERIOD",
    --         "type": "String"
    --     },
    --     {
    --         "name": "FISCALYEARCURRENTPERIOD",
    --         "type": "String"
    --     },
    --     {
    --         "name": "ORIGLBATCHMANAGEMENTISREQUIRED",
    --         "type": "String"
    --     },
    --     {
    --         "name": "ORIGINALBATCHREFERENCEMATERIAL",
    --         "type": "String"
    --     },
    --     {
    --         "name": "GOODSRECEIPTBLOCKEDSTOCKQTY",
    --         "type": "Decimal"
    --     },
    --     {
    --         "name": "HASCONSIGNMENTCTRL",
    --         "type": "String"
    --     },
    --     {
    --         "name": "CONSIGNMENTCONTROL",
    --         "type": "String"
    --     },
    --     {
    --         "name": "GOODISSUEPROCESSINGDAYS",
    --         "type": "Decimal"
    --     },
    --     {
    --         "name": "ISPURGACROSSPURGGROUP",
    --         "type": "String"
    --     },
    --     {
    --         "name": "PRODUCTISEXCISETAXRELEVANT",
    --         "type": "String"
    --     },
    --     {
    --         "name": "ISACTIVEENTITY",
    --         "type": "String"
    --     }
    --   ]',
    --   @container_name NVARCHAR(100) = 's4h-caa-200',
    --   @application_id NVARCHAR(100) = 's4h-caa-200',
    --   @extraction_timestamp CHAR(23) = '2023-01-17 13:12:04.741',
    --   @job_id         NVARCHAR(100) = 'ad74e8e7-2f8b-4485-8a09-4b674afdfb54',
    --   @job_dtm            CHAR (23) = FORMAT(GETUTCDATE(), 'yyyy-MM-dd HH:mm:ss.fff'),
    --   @job_by         NVARCHAR(100) = 'df-mpors-d-euw-001',
    --   @update_mode     VARCHAR  (5) = NULL,
    --   @extraction_type VARCHAR  (5) = NULL,
    --   @client_field    VARCHAR  (5) = NULL,
    --   @client_id       VARCHAR  (5) = NULL;

    DECLARE
        -- Get the date from the file name and convert it to a string
        -- @extraction_dtm_char VARCHAR(23) = CONVERT(
        --     VARCHAR,
        --     [utilities].[svf_getDateFromFileName](@file_name),
        --     21),
        -- generate the complete file path based on container, directory, and file name
        @file_path VARCHAR(1024) = CONCAT_WS('/',
            @container_name,
            @directory_path,
            @file_name
        ),
        @columnList VARCHAR(MAX),
        @script NVARCHAR(MAX),
        @schema_id INT = (SELECT schema_id FROM sys.schemas WHERE [name] = @schema_name);
    
    -- Get the schema id and table id based on the names
    DECLARE @table_id INT = (SELECT object_id FROM sys.tables WHERE [name] = @table_name AND schema_id = @schema_id);

    -- Delete the default values for the system fields from the helper table
    DELETE FROM utilities.t_field_values
    WHERE [table_id] = @table_id
        AND [file_name] = @file_name;
        
    -- Insert the new default values for the system fields in the helper table
    INSERT INTO utilities.t_field_values
    SELECT *
    FROM (
        SELECT
            @table_id   AS [table_id],
            @file_name  AS [file_name]
    ) a
    CROSS JOIN (
                  SELECT 't_applicationId' AS default_field, 1 AS [index], @application_id       AS default_value
        UNION ALL SELECT 't_jobId'         AS default_field, 2 AS [index], @job_id               AS default_value
        UNION ALL SELECT 't_jobDtm'        AS default_field, 3 AS [index], @job_dtm              AS default_value
        UNION ALL SELECT 't_jobBy'         AS default_field, 4 AS [index], @job_by               AS default_value
        UNION ALL SELECT 't_filePath'      AS default_field, 5 AS [index], @file_path            AS default_value
        UNION ALL SELECT 't_extractionDtm' AS default_field, 6 AS [index], @extraction_timestamp AS default_value
    ) b

    -- In case of SAP S4HANA ODP extraction, no MANDT field value exists in the parquet file, so this needs to be
    -- manually added during ingestion in Synapse. Add this default value to the helper table.
    IF @extraction_type = 'ODP' AND @client_field IS NOT NULL
        INSERT INTO utilities.t_field_values
        VALUES (
            @table_id,
            @file_name,
            @client_field,
            0,
            @client_id
        )

    -- Retrieve the list of columns based on the provided table to ingest data to
    -- Also add the technical fields with correct default values
    -- Create an aggregated string of field mappings used in the COPY INTO script.
    -- Add the default values for the technical system fields. 
    SET @columnList = (
        SELECT
            STRING_AGG(
                CONVERT(NVARCHAR(MAX),
                    CASE
                        WHEN f.column_id IS NOT NULL THEN CONCAT('[', c.name, '] ', f.column_id)
                        ELSE CONCAT('[', c.name, '] DEFAULT ''', t.default_value, '''')
                    END
                ), ', '
            -- Make sure to order the fields correctly: list all standard fields first, 
            -- and only then list the fields that have added a DEFAULT value. 
            )  WITHIN GROUP ( ORDER BY t.[index] ASC, f.column_id ASC )
            AS ColumnList
        FROM
            sys.columns AS c
        LEFT JOIN (
            SELECT
                [key]+1 AS [column_id], -- array index starts at 0, so add 1
                JSON_VALUE(value, '$.name') AS [name] -- get the column name from parquet
            FROM
                OPENJSON(@file_structure)-- parse the file structure
        ) AS f
            -- use case INsensitivity between parquet and table field mapping
            ON UPPER (c.name) = UPPER(f.name)
        LEFT JOIN
            utilities.t_field_values AS t
            ON
                t.[table_id] = @table_id
                AND
                t.[file_name] = @file_name
                AND
                t.[default_field] = c.name
        WHERE
            c.object_id = @table_id
            AND (
                f.column_id IS NOT NULL
                OR
                t.default_value IS NOT NULL
            )
    );

    -- Truncate in case of full load
    IF OBJECT_ID(CONCAT('[', @schema_name, '].[', @table_name, ']'), 'U') IS NOT NULL
       AND
       COALESCE(@update_mode, 'Full') <> 'Delta'
    BEGIN
        EXEC (N'TRUNCATE TABLE [' + @schema_name + '].[' + @table_name + ']');
    END

    -- Create the COPY INTO script
    SET @script = N'
        COPY INTO [' + @schema_name + '].[' + @table_name + '] (' + @columnList + ')
        FROM ''https://$(storageAccount).dfs.core.windows.net:443/' + @file_path + '''
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
    -- select @script;
    EXEC sp_executesql @script;
    

END

-- S4H ODP
-- EXEC [utilities].[sp_ingest_with_t_values]
--     's4h-caa-200',
--     'DIMENSION/I_Country/Theobald/ODP/Full/In/2023/01/09',
--     'I_Country_2023_01_09_13_12_04_741.parquet',
--     'base_s4h_cax',
--     'I_Country',
--     's4h-caa-200',
--     'ad74e8e7-2f8b-4485-8a09-4b674afdfb54',
--     '2023-01-11 12:37:00.000',
--     'df-mpors-d-euw-001',
--     'Full',
--     'ODP',
--     'MANDT',
--     '200';

-- -- S4H Table
-- EXEC [utilities].[sp_ingest_with_t_values]
--     's4h-caa-200',
--     'NULL/T149T/Theobald/Table/Full/In/2023/01/09',
--     'T149T_2023_01_09_09_37_56_050.parquet',
--     'base_s4h_cax',
--     'T149T',
--     's4h-caa-200',
--     'ad74e8e7-2f8b-4485-8a09-4b674afdfb54',
--     '2023-01-11 12:37:00.000',
--     'df-mpors-d-euw-001',
--     'Full',
--     'Table',
--     'MANDT',
--     '200';

-- -- AXBI
-- -- Need to remove the additional columns from the source parquet file
-- -- So remove the additional columns from the copy step
-- EXEC [utilities].[sp_ingest_with_t_values]
--     'tx-ca-0-hlp-uat',
--     'CRHCURRENCY/In/2023/01/11',
--     'CRHCURRENCY_2023_01_11_14_05_00_481.parquet',
--     'base_tx_ca_0_hlp',
--     'CRHCURRENCY',
--     'TX_CA_0_HLP',
--     'ad74e8e7-2f8b-4485-8a09-4b674afdfb54',
--     '2023-01-11 12:37:00.000',
--     'df-mpors-d-euw-001',
--     'Full',
--     NULL,
--     NULL,
--     '200';

-- -- USA
-- EXEC [utilities].[sp_ingest_with_t_values]
--     'leviat-db-us',
--     'COMPANIES/In/2023/01/09',
--     'COMPANIES_2023_01_09_09_33_34_082.parquet',
--     'base_us_leviat_db',
--     'COMPANIES',
--     'leviat-db-us',
--     'ad74e8e7-2f8b-4485-8a09-4b674afdfb54',
--     '2023-01-11 12:37:00.000',
--     'df-mpors-d-euw-001',
--     'Full',
--     NULL,
--     NULL,
--     '200';

-- -- C4C
-- -- Need to remove the additional columns from the source parquet file
-- -- So remove the additional columns from the copy step
-- -- Updated DDL to convert VARCHAR to DATETIME
-- EXEC [utilities].[sp_ingest_with_t_values]
--     'c4c',
--     'OpportunityCollection/In/2023/01/11',
--     'OpportunityCollection_2023_01_11_13_15_34_082.parquet',
--     'base_c4c',
--     'OpportunityCollection',
--     'c4c',
--     'ad74e8e7-2f8b-4485-8a09-4b674afdfb54',
--     '2023-01-11 12:37:00.000',
--     'df-mpors-d-euw-001',
--     'Full',
--     NULL,
--     NULL,
--     '200';