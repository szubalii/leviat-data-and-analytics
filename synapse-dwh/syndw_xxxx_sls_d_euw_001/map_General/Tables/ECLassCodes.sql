CREATE TABLE [map_General].[EClassCodes]
( 
    [MaterialGroupID]           NVARCHAR (16)  NOT NULL,
    [EClassCode]                NVARCHAR(8)    NOT NULL,
    [EClassCategory]            NVARCHAR(64),
    [EClassCategoryDescription] NVARCHAR(128),
    CONSTRAINT [PK_map_EClassCodes] PRIMARY KEY NONCLUSTERED ([MaterialGroupID]) NOT ENFORCED
)
WITH
(
    DISTRIBUTION = REPLICATE,
    HEAP
)
GO