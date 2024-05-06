CREATE TABLE [dbo].[level] (
    [level_id] BIGINT       NOT NULL,
    [level_nk] VARCHAR (50) NOT NULL UNIQUE,
    PRIMARY KEY CLUSTERED ([level_id] ASC)
);
