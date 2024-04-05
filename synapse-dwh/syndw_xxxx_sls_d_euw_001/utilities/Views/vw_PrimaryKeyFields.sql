CREATE VIEW [utilities].[vw_PrimaryKeyFields]
AS
SELECT
  i.object_id,
  ic.column_id,
  COL_NAME(ic.object_id, ic.column_id) AS col_name
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