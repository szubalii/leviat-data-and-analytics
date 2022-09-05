CREATE TABLE [edw].[dim_WorkCenterCapacity]
(
    [WorkCenterInternalID]      CHAR(8) NOT NULL,
    [Plant]                     NVARCHAR(4),
    [WorkCenter]                NVARCHAR(8),
    [WorkCenterCategoryCode]    NVARCHAR(4),
    [CapacityInternalID]        CHAR(8),
    [CapacityCategoryCode]      NVARCHAR(3),
    [ValidityStartDate]         DATE,
    [ValidityEndDate]           DATE,
    [CapacityBreakDuration]     INT,
    [CapacityStartTime]         INT,
    [CapacityEndTime]           INT,
    [DailyCapacityHrs]          INT,
    [CapacityCategoryName]      NVARCHAR(40),
    [t_applicationId]           VARCHAR(32),
    [t_jobId]                   VARCHAR(36),
    [t_jobDtm]                  DATETIME,
    [t_lastActionCd]            VARCHAR(1),
    [t_jobBy]                   NVARCHAR(128),
    [t_extractionDtm]           DATETIME
    CONSTRAINT [PK_dim_WorkCenterCapacity] PRIMARY KEY NONCLUSTERED ([WorkCenterInternalID]) NOT ENFORCED
)
    WITH
        (
        DISTRIBUTION = REPLICATE, HEAP )
GO