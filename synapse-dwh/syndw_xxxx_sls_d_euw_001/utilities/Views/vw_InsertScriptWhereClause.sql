/*
  This view generates the WHERE clause used in the dynamic SQL INSERT script
  when processing delta materialization. 

  Its format can be seen in its corresponding test case.
*/

CREATE VIEW [utilities].[vw_InsertScriptWhereClause] 
AS

SELECT
  t.name as table_name,
  SCHEMA_NAME(t.schema_id) as schema_name,
  STRING_AGG( 'target.[' + CAST(COL_NAME(ic.object_id, ic.column_id) AS NVARCHAR(MAX)) + '] = src.[' + COL_NAME(ic.object_id, ic.column_id) + ']', CHAR(13) + CHAR(10) + ' AND ' + CHAR(13) + CHAR(10))
    WITHIN GROUP ( ORDER BY ic.column_id ) AS insert_scrpt_where_clause
  -- ic.column_id,
  -- COL_NAME(ic.object_id, ic.column_id) AS col_name
FROM
  sys.indexes AS i
INNER JOIN
  sys.index_columns AS ic
  ON
    i.object_id = ic.object_id
    AND
    i.index_id = ic.index_id
INNER JOIN
  sys.tables AS t
  ON
    t.object_id = i.object_id
WHERE
  i.is_primary_key = 1
GROUP BY
  t.name,
  t.schema_id
