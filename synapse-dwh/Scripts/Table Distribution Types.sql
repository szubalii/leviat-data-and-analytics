SELECT 
  OBJECT_SCHEMA_NAME( object_id ) schemaName, 
  OBJECT_NAME( object_id ) tableName,
  *
FROM sys.pdw_table_distribution_properties
order by
  OBJECT_SCHEMA_NAME( object_id ),
  OBJECT_NAME( object_id )