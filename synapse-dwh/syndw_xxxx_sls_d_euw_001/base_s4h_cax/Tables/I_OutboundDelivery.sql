CREATE TABLE [base_s4h_cax].[I_OutboundDelivery] (
  [MANDT] char(3) NOT NULL
, [OutboundDelivery] nvarchar(10) NOT NULL
, [DeliveryDocumentType] nvarchar(4)
, [CreatedByUser] nvarchar(12)
, [CreationDate] date
, [CreationTime] time
, [LastChangedByUser] nvarchar(12)
, [LastChangeDate] date
, [ShippingPoint] nvarchar(4)
, [SalesOrganization] nvarchar(4)
, [SalesOffice] nvarchar(4)
, [CompleteDeliveryIsDefined] nvarchar(1)
, [OrderCombinationIsAllowed] nvarchar(1)
, [DeliveryPriority] char(2)
, [DeliveryBlockReason] nvarchar(2)
, [Supplier] nvarchar(10)
, [DeliveryDocumentBySupplier] nvarchar(35)
, [DeliveryIsInPlant] nvarchar(1)
, [ReceivingPlant] nvarchar(4)
, [Warehouse] nvarchar(3)
, [IsExportDelivery] nvarchar(1)
, [OrderID] nvarchar(12)
, [HeaderGrossWeight] decimal(15,3)
, [HeaderNetWeight] decimal(15,3)
, [HeaderWeightUnit] nvarchar(3)
, [HeaderVolume] decimal(15,3)
, [HeaderVolumeUnit] nvarchar(3)
, [DocumentDate] date
, [PickingDate] date
, [PickingTime] time
, [TotalNumberOfPackage] char(5)
, [LoadingPoint] nvarchar(2)
, [LoadingDate] date
, [LoadingTime] time
, [BillOfLading] nvarchar(35)
, [HandlingUnitInStock] nvarchar(1)
, [ShipToParty] nvarchar(10)
, [ShippingType] nvarchar(2)
, [DeliveryDate] date
, [DeliveryTime] time
, [ShippingCondition] nvarchar(2)
, [ShipmentBlockReason] nvarchar(2)
, [TransportationPlanningDate] date
, [TransportationPlanningTime] time
, [ProposedDeliveryRoute] nvarchar(6)
, [ActualDeliveryRoute] nvarchar(6)
, [RouteSchedule] nvarchar(10)
, [PlannedGoodsIssueDate] date
, [GoodsIssueTime] time
, [ActualGoodsMovementDate] date
, [ActualGoodsMovementTime] time
, [IncotermsClassification] nvarchar(3)
, [IncotermsTransferLocation] nvarchar(28)
, [ExternalTransportSystem] nvarchar(5)
, [TransportationGroup] nvarchar(4)
, [MeansOfTransport] nvarchar(20)
, [MeansOfTransportType] nvarchar(4)
, [UnloadingPointName] nvarchar(25)
, [ProofOfDeliveryDate] date
, [ConfirmationTime] time
, [FactoryCalendarByCustomer] nvarchar(2)
, [BillingDocumentDate] date
, [HeaderBillingBlockReason] nvarchar(2)
, [SoldToParty] nvarchar(10)
, [CustomerGroup] nvarchar(2)
, [SalesDistrict] nvarchar(6)
, [TransactionCurrency] char(5)
, [OverallIntcoBillingStatus] nvarchar(1)
, [OverallSDProcessStatus] nvarchar(1)
, [TotalBlockStatus] nvarchar(1)
, [OverallDelivConfStatus] nvarchar(1)
, [TransportationPlanningStatus] nvarchar(1)
, [OverallPickingConfStatus] nvarchar(1)
, [OverallPickingStatus] nvarchar(1)
, [OverallPackingStatus] nvarchar(1)
, [OverallWarehouseActivityStatus] nvarchar(1)
, [DistrStatusByDecentralizedWrhs] nvarchar(1)
, [OverallGoodsMovementStatus] nvarchar(1)
, [OverallDelivReltdBillgStatus] nvarchar(1)
, [OverallProofOfDeliveryStatus] nvarchar(1)
, [HdrGeneralIncompletionStatus] nvarchar(1)
, [HeaderDelivIncompletionStatus] nvarchar(1)
, [HeaderPickgIncompletionStatus] nvarchar(1)
, [HeaderPackingIncompletionSts] nvarchar(1)
, [HdrGoodsMvtIncompletionStatus] nvarchar(1)
, [HeaderBillgIncompletionStatus] nvarchar(1)
, [OvrlItmGeneralIncompletionSts] nvarchar(1)
, [OvrlItmPackingIncompletionSts] nvarchar(1)
, [OvrlItmPickingIncompletionSts] nvarchar(1)
, [OvrlItmDelivIncompletionSts] nvarchar(1)
, [OvrlItmGdsMvtIncompletionSts] nvarchar(1)
, [TotalCreditCheckStatus] nvarchar(1)
, [FinDocCreditCheckStatus] nvarchar(1)
, [PaytAuthsnCreditCheckSts] nvarchar(1)
, [CentralCreditCheckStatus] nvarchar(1)
, [ExprtInsurCreditCheckStatus] nvarchar(1)
, [ShippingGroupNumber] nvarchar(10)
, [PricingDocument] nvarchar(10)
, [SalesOrgForIntcoBilling] nvarchar(4)
, [DistrChnlForIntcoBilling] nvarchar(2)
, [DivisionForIntcoBilling] nvarchar(2)
, [IntercompanyBillingType] nvarchar(4)
, [FactoryCalendarForIntcoBilling] nvarchar(2)
, [IntercompanyBillingCustomer] nvarchar(10)
, [DeliveryDocumentCondition] nvarchar(10)
, [TotalNetAmount] decimal(15,2)
, [ReferenceDocumentNumber] nvarchar(25)
, [DeletionIndicator] nvarchar(1)
, [OverallChmlCmplncStatus] nvarchar(1)
, [OverallDangerousGoodsStatus] nvarchar(1)
, [OverallSafetyDataSheetStatus] nvarchar(1)
, [t_applicationId]       VARCHAR (32)
, [t_jobId]               VARCHAR (36)
, [t_jobDtm]              DATETIME
, [t_jobBy]        		  NVARCHAR (128)
, [t_extractionDtm]		  DATETIME
, [t_filePath]            NVARCHAR (1024)
, CONSTRAINT [PK_I_OutboundDelivery] PRIMARY KEY NONCLUSTERED (
    [MANDT], [OutboundDelivery]
  ) NOT ENFORCED
)
WITH (
  HEAP
)
