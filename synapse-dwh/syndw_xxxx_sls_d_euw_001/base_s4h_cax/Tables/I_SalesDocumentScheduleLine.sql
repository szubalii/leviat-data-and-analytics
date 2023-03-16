CREATE TABLE [base_s4h_cax].[I_SalesDocumentScheduleLine](
  [MANDT] char(3) collate Latin1_General_100_BIN2 NOT NULL
, [SalesDocument] nvarchar(10) NOT NULL
, [SalesDocumentItem] char(6) collate Latin1_General_100_BIN2 NOT NULL
, [ScheduleLine] char(4) collate Latin1_General_100_BIN2 NOT NULL
, [ScheduleLineCategory] nvarchar(2)
, [ItemIsDeliveryRelevant] nvarchar(1)
, [DeliveryDate] date
, [ScheduleLineOrderQuantity] decimal(13,3)
, [ConfdOrderQtyByMatlAvailCheck] decimal(13,3)
, [OrderQuantityUnit] nvarchar(3) collate Latin1_General_100_BIN2
, [BaseUnit] nvarchar(3) collate Latin1_General_100_BIN2
, [ProductAvailCheckRqmtDate] date
, [ProdAvailabilityCheckRqmtType] nvarchar(2)
, [ProdAvailyCheckPlanningType] nvarchar(1)
, [PurchaseRequisition] nvarchar(10)
, [PurchasingOrderType] nvarchar(4)
, [PurchasingDocumentCategory] nvarchar(1)
, [ScheduleLineConfirmationStatus] nvarchar(1)
, [DelivDateCategory] nvarchar(1)
, [TransportationPlanningDate] date
, [ProductAvailabilityDate] date
, [LoadingDate] date
, [GoodsIssueDate] date
, [CorrectedQtyInOrderQtyUnit] decimal(13,3)
, [DelivBlockReasonForSchedLine] nvarchar(2)
, [SchedulingAgreementReleaseType] nvarchar(1)
, [ScheduleLineByForecastDelivery] char(10) collate Latin1_General_100_BIN2
, [OrderToBaseQuantityNmrtr] decimal(5)
, [OrderToBaseQuantityDnmntr] decimal(5)
, [GoodsMovementType] nvarchar(3)
, [PurchaseRequisitionItem] char(5) collate Latin1_General_100_BIN2
, [OrderID] nvarchar(12)
, [PlannedOrder] nvarchar(10)
, [ProductAvailabilityTime] time(0)
, [TransportationPlanningTime] time(0)
, [LoadingTime] time(0)
, [GoodsIssueTime] time(0)
, [RouteSchedule] nvarchar(10)
, [DeliveredQuantityInBaseUnit] decimal(13,3)
, [DeliveredQtyInOrderQtyUnit] decimal(13,3)
, [OpenConfdDelivQtyInBaseUnit] decimal(13,3)
, [OpenConfdDelivQtyInOrdQtyUnit] decimal(13,3)
, [OpenReqdDelivQtyInBaseUnit] decimal(13,3)
, [OpenReqdDelivQtyInOrdQtyUnit] decimal(13,3)
, [DeliveryCreationDate] date
, [ConfdSchedLineReqdDelivDate] date
, [RequirementsClass] nvarchar(3)
, [TransactionCurrency] char(5) collate Latin1_General_100_BIN2
, [OpenDeliveryNetAmount] decimal(15,2)
, [RequestedRqmtQtyInBaseUnit] decimal(15,3)
, [ConfirmedRqmtQtyInBaseUnit] decimal(15,3)
, [OrderSchedulingGroup] char(4) collate Latin1_General_100_BIN2
, [IsRequestedDelivSchedLine] nvarchar(1)
, [IsConfirmedDelivSchedLine] nvarchar(1)
, [RequestedDeliveryDate] date
, [ConfirmedDeliveryDate] date
, [RequestedDeliveryTime] time(0)
, [ConfirmedDeliveryTime] time(0)
, [t_applicationId]       VARCHAR (32)
, [t_jobId]               VARCHAR (36)
, [t_jobDtm]              DATETIME
, [t_jobBy]        		  NVARCHAR (128)
, [t_extractionDtm]		  DATETIME
, [t_filePath]            NVARCHAR (1024)
, CONSTRAINT [PK_I_SalesDocumentScheduleLine] PRIMARY KEY NONCLUSTERED (
    [MANDT], [SalesDocument], [SalesDocumentItem], [ScheduleLine]
  ) NOT ENFORCED
)
WITH (
  HEAP
)
