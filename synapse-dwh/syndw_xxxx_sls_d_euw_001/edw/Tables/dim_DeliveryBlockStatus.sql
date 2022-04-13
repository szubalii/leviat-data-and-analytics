CREATE TABLE [edw].[dim_DeliveryBlockStatus]
(
    [DeliveryBlockStatusID]    NVARCHAR(8)  NOT NULL,
    [DeliveryBlockStatus]      NVARCHAR(40) NULL,
    [t_applicationId]          VARCHAR(32),
    [t_jobId]                  VARCHAR(36),
    [t_jobDtm]                 DATETIME,
    [t_lastActionCd]           VARCHAR(1),
    [t_jobBy]                  NVARCHAR(128),
    CONSTRAINT [PK_dim_DeliveryBlockStatus] PRIMARY KEY NONCLUSTERED ([DeliveryBlockStatusID]) NOT ENFORCED
)
    WITH
        (
        DISTRIBUTION = REPLICATE, HEAP )
GO