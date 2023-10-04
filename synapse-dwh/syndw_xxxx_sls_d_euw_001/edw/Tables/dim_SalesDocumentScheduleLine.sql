CREATE TABLE [edw].[dim_SalesDocumentScheduleLine]
(
    [SalesDocumentID]					NVARCHAR(10) NOT NULL,
    [SalesDocumentItem]					CHAR(6) NOT NULL, --collate Latin1_General_100_BIN2 NOT NULL,
    [ScheduleLine]						CHAR(4) NOT NULL, --collate Latin1_General_100_BIN2 NOT NULL,
    [ScheduleLineCategory]				NVARCHAR(2),
    [OrderQuantityUnit]					NVARCHAR(3), -- collate Latin1_General_100_BIN2,
    [IsRequestedDelivSchedLine]			NVARCHAR(1),
    [RequestedDeliveryDate]				DATE,
    [ScheduleLineOrderQuantity]			DECIMAL(13,3),
    [CorrectedQtyInOrderQtyUnit]		DECIMAL(13,3),
    [IsConfirmedDelivSchedLine]			NVARCHAR(1),
    [ConfirmedDeliveryDate]				DATE,
    [ConfdOrderQtyByMatlAvailCheck]		DECIMAL(13,3),
    [ConfdSchedLineReqdDelivDate]		DATE,
    [ProductAvailabilityDate]		    DATE,
    [ScheduleLineConfirmationStatus]	NVARCHAR(1),
    [PlannedOrder]                      NVARCHAR(10),
    [OrderID]							NVARCHAR(12),
    [DeliveryCreationDate]				DATE,
    [GoodsIssueDate]				    DATE,
    [LoadingDate]				        DATE,
    [ItemIsDeliveryRelevant]			NVARCHAR(1),
    [DelivBlockReasonForSchedLine]		NVARCHAR(2),
    [DeliveredQtyInOrderQtyUnit]		DECIMAL(13,3),
    [DeliveredQuantityInBaseUnit]		DECIMAL(13,3),
    [DeliveryDate]                      DATE,
    [SalesOrganizationID]				NVARCHAR(4),
    [MaterialID]						NVARCHAR(40),
    [SoldToPartyID]						NVARCHAR(10),
    [SalesDocumentDate]					DATE,
    [t_applicationId]               VARCHAR(32)    NULL,
    [t_jobId]                       VARCHAR(36)    NULL,
    [t_jobDtm]                      DATETIME       NULL,
    [t_lastActionCd]                VARCHAR(1),
    [t_jobBy]                       NVARCHAR(128),
    CONSTRAINT [PK_dim_SalesDocumentScheduleLine] PRIMARY KEY NONCLUSTERED ([SalesDocumentID],[SalesDocumentItem],[ScheduleLine]) NOT ENFORCED
)
    WITH
        (
        DISTRIBUTION = REPLICATE, HEAP )
GO
