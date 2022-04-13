CREATE PROC [edw].[sp_load_dim_SalesDocumentScheduleLine]
      @t_jobId [varchar](36)
    , @t_jobDtm [datetime]
    , @t_lastActionCd [varchar](1)
    , @t_jobBy [nvarchar](128)
AS
BEGIN

    IF OBJECT_ID('syndw_xxxx_sls_d_euw_001.edw.dim_SalesDocumentScheduleLine', 'U') IS NOT NULL TRUNCATE TABLE [edw].[dim_SalesDocumentScheduleLine]

    INSERT INTO [edw].[dim_SalesDocumentScheduleLine](
        [SalesDocumentID]
        ,[SalesDocumentItem]
        ,[ScheduleLine]
        ,[ScheduleLineCategory]
        ,[OrderQuantityUnit]
        ,[IsRequestedDelivSchedLine]
        ,[RequestedDeliveryDate]
        ,[ScheduleLineOrderQuantity]
        ,[CorrectedQtyInOrderQtyUnit]
        ,[IsConfirmedDelivSchedLine]
        ,[ConfirmedDeliveryDate]
        ,[ConfdOrderQtyByMatlAvailCheck]
        ,[ConfdSchedLineReqdDelivDate]
        ,[ProductAvailabilityDate]
        ,[ScheduleLineConfirmationStatus]
        ,[PlannedOrder]
        ,[OrderID]
        ,[DeliveryCreationDate]
        ,[GoodsIssueDate]
        ,[LoadingDate]
        ,[ItemIsDeliveryRelevant]
        ,[DelivBlockReasonForSchedLine]
        ,[DeliveredQtyInOrderQtyUnit]
        ,[DeliveredQuantityInBaseUnit]
        ,[SalesOrganizationID]
        ,[MaterialID]
        ,[SoldToPartyID]
        ,[SalesDocumentDate]
        ,[t_applicationId]
        ,[t_jobId]
        ,[t_jobDtm]
        ,[t_lastActionCd]
        ,[t_jobBy])
    SELECT 
        [SalesDocumentID]
        ,[SalesDocumentItem]
        ,[ScheduleLine]
        ,[ScheduleLineCategory]
        ,[OrderQuantityUnit]
        ,[IsRequestedDelivSchedLine]
        ,[RequestedDeliveryDate]
        ,[ScheduleLineOrderQuantity]
        ,[CorrectedQtyInOrderQtyUnit]
        ,[IsConfirmedDelivSchedLine]
        ,[ConfirmedDeliveryDate]
        ,[ConfdOrderQtyByMatlAvailCheck]
        ,[ConfdSchedLineReqdDelivDate]
        ,[ProductAvailabilityDate]
        ,[ScheduleLineConfirmationStatus]
        ,[PlannedOrder]
        ,[OrderID]
        ,[DeliveryCreationDate]
        ,[GoodsIssueDate]
        ,[LoadingDate]
        ,[ItemIsDeliveryRelevant]
        ,[DelivBlockReasonForSchedLine]
        ,[DeliveredQtyInOrderQtyUnit]
        ,[DeliveredQuantityInBaseUnit]
        ,[SalesOrganizationID]
        ,[MaterialID]
        ,[SoldToPartyID]
        ,[SalesDocumentDate]
        ,[t_applicationId]
        ,@t_jobId                              AS t_jobId
        ,@t_jobDtm                             AS t_jobDtm
        ,@t_lastActionCd                       AS t_lastActionCd
        ,@t_jobBy                              AS t_jobBy
    FROM
        [edw].[vw_SalesDocumentScheduleLine]
END
