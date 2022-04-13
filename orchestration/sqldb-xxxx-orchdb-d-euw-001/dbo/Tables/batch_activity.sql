CREATE TABLE [dbo].[batch_activity] (
    [activity_id]          BIGINT        NOT NULL,
    [activity_nk]          VARCHAR (50)  NOT NULL UNIQUE,
    [activity_description] VARCHAR (250) NULL,
    [activity_order] SMALLINT NULL,
    [is_deprecated] BIT NULL,
    PRIMARY KEY CLUSTERED ([activity_id] ASC)
);
