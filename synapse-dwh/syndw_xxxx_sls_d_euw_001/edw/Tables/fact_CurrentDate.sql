CREATE TABLE [edw].[fact_CurrentDate]
( 
    [today]           DATE  NOT NULL
)
WITH
(
    DISTRIBUTION = REPLICATE,
    HEAP 
)
GO