CREATE TABLE [log].entity (
    [Existing_entity_id]				BIGINT
,   [Existing_entity_name]				VARCHAR(112)
,   [Existing_layer_id]					BIGINT
,   [Existing_adls_container_name]		VARCHAR(63)
,   [Existing_data_category]			VARCHAR(9)
,   [Existing_client_field]             VARCHAR(127)
,   [Existing_tool_name]				VARCHAR(8)
,   [Existing_extraction_type]			VARCHAR(5)
,   [Existing_update_mode]				VARCHAR(5)
,   [Existing_base_schema_name]			VARCHAR(128)
,   [Existing_base_table_name]			VARCHAR(112)
,   [Existing_base_sproc_name]			VARCHAR(128)
,   [Existing_axbi_database_name]		VARCHAR(128)
,   [Existing_axbi_schema_name]			VARCHAR(128)
,   [Existing_axbi_date_field_name]		VARCHAR(128)
,   [Existing_edw_sproc_schema_name]	VARCHAR(128)
,   [Existing_edw_sproc_name]			VARCHAR(128)
,   [Existing_edw_source_schema_name]	VARCHAR(128)
,   [Existing_edw_source_view_name]		VARCHAR(128)
,   [Existing_edw_dest_schema_name]		VARCHAR(128)
,   [Existing_edw_dest_table_name]		VARCHAR(112)
,   [Existing_edw_execution_order]		INT
,   [Existing_entity_pk]                VARCHAR(MAX)
,   [Existing_schedule_recurrence]		VARCHAR(5)
,   [Existing_schedule_start_date]		DATETIME
,   [Existing_schedule_day]             INT
,   ActionTaken nvarchar(10)
,   [New_entity_id]					BIGINT
,   [New_entity_name]				VARCHAR(112)
,   [New_layer_id]					BIGINT
,   [New_adls_container_name]		VARCHAR(63)
,   [New_data_category]				VARCHAR(9)
,   [New_client_field]              VARCHAR(127)
,   [New_tool_name]					VARCHAR(8)
,   [New_extraction_type]			VARCHAR(5)
,   [New_update_mode]				VARCHAR(5)
,   [New_base_schema_name]			VARCHAR(128)
,   [New_base_table_name]			VARCHAR(112)
,   [New_base_sproc_name]			VARCHAR(128)
,   [New_axbi_database_name]		VARCHAR(128)
,   [New_axbi_schema_name]			VARCHAR(128)
,   [New_axbi_date_field_name]		VARCHAR(128)
,   [New_edw_sproc_schema_name]		VARCHAR(128)
,   [New_edw_sproc_name]			VARCHAR(128)
,   [New_edw_source_schema_name]	VARCHAR(128)
,   [New_edw_source_view_name]		VARCHAR(128)
,   [New_edw_dest_schema_name]		VARCHAR(128)
,   [New_edw_dest_table_name]		VARCHAR(112)
,   [New_edw_execution_order]		INT
,   [New_entity_pk]                 VARCHAR(MAX)
,   [New_schedule_recurrence]		VARCHAR(5)
,   [New_schedule_start_date]		DATETIME
,   [New_schedule_day]              INT
,   t_jobDtm                        DATETIME
); 