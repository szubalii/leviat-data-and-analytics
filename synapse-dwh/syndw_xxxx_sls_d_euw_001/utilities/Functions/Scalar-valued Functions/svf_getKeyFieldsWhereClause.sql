CREATE FUNCTION [utilities].[svf_getKeyFieldsWhereClause](
  @schema_name NVARCHAR(128),
  @table_name NVARCHAR(128)
)

-- Used for generating dynamic SQL for loading delta records from delta table into active table. 
-- This function returns the Where Clause used in the Update statement

RETURNS NVARCHAR(1024)
AS
BEGIN
  DECLARE @where_stmt NVARCHAR(1024) = (
    SELECT
      STRING_AGG(where_stmt, CHAR(13) + CHAR(10) + 'AND' + CHAR(13) + CHAR(10))
      WITHIN GROUP ( ORDER BY column_id )
    FROM (
      SELECT
        '[' + @schema_name + '].[' + @table_name + '].[' + col_name + '] = src.[' + col_name + ']' AS where_stmt,
        column_id
      FROM (
        SELECT
          COL_NAME(ic.object_id, ic.column_id) AS col_name,
          ic.column_id
        FROM
          sys.indexes AS i
        INNER JOIN
          sys.index_columns AS ic
          ON
            i.object_id = ic.object_id
            AND
            i.index_id = ic.index_id
        WHERE
          i.is_primary_key = 1
          AND
          i.name = (
            SELECT
              kc.name
            FROM
              sys.key_constraints AS kc
            WHERE
              OBJECT_NAME(kc.parent_object_id) = @table_name
              AND
              SCHEMA_NAME(kc.schema_id) = @schema_name
              AND
              kc.type = 'PK'
          )
      ) a
    ) b
  );

  RETURN(@where_stmt);
END;
