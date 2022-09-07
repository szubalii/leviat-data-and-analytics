CREATE VIEW [dm_sales].[vw_fact_ManufacturingOrder]
AS
SELECT
        MFGO.[ManufacturingOrder]
    ,   MFGO.[ManufacturingOrderCategory]
    ,   MFGO.[ManufacturingOrderCategoryName]
    ,   MFGO.[ManufacturingOrderOperation]
    ,   MFGO.[OpActualExecutionStartDate]
    ,   MFGO.[OpActualExecutionStartTime]
    ,   MFGO.[OpActualExecutionEndDate]
    ,   MFGO.[OpActualExecutionEndTime]
    ,   MFGO.[OrderIsDelivered]
    ,   MFGO.[OrderIsPartiallyDelivered]
    ,   MFGO.[SalesOrder]
    ,   MFGO.[SalesOrderItem]
    ,   ODI.[HDR_ActualGoodsMovementDate]
    ,   MFGO.[Material]
    ,   MFGO.[MfgOrderPlannedTotalQty]
    ,   MFGO.[MfgOrderPlannedScrapQty]
    ,   MFGO.[MfgOrderConfirmedYieldQty]
    ,   MFGO.[MfgOrderConfirmedScrapQty]
    ,   MFGO.[ActualDeliveredQuantity]
    ,   MFGO.[ProductConfiguration]
    ,   MFGO.[WorkCenterID]
    ,   MFGO.[WorkCenter]
    ,   MFGO.[OrderIsClosed]
    ,   MFGO.[OrderIsMarkedForDeletion]
    ,   MFGO.[OrderIsCreated]
    ,   MFGO.[OrderIsReleased]
    ,   MFGO.[OrderIsPrinted]
    ,   MFGO.[OrderIsConfirmed]
    ,   MFGO.[OrderIsPartiallyConfirmed]
    ,   MFGO.[OrderIsLocked]
    ,   MFGO.[MfgOrderCreationDate]
    ,   MFGO.[MfgOrderCreationTime]
    ,   MFGO.[OpErlstSchedldExecStrtTme]
    ,   MFGO.[OpErlstSchedldExecStrtDte]
    ,   MFGO.[OpErlstSchedldExecEndDte]
    ,   MFGO.[OpErlstSchedldExecEndTme]
    ,   MFGO.[ProductionPlant]
    ,   MFGO.[OperationUnit]
    ,   MFGO.[t_applicationId]
    ,   MFGO.[t_extractionDtm]
FROM
    [edw].[fact_ManufacturingOrder] MFGO
LEFT JOIN
    [base_s4h_cax].[I_MfgOrderWithStatus] MFGOWS
    ON
        MFGO.[ManufacturingOrder] = MFGOWS.[ManufacturingOrder]
LEFT JOIN
    [edw].[vw_OutboundDeliveryItem_s4h] ODI
    ON 
        MFGOWS.[SalesOrder] = ODI.[ReferenceSDDocument]
        AND
        MFGOWS.[SalesOrderItem] = ODI.[ReferenceSDDocumentItem]