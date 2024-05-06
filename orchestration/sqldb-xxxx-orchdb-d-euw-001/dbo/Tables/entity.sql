CREATE TABLE [dbo].[entity]
(
    [entity_id]					BIGINT NOT NULL,
    [entity_name]				VARCHAR(112),
    [level_id]                  BIGINT NOT NULL,
    [layer_id]					BIGINT NOT NULL,
    [adls_container_name]		VARCHAR(63),
    [data_category]				VARCHAR(11),
    [client_field]              VARCHAR(127),
    [tool_name]					VARCHAR(8),
    [extraction_type]			VARCHAR(5),
    [update_mode]				VARCHAR(5),
    [base_schema_name]			VARCHAR(128),
    [base_table_name]			VARCHAR(112),
	[base_sproc_name]			VARCHAR(128),
    [axbi_database_name]		VARCHAR(128), -- TODO change to source
    [axbi_schema_name]			VARCHAR(128),
    [axbi_date_field_name]		VARCHAR(128),
	[sproc_schema_name]		VARCHAR(128),
	[sproc_name]			VARCHAR(128),
	[source_schema_name]	VARCHAR(128),
	[source_view_name]		VARCHAR(128),
	[dest_schema_name]		VARCHAR(128),
	[dest_table_name]		VARCHAR(112),
	[execution_order]		INT,	
    [pk_field_names]            VARCHAR(MAX),
	[schedule_recurrence]		VARCHAR(5),
    [schedule_start_date]		DATETIME,
    [schedule_day]              INT,

    PRIMARY KEY CLUSTERED ([entity_id] ASC),
    CONSTRAINT [FK_entity_layer] FOREIGN KEY ([layer_id]) REFERENCES [dbo].[layer] ([layer_id]),
    CONSTRAINT [FK_entity_level] FOREIGN KEY ([level_id]) REFERENCES [dbo].[level] ([level_id])
);

						
