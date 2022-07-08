CREATE TABLE [dbo].[pbi_log] (
    [pbi_refresh_guid]          UNIQUEIDENTIFIER DEFAULT (newid()) NOT NULL,
    [pbi_dataset_id]            BIGINT NOT NULL,
    [run_id]                    UNIQUEIDENTIFIER NOT NULL,
    [start_date_time]           DATETIME         DEFAULT (getdate()) NULL,
    [end_date_time]             DATETIME         NULL,
    [status_id]                 BIGINT           NOT NULL,
    [message]                 NVARCHAR (4000)    NULL,
    PRIMARY KEY CLUSTERED ([pbi_refresh_guid] ASC),
    CONSTRAINT [FK_pbi_dataset_id] FOREIGN KEY ([pbi_dataset_id]) REFERENCES [dbo].[pbi_dataset] ([pbi_dataset_id]),
    CONSTRAINT [FK_pbi_pipeline_log] FOREIGN KEY ([run_id]) REFERENCES [dbo].[pipeline_log] ([run_id]),
    CONSTRAINT [FK_pbi_status] FOREIGN KEY ([status_id]) REFERENCES [dbo].[batch_execution_status] ([status_id])
);