CREATE TABLE [edw].[dim_PurgAccAssignment](
      [MANDT]                 NCHAR(3)        NOT NULL
    , [PurchaseOrder]         NVARCHAR(10)    NOT NULL
    , [PurchaseOrderItem]     NCHAR(5)        NOT NULL
    , [SequentialNumberOfAccountAssignment]   NCHAR(2)  NOT NULL
    , [GLAccountID]           NVARCHAR(10)
    , [CostCenterID]          NVARCHAR(10)
    , [ICSalesDocumentID]     NVARCHAR(10)
    , [ICSalesDocumentItemID] NVARCHAR(10)
    , [t_applicationId]       VARCHAR(32)
    , [t_jobId]               VARCHAR(36)
    , [t_jobDtm]              DATETIME
    , [t_lastActionCd]        VARCHAR(1)
    , [t_jobBy]               NVARCHAR(128)
    , CONSTRAINT [PK_PurgAccAssignment] PRIMARY KEY NONCLUSTERED (
        [MANDT],
        [PurchaseOrder],
        [PurchaseOrderItem],
        [SequentialNumberOfAccountAssignment]
    ) NOT ENFORCED 
)
WITH
(
    DISTRIBUTION = REPLICATE,
    HEAP
)
GO
