CREATE TABLE [base_ff].[SalesDocumentStatuses]
(
    [Status]                NVARCHAR(16)  NOT NULL,
    [OrderType]             INT  NOT NULL,
    [DeliveryStatus]        NVARCHAR(1),
    [InvoiceStatus]         NVARCHAR(1),
    [OrderTypeText]         NVARCHAR(32),
    CONSTRAINT [PK_SalesDocumentStatuses] PRIMARY KEY NONCLUSTERED ([Status], [OrderType], [DeliveryStatus],[InvoiceStatus]) NOT ENFORCED,
)
WITH (
    DISTRIBUTION = REPLICATE,
    HEAP
)
GO