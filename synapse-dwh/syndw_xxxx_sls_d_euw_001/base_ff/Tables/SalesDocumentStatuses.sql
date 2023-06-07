CREATE TABLE [base_ff].[SalesDocumentStatuses]
(
    [Status]                VARCHAR(32)  NOT NULL,
    [OrderType]             INT  NOT NULL,
    [DeliveryStatus]        NVARCHAR(1),
    [InvoiceStatus]         NVARCHAR(1),
    [OrderTypeText]         NVARCHAR(32),
    [t_applicationId]            VARCHAR(32),
    [t_jobId]                    VARCHAR(36),
    [t_jobDtm]                   DATETIME,
    [t_jobBy]                    NVARCHAR(128) ,
    [t_filePath]                 NVARCHAR(1024),
    CONSTRAINT [PK_SalesDocumentStatuses] PRIMARY KEY NONCLUSTERED ([Status], [OrderType], [DeliveryStatus],[InvoiceStatus]) NOT ENFORCED,
)
WITH (
    DISTRIBUTION = REPLICATE,
    HEAP
)
GO