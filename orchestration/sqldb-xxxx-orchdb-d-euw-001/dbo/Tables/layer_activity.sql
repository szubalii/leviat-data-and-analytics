CREATE TABLE [dbo].[layer_activity] (
  [layer_id] BIGINT NOT NULL,
  [activity_id] BIGINT NOT NULL,
  PRIMARY KEY CLUSTERED ([layer_id], [activity_id] ASC),
  CONSTRAINT [FK_layer_activity_layer] FOREIGN KEY ([layer_id]) REFERENCES [dbo].[layer] ([layer_id]),
  CONSTRAINT [FK_layer_activity_activity] FOREIGN KEY ([activity_id]) REFERENCES [dbo].[activity] ([activity_id])
);
