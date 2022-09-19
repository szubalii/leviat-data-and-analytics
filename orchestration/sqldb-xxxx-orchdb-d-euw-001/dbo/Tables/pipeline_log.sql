CREATE TABLE [dbo].[pipeline_log] (
    [run_id]          UNIQUEIDENTIFIER NOT NULL,
    [parent_run_id]   VARCHAR (36)     NULL,
    [pipeline_id]     BIGINT           NOT NULL,
    [start_date_time] DATETIME         NULL,
    [end_date_time]   DATETIME         NULL,
    [status_id]       BIGINT           NOT NULL,
    [user_name]       VARCHAR (250)    NULL,
    [message]         NVARCHAR (MAX)   NULL,
    [parameters]      NVARCHAR (MAX)   NULL,
    PRIMARY KEY CLUSTERED ([run_id] ASC),
    CONSTRAINT [FK_pipeline_logs_execution_status_status] FOREIGN KEY ([status_id]) REFERENCES [dbo].[pipeline_execution_status] ([status_id]),
    CONSTRAINT [FK_pipeline_logs_pipeline] FOREIGN KEY ([pipeline_id]) REFERENCES [dbo].[pipeline] ([pipeline_id])
);
