CREATE TABLE [dbo].[upload_type] (
    [upload_type_id]			BIGINT			NOT NULL,
    [loading_type_nk]			VARCHAR (50)	NOT NULL UNIQUE,
	[loading_type_description]	VARCHAR (250)	NULL,
);

