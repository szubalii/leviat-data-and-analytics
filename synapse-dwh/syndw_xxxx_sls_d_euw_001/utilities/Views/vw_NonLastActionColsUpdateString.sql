CREATE VIEW [utilities].[vw_NonLastActionColsUpdateString]
AS
SELECT
  t.name as table_name,
  SCHEMA_NAME(t.schema_id) as schema_name,
  STRING_AGG( '[' + SCHEMA_NAME(t.schema_id) + '].[' + t.name + '].[' + CAST(c.name AS NVARCHAR(MAX)) + '] = src.[' + c.name + ']', ',' + CHAR(13) + CHAR(10))
    WITHIN GROUP ( ORDER BY column_id ) AS non_lastAction_cols_update
FROM
  sys.columns AS c
INNER JOIN
  sys.tables AS t
  ON
    t.object_id = c.object_id
WHERE
  c.name NOT IN (
    't_lastActionBy',
    't_lastActionCd',
    't_lastActionDtm'
  )
GROUP BY
  t.name,
  t.schema_id
