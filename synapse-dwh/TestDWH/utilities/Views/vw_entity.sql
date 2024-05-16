CREATE VIEW utilities.vw_entity
AS 

SELECT
  -- [key]+1 AS [column_id], -- array index starts at 0, so add 1
  -- JSON_VALUE(value, '$.edw.entities') AS [name] -- get the column name from parquet
  -- [entity_id], 
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



-- select *
-- from utilities.vw_entity
-- where source_view_name is not null
-- order by source_view_name