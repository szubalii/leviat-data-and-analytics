CREATE TABLE [edw].[dim_PurgAccAssignment](
        [MANDT]                 NCHAR(3)        COLLATE Latin1_General_100_BIN2 NOT NULL
    ,   [PurchaseOrder]         NVARCHAR(10)    COLLATE Latin1_General_100_BIN2 NOT NULL
    ,   [PurchaseOrderItem]     NCHAR(5)        COLLATE Latin1_General_100_BIN2 NOT NULL
    ,   [SequentialNumberOfAccountAssignment]   NCHAR(2)  COLLATE Latin1_General_100_BIN2 NOT NULL
    ,   [GLAccountID]           NVARCHAR(10)    COLLATE Latin1_General_100_BIN2
    ,   [CostCenterID]          NVARCHAR(10)    COLLATE Latin1_General_100_BIN2
    ,   [ICSalesDocumentID]     NVARCHAR(10)    COLLATE Latin1_General_100_BIN2 
    ,   [ICSalesDocumentItemID] NVARCHAR(10)    COLLATE Latin1_General_100_BIN2 
    ,   [t_applicationId]       VARCHAR(32)
    ,   [t_jobId]               VARCHAR(36)
    ,   [t_jobDtm]              DATETIME
    ,   [t_jobBy]               NVARCHAR(128)
    ,   [t_filePath]            NVARCHAR(1024)
    ,   [t_extractionDtm]       DATETIME
    ,   CONSTRAINT [PK_PurgAccAssignment] PRIMARY KEY NONCLUSTERED(
            [MANDT],
            [PurchaseOrder],
            [PurchaseOrderItem],
            [SequentialNumberOfAccountAssignment]
        )NOT ENFORCED 
)
WITH
(
    DISTRIBUTION = REPLICATE,
    HEAP
)
GO