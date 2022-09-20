CREATE PROCEDURE [utilities].[sp_process_axbi_delta_insert]
    @schema_name VARCHAR(128),
    @table_name VARCHAR(128),
    @columns VARCHAR(MAX),
    @pk_field_names VARCHAR(MAX),
    @join_clause VARCHAR(MAX)

AS
BEGIN
    -- INSERT
    DECLARE @date_string CHAR(19) = FORMAT(GETDATE(), 'yyyy-MM-dd HH:mm:ss');
    DECLARE @insert_sql_script NVARCHAR(MAX) = N'
        INSERT ['+@schema_name+'].['+@table_name+'_active] ('+
            @columns+',
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
        SELECT '+
            @columns+',
            [t_applicationId],
            [t_jobId],
            [t_jobDtm],
            [t_jobBy],
            [t_extractionDtm],'''+
            SYSTEM_USER+''' AS [t_lastActionBy],
            ''I'' AS[t_lastActionCd],'''+
            @date_string+''' AS [t_lastActionDtm],
            [t_filePath]
        FROM
            ['+@schema_name+'].['+@table_name+'] new
        WHERE NOT EXISTS (
            SELECT '+
                @pk_field_names+'
            FROM
                ['+@schema_name+'].['+@table_name+'_active] active
            WHERE '+
                @join_clause+'
        )
    ';

    EXEC sp_executesql @insert_sql_script;
END;