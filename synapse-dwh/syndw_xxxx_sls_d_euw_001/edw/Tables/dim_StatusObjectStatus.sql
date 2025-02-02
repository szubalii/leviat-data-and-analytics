CREATE TABLE [edw].[dim_StatusObjectStatus]
(
    [StatusObjectStatusID] NVARCHAR(22) NOT NULL,
    [UserStatus]           nvarchar(30) NOT NULL,
    [UserStatusShort]      nvarchar(8) NOT NULL, 
    [StatusProfile]        nvarchar(8),
    [StatusIsActive]       nvarchar(1),
    [StatusIsInactive]     nvarchar(1),
    [t_applicationId]      VARCHAR(32)                                  NULL,
    [t_jobId]              VARCHAR(36)                                  NULL,
    [t_jobDtm]             DATETIME                                     NULL,
    [t_lastActionCd]       VARCHAR(1),
    [t_jobBy]              NVARCHAR(128),
    CONSTRAINT [PK_dim_StatusObjectStatus] PRIMARY KEY NONCLUSTERED ([StatusObjectStatusID]) NOT ENFORCED
)
    WITH
        (
        DISTRIBUTION = REPLICATE, HEAP )
GO