CREATE TABLE [base_ff_USA].[Budget] (
        [SalesOrganizationID]       NVARCHAR(24)
    ,   [MaterialID]                NVARCHAR(80)
    ,   [InvoiceDate]               DATETIME
    ,   [Currency]                  CHAR(3)
    ,   [NetAmount]                 DECIMAL(28,12)
    ,   [t_applicationId]           VARCHAR(32)
    ,   [t_jobId]                   VARCHAR(36)
    ,   [t_jobDtm]                  DATETIME
    ,   [t_jobBy]                   VARCHAR(128)
    ,   [t_filePath]                NVARCHAR(1024)
    ,   CONSTRAINT [PK_USA_Budget] PRIMARY KEY NONCLUSTERED ([SalesOrganizationID],[MaterialID],[InvoiceDate]) NOT ENFORCED
)
WITH (
  HEAP
)
GO