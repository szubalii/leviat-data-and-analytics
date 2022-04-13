CREATE TABLE [dbo].[error_category]
(
    [error_category_id]     BIGINT          NOT NULL,
    [category_nk]			VARCHAR(50)     NOT NULL UNIQUE,
	[category_description]	VARCHAR (250)	NULL,
    PRIMARY KEY CLUSTERED ([error_category_id] ASC)
);

