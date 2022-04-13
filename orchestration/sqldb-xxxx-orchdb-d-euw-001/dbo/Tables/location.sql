CREATE TABLE [dbo].[location] (
    [location_id]          BIGINT        NOT NULL,
    [location_nk]          VARCHAR (50)  NOT NULL UNIQUE,
    [location_description] VARCHAR (250) NULL,
    PRIMARY KEY CLUSTERED ([location_id] ASC)
);

