CREATE PROCEDURE [utilities].[sp_process_axbi_delta_delete]
    @schema_name VARCHAR(128),
    @table_name VARCHAR(128),
    @pk_field_names VARCHAR(MAX),
    @join_clause VARCHAR(MAX)

AS
BEGIN
    DECLARE @where_script NVARCHAR(MAX) = (
        SELECT
            STRING_AGG(Clause, ' AND ')
        FROM (
            SELECT
                N'new.[' + value + '] IS NULL' AS Clause
            FROM
                STRING_SPLIT(@pk_field_names, ',')
        ) A
    );
    DECLARE @sql_script NVARCHAR(MAX) = N'
        UPDATE
            ['+@schema_name+'].['+@table_name+'_active]+
        SET
            [t_lastActionDtm] = '''+GETDATE()+''',
            [t_lastActionCd] = ''D'',
            [t_lastActionBy] = '''+SYSTEM_USER+'''
        FROM
            ['+@schema_name+'].['+@table_name+'_active] AS active
        LEFT JOIN
            ['+@schema_name+'].['+@table_name+'_new] AS new
            ON'+
                @join_clause+'
        WHERE'+
            @where_script+'

    ';

    EXEC sp_execute_sql @sql_script;

END;
