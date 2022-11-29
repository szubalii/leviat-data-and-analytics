CREATE TABLE [base_isedio].[INVOICEDFREIGHT_ISUK](
	[Accountingdate]            [DATETIME]          NOT NULL,
	[InvoicedFreightLocal]      [DECIMAL](38, 12)   NULL,
	[PackingSlipID]             [NVARCHAR](20)      NOT NULL,
	[t_applicationId]           [VARCHAR](32)       NULL,
    [t_jobId]                   [VARCHAR](36)       NULL,
    [t_jobDtm]                  [DATETIME],
    [t_jobBy]                   [NVARCHAR](128)     NULL,
    [t_extractionDtm]           [DATETIME],
    [t_filePath]                [NVARCHAR](1024)    NULL,
    CONSTRAINT [PK_INVOICEDFREIGHT_ISUK] PRIMARY KEY NONCLUSTERED (
	[Accountingdate],[PackingSlipID]
) NOT ENFORCED
) WITH (HEAP, DISTRIBUTION = ROUND_ROBIN)