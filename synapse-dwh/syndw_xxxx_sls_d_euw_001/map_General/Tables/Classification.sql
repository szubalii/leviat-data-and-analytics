CREATE TABLE [map_General].[Classification]
( 
    [MaterialGroupName] NVARCHAR (64)   NOT NULL,
    [Classification]    NVARCHAR(8)     NOT NULL,
    CONSTRAINT [PK_map_Classification] PRIMARY KEY NONCLUSTERED ([MaterialGroupName]) NOT ENFORCED
)
WITH
(
    DISTRIBUTION = REPLICATE,
    HEAP
)
GO