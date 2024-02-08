CREATE FUNCTION [utilities].[vw_DeltaUpdateScript](
  @schema_name NVARCHAR(128),
  @active_table_name NVARCHAR(128),
  @delta_view_name NVARCHAR(128),
  @active_table_id INT,
  @system_user NVARCHAR(100),
  @date_time_string NVARCHAR(20)
)

-- Used for generating dynamic SQL for loading delta records from delta table into active table. 
-- This function returns the Where Clause used in the Update statement

RETURNS NVARCHAR(MAX)
AS
BEGIN

  IF @active_table_id IS NULL
  BEGIN
    SET @active_table_id = OBJECT_ID(@schema_name + '.' + @active_table_name, 'U');
  END

  DECLARE @updateStmtWhereClause NVARCHAR(MAX) = (
    SELECT
      STRING_AGG(CAST(col_name AS NVARCHAR(MAX)), CHAR(13) + CHAR(10) + 'AND' + CHAR(13) + CHAR(10))
      WITHIN GROUP ( ORDER BY column_id )
    FROM (
      SELECT
        '[' + @schema_name + '].[' + @active_table_name + '].[' + col_name + '] = src.[' + col_name + ']' AS col_name,
        column_id
      FROM
        [utilities].[vw_PrimaryKeyFields]
      WHERE
        object_id = @active_table_id
    ) a
  );

  DECLARE @update_scrpt NVARCHAR(MAX) = N'UPDATE [' + @schema_name + '].[' + @active_table_name + ']' +
    CHAR(13) + CHAR(10) + 'SET' + CHAR(13) + CHAR(10) + (
    SELECT
      STRING_AGG( CAST(update_stmt AS NVARCHAR(MAX)), ', ' + CHAR(13) + CHAR(10))
      WITHIN GROUP ( ORDER BY column_id )
    FROM (
      SELECT
        CASE
          WHEN c.name = 't_lastActionBy'
            THEN '[' + s.name + '].[' + t.name + '].[' + c.name + '] = ''' + @system_user + ''''
          WHEN c.name = 't_lastActionCd'
            THEN '[' + s.name + '].[' + t.name + '].[' + c.name + '] = ( CASE
  WHEN src.[ODQ_CHANGEMODE] = ''U'' AND src.[ODQ_ENTITYCNTR] =  1 THEN ''U''
  WHEN src.[ODQ_CHANGEMODE] = ''D'' AND src.[ODQ_ENTITYCNTR] = -1 THEN ''D''
END )'
          WHEN c.name = 't_lastActionDtm'
            THEN '[' + s.name + '].[' + t.name + '].[' + c.name + '] = ''' + @date_time_string + ''''
          ELSE
            '[' + s.name + '].[' + t.name + '].[' + c.name + '] = src.[' + c.name + ']' 
        END AS update_stmt,
        c.column_id
      FROM sys.columns AS c
      INNER JOIN sys.tables AS t
        ON t.object_id = c.object_id
      INNER JOIN sys.schemas AS s
        ON s.schema_id = t.schema_id
      WHERE
        s.name = @schema_name
        AND
        t.name = @active_table_name
    ) a
  ) + '
FROM
  [' + @schema_name + '].[' + @delta_view_name + '] as src
WHERE
' + @updateStmtWhereClause;

  RETURN(@update_scrpt);
END;