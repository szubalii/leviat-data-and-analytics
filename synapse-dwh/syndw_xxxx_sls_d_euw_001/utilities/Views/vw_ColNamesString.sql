/*
  This view generates a single string record based on the columns of tables.
  This view is used in the process of delta materialization. 

  Its format can be seen in its corresponding test case.
*/

CREATE VIEW [utilities].[vw_ColNamesString] 
AS
SELECT
  t.name as table_name,
  SCHEMA_NAME(t.schema_id) as schema_name,
  STRING_AGG( '[' + CAST(c.name AS NVARCHAR(MAX)) + ']', ',' + CHAR(13) + CHAR(10))
    WITHIN GROUP ( ORDER BY column_id ) AS col_names
FROM
  sys.columns AS c
INNER JOIN
  sys.tables AS t
  ON
    t.object_id = c.object_id
GROUP BY
  t.name,
  t.schema_id
