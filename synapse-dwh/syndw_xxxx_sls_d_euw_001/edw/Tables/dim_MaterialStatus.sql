CREATE TABLE [edw].[dim_MaterialStatus]
(   
    [MaterialStatusID]              NCHAR(2)    NOT NULL,
    [Purchaising]                   NCHAR(1),
    [BOMHeader]                     NCHAR(1),
    [BOMItem]                       NCHAR(1),
    [Routing]                       NCHAR(1),
    [Requirement]                   NCHAR(1),
    [MRP]                           NCHAR(1),
    [ProductionOrder]               NCHAR(1),
    [ProductionOrderHeader]         NCHAR(1),
    [PlantMaintenance]              NCHAR(1),
    [InventoryMaintenance]          NCHAR(1),
    [Forecasting]                   NCHAR(1),
    [PRT]                           NCHAR(1),
    [QM]                            NCHAR(1),
    [PostingChange]                 NCHAR(1),
    [WMTransferOrder]               NCHAR(1),
    [ProcedureCreating]             NCHAR(1),
    [Planning]                      NCHAR(1),
    [DistributionLock]              NCHAR(1),
    [ProfileName]                   NVARCHAR(10),
    [CrossPlantStatus]              NVARCHAR(25),
    [Language]                      NCHAR(1),
    [t_applicationId]               VARCHAR(32),
    [t_jobId]                       VARCHAR(36),
    [t_jobDtm]                      DATETIME,
    [t_lastActionCd]                VARCHAR(1),
    [t_jobBy]                       NVARCHAR(128),
    CONSTRAINT [PK_dim_MaterialStatus] PRIMARY KEY NONCLUSTERED ([MaterialStatusID]) NOT ENFORCED
)
    WITH
        (
        DISTRIBUTION = REPLICATE, HEAP )
GO