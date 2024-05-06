CREATE VIEW [utilities].[vw_MaterializeColumnList]
AS
SELECT
  v.name as view_name,
  SCHEMA_NAME(v.schema_id) as schema_name,
  STRING_AGG( '[' + CAST(c.name AS NVARCHAR(MAX)) + ']', ',' + CHAR(13) + CHAR(10))
    WITHIN GROUP ( ORDER BY column_id ) AS non_t_job_col_names
FROM
  sys.columns AS c
INNER JOIN
  sys.views AS v
  ON
    v.object_id = c.object_id
WHERE
  c.name NOT IN (
    't_jobId',
    't_jobDtm',
    't_lastActionCd',
    't_jobBy'
  )
GROUP BY
  v.name,
  v.schema_id
