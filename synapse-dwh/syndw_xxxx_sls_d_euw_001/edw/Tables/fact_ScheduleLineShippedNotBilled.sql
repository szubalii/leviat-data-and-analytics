CREATE TABLE [edw].[fact_ScheduleLineShippedNotBilled] (
    [sk_fact_ScheduleLineShippedNotBilled]                    BIGINT NOT NULL,
    [SalesDocumentID]                                         nvarchar(20) NOT NULL,
    [SalesDocumentItem]                                       nvarchar(24) NOT NULL,
    [ReportDate]                                              date NOT NULL,
    [CompanyCodeID]                                           NVARCHAR(8),
    [SalesDocumentTypeID]                                     nvarchar(4),
    [SDDocumentRejectionStatusID]                             nvarchar(1),
    [IsUnconfirmedDelivery]                                   nvarchar(1),
    [CurrencyTypeID]                                          char(2),
    [ScheduleLine]                                            char(4) NOT NULL,
    [SalesDocumentOrderType]                                  varchar(35),
    [OrderStatus]                                             varchar(32),
    [ItemOrderStatus]                                         varchar(32),
    [SLDeliveryStatus]                                        varchar(1),
    [SLInvoicedStatus]                                        varchar(1),
    [SLStatus]                                                varchar(32),
    [CreationDate]                                            datetime2(7),
    [RequestedDeliveryDate]                                   date,
    [ConfirmedDeliveryDate]                                   date,
    [SDI_ODB_LatestActualGoodsMovmtDate]                      date,
    [DelivBlockReasonForSchedLine]                            nvarchar(2),
    [LoadingDate]                                             date,
    [ConfirmedQty]                                            decimal(13,3),
    [TotalOrderQty]                                           decimal(15,3),
    [TotalDelivered]                                          decimal(38,12),
    [SDSLOrderQtyRunningSum]                                  decimal(13,3),
    [ValueConfirmedQuantity]                                  decimal(38,11),
    [CurrencyID]                                              char(5),
    [BillingQuantity]                                         decimal(38,3),
    [ShippingConditionID]                                     nvarchar(2),
    [ScheduleLineCategory]                                    nvarchar(2),
    [NetAmount]                                               decimal(19,6),
    [OpenDeliveryValue]                                       decimal(38,6),
    [ClosedDeliveryValue]                                     decimal(38,6),
    [OpenInvoicedValue]                                       decimal(38,6),
    [ClosedInvoicedValue]                                     decimal(38,6),
    [PricePerUnit]                                            decimal(38,6),
    [InScope]                                                 varchar(1),
    [SoldToPartyID]                                           nvarchar(10),
    [t_applicationId]                                         VARCHAR(32),
    [t_extractionDtm]                                         DATETIME,
    [t_jobId]                                                 VARCHAR(36),
    [t_jobDtm]                                                DATETIME,
    [t_lastActionCd]                                          VARCHAR(1),
    [t_jobBy]                                                 VARCHAR(128),
    CONSTRAINT [PK_fact_ScheduleLineShippedNotBilled] PRIMARY KEY NONCLUSTERED ([SalesDocumentID], [SalesDocumentItem], [ScheduleLine], [ReportDate]) NOT ENFORCED
)
WITH (
    DISTRIBUTION = HASH ([SalesDocumentID]), CLUSTERED COLUMNSTORE INDEX
)