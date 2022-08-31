CREATE PROCEDURE [utilities].[sp_process_axbi_delta](
    @schema_name VARCHAR(),
    @table_name VARCHAR(),
    @pk_field_names VARCHAR()
)
AS
BEGIN

    DECLARE
        @schema_name VARCHAR(128) = 'base_dw_halfen_2_dwh_uat',
        @table_name VARCHAR(128) = 'FACT_HGDAWA',
        @pk_field_names VARCHAR(128) = 'Invoiceno,Posno',
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
        -- Get list of columns
        @columns VARCHAR(MAX) = (
            SELECT
                c.name
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
            ORDER BY
                c.column_id
        );

    -- INSERT
    EXEC [utilities].[sp_process_axbi_delta_insert](
        @schema_name,
        @table_name,
        @columns,
        @pk_field_names,
        @join_clause
    );

    -- UPDATE

    -- DELETE
END;

CREATE PROCEDURE [utilities].[sp_process_axbi_delta_insert](
    @schema_name VARCHAR(),
    @table_name VARCHAR(),
    @columns,
    @pk_field_names,
    @join_clause
)
AS
BEGIN
    -- INSERT
    DECLARE sql_script NVARCHAR(MAX) = N'
        INSERT ['@schema_name'].['@table_name'_active] ('
            @columns',
            [t_applicationId],
            [t_jobId],
            [t_jobDtm],
            [t_jobBy],
            [t_extractionDtm],
            [t_lastActionBy],
            [t_lastActionCd],
            [t_lastActionDtm],
            [t_filePath]
        )
        SELECT'
            @columns',
            [t_applicationId],
            [t_jobId],
            [t_jobDtm],
            [t_jobBy],
            [t_extractionDtm],'
            SYSTEM_USER' AS [t_lastActionBy],
            ''I'' AS[t_lastActionCd],'
            GETDATE()' AS [t_lastActionDtm],
            [t_filePath]
        FROM
            ['@schema_name'].['@table_name'_new] new
        WHERE NOT EXISTS (
            SELECT'
                @pk_field_names'
            FROM
                ['@schema_name'].['@table_name'_active] active
            WHERE'
                @join_clause'
        )
    ';
    INSERT []
END;


select GETDATE()

DECLARE
        @pk_field_names VARCHAR(128) = 'Invoiceno,Posno',
        @test VARCHAR(MAX);
        
SET @test = (
SELECT
    STRING_AGG(Clause, N' AND ' + CHAR(13)) AS Clause
FROM (
    SELECT
        N'active.' + value + ' = new.' + value AS Clause
    FROM
        STRING_SPLIT(@pk_field_names, ',')
) A);

select @pk_field_names