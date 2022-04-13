CREATE TABLE [dbo].[layer] (
    [layer_id]          BIGINT        NOT NULL,
    [layer_nk]          VARCHAR (50)  NOT NULL UNIQUE,
    [location_id]       BIGINT        NOT NULL,
    [layer_description] VARCHAR (250) NULL,
    PRIMARY KEY CLUSTERED ([layer_id] ASC),
    CONSTRAINT [FK_layer_location_type] FOREIGN KEY ([location_id]) REFERENCES [dbo].[location] ([location_id])
);

