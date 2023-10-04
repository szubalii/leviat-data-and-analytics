CREATE TABLE [base_s4h_cax].[I_SalesDocumentScheduleLine](
  [MANDT] char(3) NOT NULL --collate Latin1_General_100_BIN2 NOT NULL
, [SalesDocument] nvarchar(10) NOT NULL
, [SalesDocumentItem] char(6) NOT NULL --collate Latin1_General_100_BIN2 NOT NULL
, [ScheduleLine] char(4) NOT NULL --collate Latin1_General_100_BIN2 NOT NULL
, [ScheduleLineCategory] nvarchar(2)
, [OrderQuantityUnit] nvarchar(3) -- collate Latin1_General_100_BIN2
, [OrderToBaseQuantityDnmntr] decimal(5)
, [OrderToBaseQuantityNmrtr] decimal(5)
, [BaseUnit] nvarchar(3) -- collate Latin1_General_100_BIN2
, [DeliveryDate] date
, [DelivDateCategory] nvarchar(1)
, [IsRequestedDelivSchedLine] nvarchar(1)
, [RequestedDeliveryDate] date
, [RequestedDeliveryTime] time(0)
, [ScheduleLineOrderQuantity] decimal(13,3)
, [CorrectedQtyInOrderQtyUnit] decimal(13,3)
, [IsConfirmedDelivSchedLine] nvarchar(1)
, [ConfirmedDeliveryDate] date
, [ConfirmedDeliveryTime] time(0)
, [ConfdOrderQtyByMatlAvailCheck] decimal(13,3)
, [ConfdSchedLineReqdDelivDate] date
, [ProductAvailabilityDate] date
, [ProductAvailabilityTime] time(0)
, [ProductAvailCheckRqmtDate] date
, [ProdAvailabilityCheckRqmtType] nvarchar(2)
, [ProdAvailyCheckPlanningType] nvarchar(1)
, [ScheduleLineConfirmationStatus] nvarchar(1)
, [RequirementsClass] nvarchar(3)
, [PlannedOrder] nvarchar(10)
, [OrderID] nvarchar(12)
, [SchedulingAgreementReleaseType] nvarchar(1)
, [ScheduleLineByForecastDelivery] char(10) -- collate Latin1_General_100_BIN2
, [OrderSchedulingGroup] char(4) -- collate Latin1_General_100_BIN2
, [PurchaseRequisition] nvarchar(10)
, [PurchaseRequisitionItem] char(5) -- collate Latin1_General_100_BIN2
, [PurchasingOrderType] nvarchar(4)
, [PurchasingDocumentCategory] nvarchar(1)
, [DeliveryCreationDate] date
, [TransportationPlanningDate] date
, [TransportationPlanningTime] time(0)
, [GoodsIssueDate] date
, [LoadingDate] date
, [GoodsIssueTime] time(0)
, [LoadingTime] time(0)
, [ItemIsDeliveryRelevant] nvarchar(1)
, [DelivBlockReasonForSchedLine] nvarchar(2)
, [OpenReqdDelivQtyInOrdQtyUnit] decimal(13,3)
, [OpenReqdDelivQtyInBaseUnit] decimal(13,3)
, [OpenConfdDelivQtyInOrdQtyUnit] decimal(13,3)
, [OpenConfdDelivQtyInBaseUnit] decimal(13,3)
, [DeliveredQtyInOrderQtyUnit] decimal(13,3)
, [DeliveredQuantityInBaseUnit] decimal(13,3)
, [RequestedRqmtQtyInBaseUnit] decimal(15,3)
, [ConfirmedRqmtQtyInBaseUnit] decimal(15,3)
, [GoodsMovementType] nvarchar(3)
, [RouteSchedule] nvarchar(10)
, [OpenDeliveryNetAmount] decimal(15,2)
, [TransactionCurrency] char(5) -- collate Latin1_General_100_BIN2
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
