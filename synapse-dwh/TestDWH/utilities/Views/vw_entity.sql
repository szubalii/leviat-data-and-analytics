CREATE VIEW utilities.vw_entity
AS 

/*
  This view allows to read the entity config located in 
  the file from orchestration/src/config/global/entity.json.

  This file is added to the SQL DB created in the PR triggered 
  Azure DevOps Pipeline called TEST Synapse DWH
*/

SELECT
  JSON_VALUE(value, '$.entity_id') AS entity_id,
  JSON_VALUE(value, '$.entity_name') AS entity_name,
  JSON_VALUE(value, '$.source_view_name') AS source_view_name,
  JSON_VALUE(value, '$.dest_table_name') AS dest_table_name,
  JSON_VALUE(value, '$.execution_order') AS execution_order,
  JSON_VALUE(value, '$.schedule_recurrence') AS schedule_recurrence
FROM
  OPENJSON((
    SELECT BulkColumn
    FROM OPENROWSET(BULK '/config/global/entity.json', SINGLE_CLOB) as j
  ), '$.edw.entities') e
