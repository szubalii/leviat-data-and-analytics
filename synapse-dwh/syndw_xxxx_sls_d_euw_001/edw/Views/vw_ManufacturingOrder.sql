CREATE VIEW [edw].[vw_ManufacturingOrder]
AS
SELECT
        MFGO.[ManufacturingOrder]
    ,   MFGO.[ManufacturingOrderCategory] AS [ManufacturingOrderCategoryID]
    ,   MNGCT.[ManufacturingOrderCategoryName] AS [ManufacturingOrderCategory]
    ,   MFGOPR.[ManufacturingOrderOperation]
    ,   MFGOPR.[OpActualExecutionStartDate]
    ,   MFGOPR.[OpActualExecutionStartTime]
    ,   MFGOPR.[OpActualExecutionEndDate]
    ,   MFGOPR.[OpActualExecutionEndTime]
    ,   MFGOWS.[OrderIsDelivered]
    ,   MFGOWS.[OrderIsPartiallyDelivered]
    ,   MFGOWS.[SalesOrder]
    ,   MFGOWS.[SalesOrderItem]
    ,   ODI.[HDR_ActualGoodsMovementDate]
    ,   MFGO.[Material]
    ,   MFGO.[MfgOrderPlannedTotalQty]
    ,   MFGO.[MfgOrderPlannedScrapQty]
    ,   MFGO.[MfgOrderConfirmedYieldQty]
    ,   MFGO.[MfgOrderConfirmedScrapQty]
    ,   MFGO.[ActualDeliveredQuantity]
    ,   MFGO.[ProductConfiguration]
    ,   MFGOPR.[WorkCenterInternalID] AS [WorkCenterID]
    ,   MFGOPR.[WorkCenter]
    ,   MFGOWS.[OrderIsClosed]
    ,   MFGOWS.[OrderIsMarkedForDeletion]
    ,   MFGOWS.[OrderIsCreated]
    ,   MFGOWS.[OrderIsReleased]
    ,   MFGOWS.[OrderIsPrinted]
    ,   MFGOWS.[OrderIsConfirmed]
    ,   MFGOWS.[OrderIsPartiallyConfirmed]
    ,   MFGOWS.[OrderIsLocked]
    ,   MFGO.[MfgOrderCreationDate]
    ,   MFGO.[MfgOrderCreationTime]
    ,   MFGOPR.[OpErlstSchedldExecStrtTme]
    ,   MFGOPR.[OpErlstSchedldExecStrtDte]
    ,   MFGOPR.[OpErlstSchedldExecEndDte]
    ,   MFGOPR.[OpErlstSchedldExecEndTme]
    ,   MFGO.[ProductionPlant]
    ,   MFGOPR.[OperationUnit]
    ,   MFGO.[t_applicationId]
    ,   MFGO.[t_extractionDtm]
FROM
    [base_s4h_cax].[C_MngProdnOrderMfgOrder] MFGO
LEFT JOIN
    [base_s4h_cax].[C_MfgOrderObjPgOpr] MFGOPR
    ON
        MFGO.[ManufacturingOrder] = MFGOPR.[ManufacturingOrder]
LEFT JOIN
    [base_s4h_cax].[I_MfgOrderWithStatus] MFGOWS
    ON
        MFGO.[ManufacturingOrder] = MFGOWS.[ManufacturingOrder]
LEFT JOIN
    [edw].[fact_OutboundDeliveryItem] ODI
    ON 
        MFGOWS.[SalesOrder] = ODI.[ReferenceSDDocument]
        AND
        MFGOWS.[SalesOrderItem] = ODI.[ReferenceSDDocumentItem]
        AND 
        MFGOWS.[SalesOrder] <>''
        AND
        MFGOWS.[SalesOrderItem] <>'000000'
LEFT JOIN
    [base_s4h_cax].[I_MfgOrderCategoryText] MNGCT
    ON
        MFGO.[ManufacturingOrderCategory] = MNGCT.[ManufacturingOrderCategory]
        AND
        MNGCT.[Language] = 'E'