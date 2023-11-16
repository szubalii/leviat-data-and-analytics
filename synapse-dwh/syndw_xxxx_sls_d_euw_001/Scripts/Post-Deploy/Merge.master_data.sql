DECLARE 
    @nbr_statements INT = (SELECT COUNT(*) FROM pgr.masterdata),
    @i INT = 1,
    @date CHAR(23) = FORMAT(GETUTCDATE(), 'yyyy-MM-dd HH:mm:ss.fff');
GO

CREATE TABLE #CopyScripts 
WITH (
    DISTRIBUTION = ROUND_ROBIN
) AS
WITH FilePath AS (
    SELECT
        BaseSchemaName,
        BaseTableName,
        ADLSContainer,
        ADLSDirectory,
        ADLSFileName,
        [pgr].[svf_get_file_path](
            ADLSContainer, 
            ADLSDirectory, 
            ADLSFileName
        ) AS ADLSFilePath,
        FieldDelimiter,
        c.name AS ColumnName,
        c.column_id AS ColumnID
    from pgr.masterdata AS mdc
    LEFT JOIN sys.tables AS t
        ON t.name = mdc.BaseTableName
    LEFT JOIN sys.schemas AS s
        ON s.schema_id = t.schema_id
        AND s.name = mdc.BaseSchemaName
    left join sys.columns AS c
        on c.object_id = t.object_id
)
,ColumnList AS (
    select BaseSchemaName, BaseTableName, ADLSFilePath, FieldDelimiter,
    STRING_AGG(
        CONCAT(
            ColumnName,
            ' ',
            CASE
            WHEN 
                ColumnName = 't_applicationId' 
            THEN
                'DEFAULT ''flat-files'''
            WHEN ColumnName = 't_jobId' THEN 'DEFAULT ''Post Deployment Script'''
            WHEN ColumnName = 't_jobDtm' THEN 'DEFAULT ''' + @date + ''''
            WHEN ColumnName = 't_jobBy' THEN 'DEFAULT ''' + SYSTEM_USER + ''''
            WHEN ColumnName = 't_filePath' THEN 'DEFAULT ''' + ADLSFilePath + ''''
            ELSE CONVERT(VARCHAR(4), ColumnID)
            END
        )
        , ', '
        ) AS columnList
    from FilePath
    group by BaseSchemaName, BaseTableName, ADLSFilePath, FieldDelimiter
)
SELECT
    ROW_NUMBER() OVER(ORDER BY (SELECT NULL)) AS Sequence,
    'TRUNCATE TABLE [' + BaseSchemaName + '].[' + BaseTableName + '];
    COPY INTO [' + BaseSchemaName + '].[' + BaseTableName + '] (' + columnList + ')
    FROM ''https://stxxxxslsdeuw001.blob.core.windows.net/' + ADLSFilePath + '''
    WITH (
        FILE_TYPE = ''CSV'',
        CREDENTIAL = (IDENTITY = ''Managed Identity''),
        FIELDQUOTE = ''"'',
        FIELDTERMINATOR=''' + FieldDelimiter + ''',
        FIRSTROW = 2
    );' AS copyScript
FROM
    ColumnList;
GO

WHILE @i <= @nbr_statements
BEGIN
    DECLARE @sql_code NVARCHAR(4000) = (SELECT copyScript FROM #CopyScripts WHERE Sequence = @i);
    EXEC    sp_executesql @sql_code;
    SET     @i +=1;
END
GO

DROP TABLE #CopyScripts;
