CREATE PROCEDURE [utilities].[sp_process_axbi_delta]
    @schema_name VARCHAR(128),
    @table_name VARCHAR(128),
    @pk_field_names VARCHAR(MAX)

AS
BEGIN

    --DECLARE
    --    @schema_name VARCHAR(128) = 'base_dw_halfen_2_dwh',
    --    @table_name VARCHAR(128) = 'FACT_HGDAWA',
    --    @pk_field_names VARCHAR(128) = 'Company,Orderno,Invoiceno,Posno',
    --    @axbi_sys_fields VARCHAR(MAX) = 'DW_Id'',''DW_Batch'',''DW_SourceCode'',''DW_TimeStamp';

    -- Create temp table to store the table columns 
    -- excluding AXBI and Azure DWH system fields

    SELECT
        c.name,
        c.column_id
    INTO
        #columns
    FROM
        sys.columns c
    INNER JOIN
        sys.tables t
        ON
            t.object_id = c.object_id
    INNER JOIN
        sys.schemas s
        ON
            s.schema_id = t.schema_id
    WHERE
        t.name = @table_name
        AND
        s.name = @schema_name
        AND
        c.name NOT IN (
            'DW_Id',
            'DW_Batch',
            'DW_SourceCode',
            'DW_TimeStamp'
        )
        AND
        c.name NOT IN (
            't_applicationId',
            't_jobId',
            't_jobDtm',
            't_jobBy',
            't_extractionDtm',
            't_binaryCheckSum',
            't_filePath'
        )

    -- Need use of multiple DECLARE statements because variables are dependent on each other.
    DECLARE
        @join_clause VARCHAR(MAX) = (
            SELECT
                STRING_AGG(Clause, N' AND ' + CHAR(13))
            FROM (
                SELECT
                    N'active.' + value + ' = new.' + value AS Clause
                FROM
                    STRING_SPLIT(@pk_field_names, ',')
            ) A
        ),
        -- Get list of columns incl. primary key fields
        @columns VARCHAR(MAX) = CONCAT(
            '[',
            (
            SELECT
                STRING_AGG(CONVERT(NVARCHAR(MAX), name), '],[') WITHIN GROUP (ORDER BY column_id ASC) 
            FROM
                #columns
            ),
            ']'
        ),
        -- Get list of columns excl. primary key fields
        @columns_wo_pk VARCHAR(MAX) = CONCAT(
            '[',
            (
                SELECT
                    STRING_AGG(CONVERT(NVARCHAR(MAX), name), '],[') WITHIN GROUP (ORDER BY column_id ASC) 
                FROM
                    #columns
                WHERE
                    -- Exclude the primary key fields from the list of columns
                    PATINDEX(CONCAT('%',name,'%'), @pk_field_names) = 0
            ),
            ']'
        );
    DECLARE
        @set_script NVARCHAR(MAX) = (
            SELECT
                STRING_AGG(Clause, ',')
            FROM (
                SELECT
                    N'' + value + ' = new.' + value + '' AS Clause
                FROM
                    STRING_SPLIT(@columns_wo_pk, ',')
            ) A
        ),
        -- Set checksum of columns
        -- Investigated use of HASH_BYTES but too many drawbacks:
        -- HASHBYTES does not support multiple parameters, so one first needs to create massive concatenation
        -- CONCAT has limit for number of parameters (255) but FACT_HGDAWA has more fields than that
        -- CONCAT_WS ignores NULL values, so one needs to use COALESCE
        -- All this complicates use of generic approach too much, so let's use BINARY_CHECKSUM instead.
        @checksum_script NVARCHAR(MAX) = (
            SELECT
                CONCAT(
                    'BINARY_CHECKSUM(',
                    Columns,
                    ')'
                )
            FROM (
                SELECT
                    STRING_AGG(Clause, ',') AS Columns
                FROM (
                    SELECT
                        N'new.' + value + '' AS Clause
                    FROM
                        STRING_SPLIT(@columns_wo_pk, ',')
                ) A
            ) B
        );

     --INSERT
     EXEC [utilities].[sp_process_axbi_delta_insert]
         @schema_name,
         @table_name,
         @columns,
         @pk_field_names,
         @join_clause,
         @checksum_script
    ;

    -- UPDATE
    EXEC [utilities].[sp_process_axbi_delta_update]
        @schema_name,
        @table_name,
        @set_script,
        @checksum_script,
        @join_clause
    ;

    -- DELETE
    EXEC [utilities].[sp_process_axbi_delta_delete]
        @schema_name,
        @table_name,
        @pk_field_names,
        @join_clause
    ;


END;