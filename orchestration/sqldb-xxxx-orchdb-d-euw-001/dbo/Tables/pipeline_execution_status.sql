CREATE TABLE [dbo].[pipeline_execution_status] (
    [status_id]				BIGINT			NOT NULL,
    [status_nk]				VARCHAR (50)	NOT NULL UNIQUE,
    [status_description]	VARCHAR (250)	NULL,
    PRIMARY KEY CLUSTERED ([status_id] ASC)
);

