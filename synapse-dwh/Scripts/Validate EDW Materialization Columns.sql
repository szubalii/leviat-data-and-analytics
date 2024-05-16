WITH 
view_columns AS (
  SELECT
    e.entity_id,
    e.source_view_name,
    e.dest_table_name,
    vc.name AS view_column_name
  FROM
    utilities.vw_entity AS e
  INNER JOIN
    sys.objects v
    ON
      v.name = e.source_view_name
  INNER JOIN
    sys.schemas s
    ON
      s.schema_id = v.schema_id
      AND
      s.name = 'edw'
  LEFT JOIN
    sys.columns AS vc
    ON
      vc.object_id = v.object_id
)
,
table_columns AS (
  SELECT
    e.entity_id,
    e.source_view_name,
    e.dest_table_name,
    tc.name AS table_column_name
  FROM
    utilities.vw_entity AS e
  INNER JOIN
    sys.objects t
    ON
      t.name = e.dest_table_name
  INNER JOIN
    sys.schemas s
    ON
      s.schema_id = t.schema_id
      AND
      s.name = 'edw'
  LEFT JOIN
    sys.columns AS tc
    ON
      tc.object_id = t.object_id
      AND
      tc.is_identity = 0 -- exclude IDENTITY table columns with AUTO INCREMENT
)

SELECT
  *
FROM (
  SELECT
    CAST(vc.entity_id AS INT) AS [Entity ID],
    CAST(vc.source_view_name AS CHAR(35)) AS [Source View Name],
    CAST(vc.dest_table_name AS CHAR(35)) AS [Target Table Name],
    CAST(vc.view_column_name AS CHAR(35)) AS [View Columns missing in Table],
    CAST(tc.table_column_name AS CHAR(35)) AS [Table Columns missing in View]
  FROM 
    view_columns vc
  LEFT JOIN
    table_columns tc
    ON
      vc.entity_id = tc.entity_id
      AND
      vc.view_column_name = tc.table_column_name
  WHERE
    tc.table_column_name IS NULL
    AND
    vc.view_column_name IS NOT NULL
    AND
    vc.view_column_name NOT IN ( -- exclude delta fields
      'ODQ_CHANGEMODE',
      'ODQ_ENTITYCNTR'
    )

  UNION ALL

  SELECT
    tc.entity_id,
    tc.source_view_name,
    tc.dest_table_name,
    vc.view_column_name,
    tc.table_column_name
  FROM 
    table_columns tc
  LEFT JOIN
    view_columns vc
    ON
      vc.entity_id = tc.entity_id
      AND
      vc.view_column_name = tc.table_column_name
  WHERE
    tc.table_column_name NOT IN ( -- exclude technical fields
      't_jobId',
      't_jobBy',
      't_jobDtm',
      't_lastActionBy',
      't_lastActionCd',
      't_lastActionDtm'
    )
    AND
    vc.view_column_name IS NULL
    AND
    tc.table_column_name IS NOT NULL
) a
ORDER BY
  [Entity ID]
