-- Check if temp table already exists, if so drop it
IF OBJECT_ID('entity_tmp', 'U') IS NOT NULL
    DROP TABLE entity_tmp;

-- Create shallow copy of original table 
SELECT TOP 0 * INTO entity_tmp FROM dbo.entity;

-- Bulk insert data into temp table (does not work on actual #temp tables)
BULK INSERT entity_tmp
FROM 'entity.csv'
WITH (
    DATA_SOURCE = 'AzureBlobStorageOrchDB'
,   FIRSTROW = 2
,   FIELDTERMINATOR = ','
,   FORMAT = 'CSV'
);

-- Create a temporary table to hold the updated or inserted values
-- from the OUTPUT clause.  
--IF OBJECT_ID('entity_log', 'U') IS NOT NULL
--    TRUNCATE TABLE entity_log;

-- Merge data from temp table with original table
MERGE 
    entity AS tgt 
USING 
    (SELECT * FROM entity_tmp) AS src
ON 
    (tgt.entity_id = src.entity_id)
WHEN MATCHED AND (
	ISNULL(src.entity_name, '') <> ISNULL(tgt.entity_name, '')
    OR
    ISNULL(src.layer_id, 0) <> ISNULL(tgt.layer_id, 0)
    OR
    ISNULL(src.adls_container_name, '') <> ISNULL(tgt.adls_container_name, '')
    OR
    ISNULL(src.data_category, '') <> ISNULL(tgt.data_category, '')
    OR
    ISNULL(src.client_field, '') <> ISNULL(tgt.client_field, '')
    OR
    ISNULL(src.tool_name, '') <> ISNULL(tgt.tool_name, '')
    OR
    ISNULL(src.extraction_type, '') <> ISNULL(tgt.extraction_type, '')
    OR
    ISNULL(src.update_mode, '') <> ISNULL(tgt.update_mode, '')
    OR
    ISNULL(src.base_schema_name, '') <> ISNULL(tgt.base_schema_name, '')
    OR
    ISNULL(src.base_table_name, '') <> ISNULL(tgt.base_table_name, '')
    OR
    ISNULL(src.base_sproc_name, '') <> ISNULL(tgt.base_sproc_name, '')
    OR
    ISNULL(src.axbi_database_name, '') <> ISNULL(tgt.axbi_database_name, '')
    OR
    ISNULL(src.axbi_schema_name, '') <> ISNULL(tgt.axbi_schema_name, '')
    OR
    ISNULL(src.axbi_date_field_name, '') <> ISNULL(tgt.axbi_date_field_name, '')
    OR
    ISNULL(src.edw_sproc_schema_name, '') <> ISNULL(tgt.edw_sproc_schema_name, '')
    OR
    ISNULL(src.edw_sproc_name, '') <> ISNULL(tgt.edw_sproc_name, '')
    OR
    ISNULL(src.edw_source_schema_name, '') <> ISNULL(tgt.edw_source_schema_name, '')
    OR
    ISNULL(src.edw_source_view_name, '') <> ISNULL(tgt.edw_source_view_name, '')
    OR
    ISNULL(src.edw_dest_schema_name, '') <> ISNULL(tgt.edw_dest_schema_name, '')
    OR
    ISNULL(src.edw_dest_table_name, '') <> ISNULL(tgt.edw_dest_table_name, '')
    OR
    ISNULL(src.edw_execution_order, -1) <> ISNULL(tgt.edw_execution_order, -1)
    OR
    ISNULL(src.pk_field_names, '') <> ISNULL(tgt.pk_field_names, '')
    OR
    ISNULL(src.schedule_recurrence, '') <> ISNULL(tgt.schedule_recurrence, '')
    OR
    ISNULL(src.schedule_start_date, 0) <> ISNULL(tgt.schedule_start_date, 0)
    OR
    ISNULL(src.schedule_day, 0) <> ISNULL(tgt.schedule_day, 0)
) THEN
    UPDATE SET 
        entity_name		        = src.entity_name		
    ,   layer_id			    = src.layer_id			
    ,   adls_container_name     = src.adls_container_name
    ,   data_category		    = src.data_category		
    ,   client_field            = src.client_field            
    ,   tool_name			    = src.tool_name			
    ,   extraction_type	        = src.extraction_type	
    ,   update_mode		        = src.update_mode		
    ,   base_schema_name	    = src.base_schema_name	
    ,   base_table_name	        = src.base_table_name	
    ,   base_sproc_name	        = src.base_sproc_name	
    ,   axbi_database_name      = src.axbi_database_name
    ,   axbi_schema_name	    = src.axbi_schema_name	
    ,   axbi_date_field_name    = src.axbi_date_field_name
    ,   edw_sproc_schema_name   = src.edw_sproc_schema_name
    ,   edw_sproc_name	        = src.edw_sproc_name	
    ,   edw_source_schema_name  = src.edw_source_schema_name
    ,   edw_source_view_name    = src.edw_source_view_name
    ,   edw_dest_schema_name    = src.edw_dest_schema_name
    ,   edw_dest_table_name     = src.edw_dest_table_name
    ,   edw_execution_order     = src.edw_execution_order
    ,   pk_field_names               = src.pk_field_names
    ,   schedule_recurrence     = src.schedule_recurrence
    ,   schedule_start_date     = src.schedule_start_date
    ,   schedule_day            = src.schedule_day     
WHEN NOT MATCHED BY TARGET THEN
    INSERT (
        entity_id
    ,   entity_name
    ,   layer_id
    ,   adls_container_name
    ,   data_category
    ,   client_field
    ,   tool_name
    ,   extraction_type
    ,   update_mode
    ,   base_schema_name
    ,   base_table_name
    ,   base_sproc_name
    ,   axbi_database_name
    ,   axbi_schema_name
    ,   axbi_date_field_name
    ,   edw_sproc_schema_name
    ,   edw_sproc_name
    ,   edw_source_schema_name
    ,   edw_source_view_name
    ,   edw_dest_schema_name
    ,   edw_dest_table_name
    ,   edw_execution_order
    ,   pk_field_names
    ,   schedule_recurrence
    ,   schedule_start_date
    ,   schedule_day
    )
    VALUES (
        src.entity_id
    ,   src.entity_name
    ,   src.layer_id
    ,   src.adls_container_name
    ,   src.data_category
    ,   src.client_field
    ,   src.tool_name
    ,   src.extraction_type
    ,   src.update_mode
    ,   src.base_schema_name
    ,   src.base_table_name
    ,   src.base_sproc_name
    ,   src.axbi_database_name
    ,   src.axbi_schema_name
    ,   src.axbi_date_field_name
    ,   src.edw_sproc_schema_name
    ,   src.edw_sproc_name
    ,   src.edw_source_schema_name
    ,   src.edw_source_view_name
    ,   src.edw_dest_schema_name
    ,   src.edw_dest_table_name
    ,   src.edw_execution_order
    ,   src.pk_field_names
    ,   src.schedule_recurrence
    ,   src.schedule_start_date
    ,   src.schedule_day
    )
WHEN NOT MATCHED BY SOURCE THEN
    DELETE 
OUTPUT     
    Deleted.entity_id
,   Deleted.entity_name
,   Deleted.layer_id
,   Deleted.adls_container_name
,   Deleted.data_category
,   Deleted.client_field
,   Deleted.tool_name
,   Deleted.extraction_type
,   Deleted.update_mode
,   Deleted.base_schema_name
,   Deleted.base_table_name
,   Deleted.base_sproc_name
,   Deleted.axbi_database_name
,   Deleted.axbi_schema_name
,   Deleted.axbi_date_field_name
,   Deleted.edw_sproc_schema_name
,   Deleted.edw_sproc_name
,   Deleted.edw_source_schema_name
,   Deleted.edw_source_view_name
,   Deleted.edw_dest_schema_name
,   Deleted.edw_dest_table_name
,   Deleted.edw_execution_order
,   Deleted.pk_field_names
,   Deleted.schedule_recurrence
,   Deleted.schedule_start_date
,   Deleted.schedule_day
,   $action
,   Inserted.entity_id
,   Inserted.entity_name
,   Inserted.layer_id
,   Inserted.adls_container_name
,   Inserted.data_category
,   Inserted.client_field
,   Inserted.tool_name
,   Inserted.extraction_type
,   Inserted.update_mode
,   Inserted.base_schema_name
,   Inserted.base_table_name
,   Inserted.base_sproc_name
,   Inserted.axbi_database_name
,   Inserted.axbi_schema_name
,   Inserted.axbi_date_field_name
,   Inserted.edw_sproc_schema_name
,   Inserted.edw_sproc_name
,   Inserted.edw_source_schema_name
,   Inserted.edw_source_view_name
,   Inserted.edw_dest_schema_name
,   Inserted.edw_dest_table_name
,   Inserted.edw_execution_order
,   Inserted.pk_field_names
,   Inserted.schedule_recurrence
,   Inserted.schedule_start_date
,   Inserted.schedule_day
,   GETUTCDATE() INTO [log].entity;

-- drop temp tables
DROP TABLE entity_tmp;