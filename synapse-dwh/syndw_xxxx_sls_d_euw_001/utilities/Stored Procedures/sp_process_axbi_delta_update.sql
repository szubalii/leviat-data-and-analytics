CREATE PROCEDURE [utilities].[sp_process_axbi_delta_update]
    @schema_name VARCHAR(128),
    @table_name VARCHAR(128),
    @set_script VARCHAR(MAX),
    @checksum_script VARCHAR(MAX),
    @join_clause VARCHAR(MAX)

AS
BEGIN
    -- UPDATE
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

    EXEC sp_executesql @update_sql_script;
END;