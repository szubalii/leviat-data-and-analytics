CREATE TABLE [base_dw_halfen_2_dwh].[FACT_HGPLUM_Archive]
(
    [DW_Id]               BIGINT         NOT NULL,
    [Company]             NVARCHAR(8)    NULL,
    [Salesarea]           NVARCHAR(10)   NULL,
    [Distributioncompany] NVARCHAR(8)    NULL,
    [Year]                BIGINT         NULL,
    [Month]               BIGINT         NULL,
    [Accountingdate]      DATETIME       NULL,
    [Inside_Outside]      NVARCHAR(1)    NULL,
    [Customerno]          NVARCHAR(10)   NULL,
    [Salesdistrict]       NVARCHAR(10)   NULL,
    [Itemno]              NVARCHAR(50)   NULL,
    [Productrange]        NVARCHAR(10)   NULL,
    [Productline]         NVARCHAR(10)   NULL,
    [Budget]              DECIMAL(38, 6) NULL,
    [BudgetEUR]           DECIMAL(38, 6) NULL,
    [Maindistrict]        NCHAR(2)       NULL,
    [CRHProductgroupID]   NVARCHAR(10)   NULL,
    [DW_Batch]            BIGINT         NULL,
    [DW_SourceCode]       VARCHAR(15)    NOT NULL,
    [DW_TimeStamp]        DATETIME       NOT NULL,
    [t_applicationId]     VARCHAR(32)    NULL,
    [t_jobId]             VARCHAR(36)    NULL,
    [t_jobDtm]            DATETIME,
    [t_jobBy]             NVARCHAR(128)  NULL,
    [t_extractionDtm]     DATETIME,
    [t_filePath]          NVARCHAR(1024) NULL
        CONSTRAINT [PK_FACT_HGPLUM_Archive] PRIMARY KEY NONCLUSTERED ([DW_Id] ASC) NOT ENFORCED
)
WITH
(
	DISTRIBUTION = HASH ([Customerno]),
	CLUSTERED COLUMNSTORE INDEX
);