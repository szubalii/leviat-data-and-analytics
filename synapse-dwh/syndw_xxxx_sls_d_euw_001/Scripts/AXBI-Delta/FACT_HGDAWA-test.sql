DECLARE
        @schema_name VARCHAR(128) = 'base_dw_halfen_2_dwh',
        @table_name VARCHAR(128) = 'FACT_HGDAWA',
        @pk_field_names VARCHAR(128) = 'Company,Orderno,Invoiceno,Posno';
    --    @axbi_sys_fields VARCHAR(MAX) = 'DW_Id'',''DW_Batch'',''DW_SourceCode'',''DW_TimeStamp';

    -- Create temp table to store the table columns 
    -- excluding AXBI and Azure DWH system fields

    -- Verify that the temp table does not exist.  
    IF OBJECT_ID (N'tempdb..#columns', N'U') IS NOT NULL
        DROP TABLE #columns;

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

DECLARE
        @date_string CHAR(19) = FORMAT(GETDATE(), 'yyyy-MM-dd HH:mm:ss');
    DECLARE @update_sql_script NVARCHAR(MAX) = N'
        UPDATE ['+@schema_name+'].['+@table_name+'_active]
        SET '+
            @set_script+',
            [t_applicationId] = new.[t_applicationId],
            [t_jobId]         = new.[t_jobId],
            [t_jobDtm]        = new.[t_jobDtm],
            [t_jobBy]         = new.[t_jobBy],
            [t_extractionDtm] = new.[t_extractionDtm],
            [t_lastActionDtm] = '''+@date_string+''',
            [t_lastActionCd]  = ''U'',
            [t_lastActionBy]  = '''+SYSTEM_USER+''',
            [t_filePath]      = new.[t_filePath]
        FROM
            ['+@schema_name+'].['+@table_name+'_active] AS active
        INNER JOIN
            ['+@schema_name+'].['+@table_name+'] AS new
            ON '+
                @join_clause+'
                AND '+
                @checksum_script+' <> active.[t_binaryCheckSum]';

select 1;