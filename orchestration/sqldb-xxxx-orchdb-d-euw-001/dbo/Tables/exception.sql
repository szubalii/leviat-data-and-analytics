CREATE TABLE [dbo].[exception]
(
    [exception_id]      BIGINT IDENTITY (1, 1)       NOT NULL,
    [run_id]            UNIQUEIDENTIFIER             NOT NULL,
    [error_timestamp]   DATETIME DEFAULT (getdate()) NULL,
    [error_category_id] BIGINT                       NOT NULL,
    [entity_id]         BIGINT   DEFAULT (NULL)      NULL,
    [batch_id]          UNIQUEIDENTIFIER             NULL, 
    [pbi_dataset_id]    BIGINT   DEFAULT (NULL)      NULL, 
    [error_message]     NVARCHAR(MAX)                NOT NULL,
    PRIMARY KEY CLUSTERED ([exception_id] ASC),
    CONSTRAINT [FK_exception_batch] FOREIGN KEY ([batch_id]) REFERENCES [dbo].[batch] ([batch_id]),
    CONSTRAINT [FK_exception_entity] FOREIGN KEY ([entity_id]) REFERENCES [dbo].[entity] ([entity_id]),
    CONSTRAINT [FK_exception_error_category] FOREIGN KEY ([error_category_id]) REFERENCES [dbo].[error_category] ([error_category_id]),
    CONSTRAINT [FK_exception_pipeline_log] FOREIGN KEY ([run_id]) REFERENCES [dbo].[pipeline_log] ([run_id]),
    CONSTRAINT [FK_exception_pbi_dataset] FOREIGN KEY ([pbi_dataset_id]) REFERENCES [dbo].[pbi_dataset] ([pbi_dataset_id])
);
