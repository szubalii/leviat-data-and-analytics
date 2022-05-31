CREATE PROCEDURE [utilities].[sp_ingest_master_data]
AS
BEGIN

  DECLARE
    @nbr_statements INT = (SELECT COUNT(*) FROM utilities.ext_MasterDataConfig),
    @i INT = 1,
    @date CHAR(23) = FORMAT(GETUTCDATE(), 'yyyy-MM-dd HH:mm:ss.fff'),
    @ADLSContainer CHAR(10) = 'flat-files';

  -- Create temp table that contains the sql script to ingest data
  CREATE TABLE #CopyScripts 
  WITH (
    DISTRIBUTION = ROUND_ROBIN
  ) AS
  -- get the correct file path for each master data table
  WITH FilePath AS (
    SELECT
      BaseSchemaName,
      BaseTableName,
      ADLSDirectory,
      ADLSFileName,
      [utilities].[svf_get_file_path](
        @ADLSContainer,
        ADLSDirectory,
        ADLSFileName
      ) AS ADLSFilePath,
      FieldDelimiter,
      c.name AS ColumnName,
      c.column_id AS ColumnID
    FROM utilities.ext_MasterDataConfig AS mdc
    JOIN sys.tables AS t
      ON t.name = mdc.BaseTableName
    JOIN sys.schemas AS s
      ON
        s.schema_id = t.schema_id
        AND
        s.name = mdc.BaseSchemaName
    JOIN sys.columns AS c
      ON c.object_id = t.object_id
  )
  -- Retrieve the list of columns based on the table to ingest data to
  -- Also add the technical fields with correct default values
  , ColumnList AS (
    SELECT BaseSchemaName, BaseTableName, ADLSFilePath, FieldDelimiter,
      CONCAT(
        STRING_AGG(
          CONCAT(
            ColumnName,
            ' ',
            CONVERT(VARCHAR(4), ColumnID)
          ),
          ', '
        ) WITHIN GROUP ( ORDER BY ColumnID ASC ),
        ', t_applicationId DEFAULT ''' + @ADLSContainer + ''',
           t_jobId DEFAULT ''Post Deployment Script'',
           t_jobDtm DEFAULT ''' + @date + ''',
           t_jobBy DEFAULT ''' + SYSTEM_USER + ''',
           t_filePath DEFAULT ''' + ADLSFilePath + ''''
      ) AS columnList
      FROM FilePath
      -- filter out the technical fields and add them manually in column list 
      -- to make sure order of fields is correct
      WHERE
        ColumnName NOT IN (
          't_applicationId',
          't_jobId',
          't_jobDtm',
          't_jobBy',
          't_filePath'
      )
      GROUP BY BaseSchemaName, BaseTableName, ADLSFilePath, FieldDelimiter
  )

  -- Construct the sql script
  SELECT
    ROW_NUMBER() OVER(ORDER BY (SELECT NULL)) AS Sequence,
    'TRUNCATE TABLE [' + BaseSchemaName + '].[' + BaseTableName + '];
      COPY INTO [' + BaseSchemaName + '].[' + BaseTableName + '] (' + columnList + ')
      FROM ''https://$(storageAccount).blob.core.windows.net/' + ADLSFilePath + '''
      WITH (
        FILE_TYPE = ''CSV'',
        CREDENTIAL = (IDENTITY = ''Managed Identity''),
        FIELDQUOTE = ''"'',
        FIELDTERMINATOR=''' + FieldDelimiter + ''',
        FIRSTROW = 2
    );' AS copyScript
  FROM
    ColumnList

  WHILE @i <= @nbr_statements
  BEGIN
    DECLARE @sql_code NVARCHAR(4000) = (
      SELECT copyScript FROM #CopyScripts WHERE Sequence = @i
    );
    EXEC sp_executesql @sql_code;
    SET @i +=1;
  END

  DROP TABLE #CopyScripts;

END;
