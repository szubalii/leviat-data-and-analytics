CREATE PROCEDURE [utilities].[sp_process_axbi_delta_delete]
    @schema_name VARCHAR(128),
    @table_name VARCHAR(128),
    @pk_field_names VARCHAR(MAX),
    @join_clause VARCHAR(MAX)

AS
BEGIN
    DECLARE 
        @where_script NVARCHAR(MAX) = (
            SELECT
                STRING_AGG(Clause, ' AND ')
            FROM (
                SELECT
                    N'new.[' + value + '] IS NULL' AS Clause
                FROM
                    STRING_SPLIT(@pk_field_names, ',')
            ) A
        ),
        @date_string CHAR(19) = FORMAT(GETDATE(), 'yyyy-MM-dd HH:mm:ss');
    DECLARE @delete_sql_script NVARCHAR(MAX) = N'
        UPDATE
            ['+@schema_name+'].['+@table_name+'_active]
        SET
            [t_lastActionDtm] = '''+@date_string+''',
            [t_lastActionCd] = ''D'',
            [t_lastActionBy] = '''+SYSTEM_USER+'''
        FROM
            ['+@schema_name+'].['+@table_name+'_active] AS active
        LEFT JOIN
            ['+@schema_name+'].['+@table_name+'] AS new
            ON '+
                @join_clause+'
        WHERE '+
            @where_script+'

    ';

    EXEC sp_executesql @delete_sql_script;

END;