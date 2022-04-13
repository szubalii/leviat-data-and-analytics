CREATE TABLE [edw].[dim_ValueType]
(
    [ValueTypeID]     char(5)      NOT NULL,
    [ValueType]       NVARCHAR(30) NULL,
    [t_applicationId] VARCHAR(32)  NULL,
    [t_jobId]         VARCHAR(36)  NULL,
    [t_jobDtm]        DATETIME     NULL,
    [t_lastActionCd]  VARCHAR(1),   
    [t_jobBy]         NVARCHAR(128)
        CONSTRAINT [PK_dim_ValueType] PRIMARY KEY NONCLUSTERED ([ValueTypeID]) NOT ENFORCED
)
    WITH
        (
        DISTRIBUTION = REPLICATE, HEAP )
GO