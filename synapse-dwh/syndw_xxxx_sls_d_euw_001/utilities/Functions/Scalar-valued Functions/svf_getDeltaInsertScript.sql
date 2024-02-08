CREATE FUNCTION [utilities].[svf_getDeltaInsertScript_old](
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

  DECLARE
    @activeTablePrimaryKeyFields NVARCHAR(1024) = (
      SELECT
        STRING_AGG('[' + CAST(col_name AS NVARCHAR(MAX)) + ']', ',' + CHAR(13) + CHAR(10))
        WITHIN GROUP ( ORDER BY column_id )
      FROM (
        SELECT
          col_name,
          column_id
        FROM
          [utilities].[vw_PrimaryKeyFields]
        WHERE
          object_id = @active_table_id
      ) a
    ),
    @insertStmtWhereClause NVARCHAR(MAX) = (
      SELECT
        STRING_AGG(CAST(col_name AS NVARCHAR(MAX)), CHAR(13) + CHAR(10) + 'AND' + CHAR(13) + CHAR(10))
        WITHIN GROUP ( ORDER BY column_id )
      FROM (
        SELECT
          'target.[' + col_name + '] = src.[' + col_name + ']' AS col_name,
          column_id
        FROM
          [utilities].[vw_PrimaryKeyFields]
        WHERE
          object_id = @active_table_id
      ) a
    );

  DECLARE @insert_scrpt NVARCHAR(MAX) = N'INSERT INTO [' + @schema_name + '].[' + @active_table_name + '] (' + CHAR(13) + CHAR(10) + (
      SELECT
        STRING_AGG( '[' + CAST(column_name AS NVARCHAR(MAX)) + ']', ',' + CHAR(13) + CHAR(10))
        WITHIN GROUP ( ORDER BY column_id )
      FROM (
        SELECT
          c.name AS column_name,
          c.column_id
        FROM
          sys.columns AS c
        INNER JOIN
          sys.tables AS t
          ON
            t.object_id = c.object_id
        WHERE
          t.name = @active_table_name
          AND
          SCHEMA_NAME(t.schema_id) = @schema_name
      ) a
    ) + CHAR(13) + CHAR(10) + ')' + CHAR(13) + CHAR(10) + 'SELECT' + CHAR(13) + CHAR(10) + (
    SELECT
      STRING_AGG( CAST(column_name AS NVARCHAR(MAX)), ',' + CHAR(13) + CHAR(10))
      WITHIN GROUP ( ORDER BY column_id )
    FROM (
      SELECT
        CASE
          WHEN c.name = 't_lastActionBy'
            THEN '''' + @system_user + ''' AS [t_lastActionBy]'
          WHEN c.name = 't_lastActionCd'
            THEN N'CASE
  WHEN src.[ODQ_CHANGEMODE] = ''''  AND src.[ODQ_ENTITYCNTR] = 0
    THEN ''I''
  WHEN src.[ODQ_CHANGEMODE] = ''U'' AND src.[ODQ_ENTITYCNTR] = 1
    THEN ''I''
  WHEN src.[ODQ_CHANGEMODE] = ''D'' AND src.[ODQ_ENTITYCNTR] = -1
    THEN ''D''
  WHEN src.[ODQ_CHANGEMODE] = ''C'' AND src.[ODQ_ENTITYCNTR] = 1
    THEN ''I''
END AS [t_lastActionCd]'
          WHEN c.name = 't_lastActionDtm'
            THEN '''' + @date_time_string + ''' AS [t_lastActionDtm]'
          ELSE
            '[' + c.name + ']'
        END AS column_name,
        c.column_id
      FROM
        sys.columns AS c
      INNER JOIN
        sys.tables AS t
        ON
          t.object_id = c.object_id
      WHERE
        t.name = @active_table_name
        AND
        SCHEMA_NAME(t.schema_id) = @schema_name
    ) a
    ) + '
FROM
  [' + @schema_name + '].[' + @delta_view_name + '] as src
WHERE NOT EXISTS (
  SELECT
    ' + @activeTablePrimaryKeyFields + '
  FROM
    [' + @schema_name + '].[' + @active_table_name + '] target
  WHERE
    ' + @insertStmtWhereClause + '
)';

  RETURN(@insert_scrpt);
END;