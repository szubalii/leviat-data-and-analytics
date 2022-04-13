CREATE TABLE [dbo].[pipeline] (
    [pipeline_id]			BIGINT			NOT NULL,
    [pipeline_name_nk]		VARCHAR (140)	NOT NULL UNIQUE,
	[pipeline_description]	VARCHAR (250)	NULL,
    [parent_pipeline_id]	BIGINT			NULL,
    [pipeline_order]		INT				NULL,
    PRIMARY KEY CLUSTERED ([pipeline_id] ASC),
    CONSTRAINT [FK_pipeline_parent_pipeline] FOREIGN KEY ([parent_pipeline_id]) REFERENCES [dbo].[pipeline] ([pipeline_id])
);

