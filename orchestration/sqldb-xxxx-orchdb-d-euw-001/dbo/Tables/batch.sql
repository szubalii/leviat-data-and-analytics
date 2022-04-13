CREATE TABLE [dbo].[batch] (
    [batch_id]                  UNIQUEIDENTIFIER DEFAULT (newid()) NOT NULL,
    [run_id]                    UNIQUEIDENTIFIER NOT NULL,
    [start_date_time]           DATETIME         DEFAULT (getdate()) NULL,
    [end_date_time]             DATETIME         NULL,
    [entity_id]                 BIGINT           NULL,
    [status_id]                 BIGINT           NOT NULL,
    [activity_id]               BIGINT           NOT NULL,
    [source_layer_id]           BIGINT           NOT NULL,
    [target_layer_id]           BIGINT           NOT NULL,
    [nr_of_records_read]        BIGINT           NULL,
    [nr_of_records_transferred] BIGINT           NULL,
    [size_bytes]                BIGINT           NULL,
    [file_path]                 VARCHAR (250)    NULL,
    [directory_path]            VARCHAR (250)    NULL,
    [file_name]                 VARCHAR (250)    NULL,
    PRIMARY KEY CLUSTERED ([batch_id] ASC),
    CONSTRAINT [FK_batch_activity] FOREIGN KEY ([activity_id]) REFERENCES [dbo].[batch_activity] ([activity_id]),
    CONSTRAINT [FK_batch_entity] FOREIGN KEY ([entity_id]) REFERENCES [dbo].[entity] ([entity_id]),
    CONSTRAINT [FK_batch_layer_source] FOREIGN KEY ([source_layer_id]) REFERENCES [dbo].[layer] ([layer_id]),
    CONSTRAINT [FK_batch_layer_target] FOREIGN KEY ([target_layer_id]) REFERENCES [dbo].[layer] ([layer_id]),
    CONSTRAINT [FK_batch_pipeline_log] FOREIGN KEY ([run_id]) REFERENCES [dbo].[pipeline_log] ([run_id]),
    CONSTRAINT [FK_batch_status] FOREIGN KEY ([status_id]) REFERENCES [dbo].[batch_execution_status] ([status_id])
);
