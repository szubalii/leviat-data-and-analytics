/*
  This view checks if the edw entities have an incorrectly
  configured execution order.

  If uses a recursive call by for each edw entity in the entity.json file
  first retrieving all its referenced entities based on its view logic.
  It's recursive as it checks referenced views all the way down untill only 
  tables are found. 

  Finally, - for each edw entity - it retrieves the execution orders
  of all its child references and compares it to the execution order of the
  root edw entity. The execution order of its child references should be lower
  than the execution order of the root edw entity

*/
CREATE VIEW utilities.vw_edw_entity_execution_order_issue
AS
WITH

-- Find all child view references part of the edw schema
-- for all edw entities from the entity.json file
ViewReferences AS (
  SELECT
    e.source_view_name AS root_view_name,
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
    AND
    OBJECT_NAME(referencing_id) = e.source_view_name
)
,
-- calling itself recursively
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
    r.referenced_entity_name
  FROM 
    ViewReferences as r, ReferencedEntities
  WHERE
    r.referencing_id = ReferencedEntities.referenced_id
)


SELECT
  e_root.entity_id,
  re.root_view_name,
  e_root.execution_order AS root_view_execution_order,
  re.referenced_entity_name AS referenced_view_name,
  e.execution_order AS referenced_view_execution_order
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