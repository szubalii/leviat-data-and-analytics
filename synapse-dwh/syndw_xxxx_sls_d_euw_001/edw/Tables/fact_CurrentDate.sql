CREATE TABLE [edw].[fact_CurrentDate]
( 
    [today]                             DATE  NOT NULL,
    [t_jobId]                           VARCHAR(36),
    [t_jobDtm]                          DATETIME,
    [t_lastActionCd]                    VARCHAR(1),
    [t_jobBy]                           VARCHAR(128)
)
WITH
(
    DISTRIBUTION = REPLICATE,
    HEAP 
)
GO