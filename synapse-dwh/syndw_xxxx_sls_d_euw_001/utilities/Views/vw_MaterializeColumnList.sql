CREATE VIEW [utilities].[vw_MaterializeColumnList]
AS
SELECT
  t.name as table_name,
  SCHEMA_NAME(t.schema_id) as schema_name,
  STRING_AGG( '[' + CAST(c.name AS NVARCHAR(MAX)) + ']', ',' + CHAR(13) + CHAR(10))
    WITHIN GROUP ( ORDER BY column_id ) AS non_t_job_col_names
FROM
  sys.columns AS c
INNER JOIN
  sys.tables AS t
  ON
    t.object_id = c.object_id
WHERE
  c.name NOT IN (
    't_jobId',
    't_jobDtm',
    't_lastActionCd',
    't_jobBy'
  )
GROUP BY
  t.name,
  t.schema_id
