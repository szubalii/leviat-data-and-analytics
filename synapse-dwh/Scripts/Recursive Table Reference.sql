-- DECLARE @view_name NVARCHAR(128) = 'vw_AccountingDocumentType';
CREATE VIEW utilities.vw_execution_order_issue
AS
WITH ViewReferences AS (
  SELECT
    e.source_view_name AS root_view_name,
    -- @view_name AS root_view_name,
    referencing_id,
    OBJECT_NAME(referencing_id) AS referencing_entity_name,
    referencing_o.type_desc AS referencing_description,
    referenced_schema_name,
    referenced_id,
    referenced_o.type_desc AS referenced_desciption,
    OBJECT_NAME(referenced_id) AS referenced_entity_name
  FROM
    sys.sql_expression_dependencies as sed
  INNER JOIN
    sys.objects AS referencing_o
    ON
      sed.referencing_id = referencing_o.object_id
  INNER JOIN
    sys.objects AS referenced_o
    ON
      sed.referenced_id = referenced_o.object_id
  INNER JOIN
    sys.schemas AS s
    ON
      s.schema_id = referencing_o.schema_id
  CROSS JOIN
    utilities.vw_entity AS e
  WHERE
    referenced_schema_name = 'edw'
    AND
    s.name = 'edw'
    AND
    referencing_o.type_desc = 'VIEW'
    -- AND
    -- e.source_view_name IS NOT NULL
    AND
    OBJECT_NAME(referencing_id) = e.source_view_name
)
,
ReferencedEntities AS (
  SELECT
    root_view_name,
    referencing_id,
    referencing_entity_name,
    referencing_description,
    referenced_schema_name,
    referenced_id,
    referenced_desciption,
    referenced_entity_name
  FROM 
    ViewReferences
  WHERE
    referencing_entity_name = root_view_name

  UNION ALL

  SELECT
    r.root_view_name,
    r.referencing_id,
    r.referencing_entity_name,
    r.referencing_description,
    r.referenced_schema_name,
    r.referenced_id,
    r.referenced_desciption,
    r.referenced_entity_name--,
    -- referenced_o.type_desc
  FROM 
    ViewReferences as r, ReferencedEntities
  WHERE
    r.referencing_id = ReferencedEntities.referenced_id
)

SELECT
  re.root_view_name,
  e_root.execution_order AS execution_order_root_view,
  -- re.referencing_id,
  -- re.referencing_entity_name,
  -- re.referencing_description,
  -- re.referenced_schema_name,
  -- re.referenced_entity_name,
  -- e.execution_order AS execution_order_child--,
  MAX(e.execution_order) AS max_execution_order_referenced_views
FROM
  ReferencedEntities re
LEFT JOIN
  utilities.vw_entity e
  ON
    re.referenced_entity_name = e.entity_name
LEFT JOIN
  utilities.vw_entity e_root
  ON
    re.root_view_name = e_root.source_view_name
WHERE
  re.referenced_desciption = 'USER_TABLE'
  AND
  e_root.execution_order <= e.execution_order
GROUP BY
  re.root_view_name,
  e_root.execution_order
ORDER BY
  root_view_name